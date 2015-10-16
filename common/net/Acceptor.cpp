#include "stdafx.h"
#include "Acceptor.h"
#include "ErrorEnum.h"
#include "boost\mpl\assert.hpp"
#include "boost\bind.hpp"
#include "PublicFunc.h"

Acceptor::Acceptor(const char* ip, unsigned int port, unsigned int prepare_accept_socket_count)
	:Acceptor_Connector_Base(ip, port)
	,_max_prepare_accept_count(prepare_accept_socket_count)
	,_acceptor(NULL)
{
}

Acceptor::~Acceptor(void)
{
	ReleaseResource();
}

void Acceptor::ReleaseResource()
{
	SAFE_DELETE1(_acceptor, close);
	Acceptor_Connector_Base::ReleaseResource();
}

void* Acceptor::Initialize(ReceiveManager* recvMng)
{
	if(recvMng == NULL){
		ASSERT_THROW;
	}

	if(Acceptor_Connector_Base::Initialize(recvMng) != (void*)mc_system::err::SUCCESS){
		ASSERT_THROW;
	}

	_acceptor = new boost::asio::ip::tcp::acceptor(*_io_service, _endpoint, true);

	for (unsigned int j=0; j<_max_prepare_accept_count; ++j)
	{
		if(PostAccept(_acceptor) != mc_system::SUCCESS){
			ASSERT_THROW;
		}
	}

	return (void*)mc_system::err::SUCCESS;
}

bool Acceptor::Start()
{
#if SIC
	printf("Thread and acceptor have been launched successfully.\n");
#endif

	//只有在调试模式下设置线程名称有效
	mc_system_public_function::SetThreadName(::GetCurrentThreadId(), __FUNCTION__);

	//////////////////////////////////////////////////////////////////////////
	boost::system::error_code tmp_error_code;

	_is_run = true;
	_io_service->run(tmp_error_code);
	_is_run = false;

#if SIC
	printf("Thread and acceptor have been stopped.\n");
#endif

	return tmp_error_code == 0;
}

bool Acceptor::Stop()
{
	ReleaseResource();

#if SIC
	printf("acceptor has been stopped.\n");
#endif

	return true;
}

int Acceptor::PostAccept( boost::asio::ip::tcp::acceptor* acceptor )
{
	boost::asio::ip::tcp::socket* tmpSocket = new boost::asio::ip::tcp::socket(*_io_service);
	acceptor->async_accept(*tmpSocket, boost::bind(&Acceptor::accept_handler, this, tmpSocket, _1));

	return mc_system::SUCCESS;
}

void Acceptor::accept_handler( _pmy_socket socket, const boost::system::error_code& error )
{
	if(error != boost::system::errc::success)
	{
#if SIC
		printf("accept_handler(...) error, error code:%d.\n", error.value());
		printf("error info:%s.\n", error.message());
#endif
		SAFE_DELETE1(socket, close);
	}
	else
	{
#if SIC
		printf("there is client connected.\n");
		printf("client ip:port:[%s:%d].\n", socket->remote_endpoint().address().to_string().c_str(), (int)socket->remote_endpoint().port());
#endif
		//let socket object puts socket_manager
		Acceptor_Connector_Base::PostRecvAndFirst(socket);
	}

	//continue to post accept
	PostAccept(_acceptor);
}

