#include "stdafx.h"
#include "Connector.h"
#include "boost/bind.hpp"
#include "ErrorEnum.h"


Connector::Connector( const char* ip, unsigned int port )
	:Acceptor_Connector_Base(ip, port)
{
}

Connector::~Connector(void)
{
	Stop();
}

void* Connector::Initialize(ReceiveManager* recv_mng)
{
	if(Acceptor_Connector_Base::Initialize(recv_mng) != (void*)mc_system::err::SUCCESS){
		ASSERT_THROW;
	}

	if(!ConnectServer()){
		Acceptor_Connector_Base::ReleaseResource();
	}

	//if failed, the _socket is null
	return _socket;
}

bool Connector::ConnectServer()
{
	if(CreateSocket() == NULL){
		throw;
	}

	boost::system::error_code tmp_err_code;
	_socket->connect(_endpoint, tmp_err_code);

	if(tmp_err_code == boost::system::errc::success)
	{
		Acceptor_Connector_Base::PostRecvAndFirst(_socket);

#ifdef SIC
		printf("[%s] connect server successfully.\n", __FUNCTION__);
#endif
	}
	else
	{
		SAFE_DELETE1(_socket, close);

#ifdef SIC
		printf("[%s] connect server failed.\n", __FUNCTION__);
#endif
	}

	return tmp_err_code == 0;
}

_pmy_socket Connector::CreateSocket()
{
	_socket = new _my_socket(*_io_service, _endpoint.protocol());
	if(_socket == NULL){
		throw;
	}

	boost::system::error_code tmp_err_code;
	_socket->set_option(boost::asio::socket_base::reuse_address(true), tmp_err_code);
	assert(tmp_err_code == boost::system::errc::success);

	boost::asio::socket_base::linger tmp_linger(true, 0);
	_socket->set_option(tmp_linger, tmp_err_code);
	assert(tmp_err_code == boost::system::errc::success);

	return _socket;
}

bool Connector::Start()
{
	//只有在调试模式下设置线程名称有效
	mc_system_public_function::SetThreadName(::GetCurrentThreadId(), __FUNCTION__);

	boost::system::error_code tmp_err_code;

	_is_run = true;
	_io_service->run(tmp_err_code);
	_is_run = false;

#if SIC
	printf("[%s] connection had been terminated. error code:%d, description:%s\n", __FUNCTION__, tmp_err_code.value(), tmp_err_code.message());
#endif

	return tmp_err_code == boost::system::errc::success;
}

bool Connector::Stop()
{
	//由socket管理器否则维护, @see Acceptor_Connector_Base::PostRecvAndFirst(_pmy_socket socket)
	//SAFE_DELETE1(_socket, close);

	   /**	oiooooio, 2014-7-14, version:1.0
		*	如果在这里卡着不动，说明_io_service有事件储留，一般来说，很有可能是RECV事件
		*	当ReceiveManager::Receive收到消息后，如果没有消息队列管理器，直接在此函数
		*	中把事件向上层派发，如果在DoData过程中，调用执行到Connector::Stop，则必卡
		*	在此处，因为如果要删除/停止此类对象，_io_service必须要停止_socket的异步接收，
		*	而此时正停留在DoData过程中，函数没有办法返回，也没有办法投递异步接收，所以删除
		*	_io_service时，都会在_io_service.reset()被挂起。
		*
		*	***	删除/停止此类对象时，必须要让异步接收操作正常投递工作以及完成所有的发送操作
		*	***	如一定要在DoData删除/停止此类对象，那么可以开一个线程操作，让DoData立即返
		*		回以及完成所有的发送操作
		**/
	Acceptor_Connector_Base::ReleaseResource();
	
	return false;
}

void Connector::SocketCloseNotify(_pmy_socket socket, int EventID)
{
	if(!_is_run){
		return;
	}

	//////////////////////////////////////////////////////////////////////////
	//尝试重建socket对象，重新连接服务器(未做)

#if SIC
	printf("[%s] socket closed. socket:%p, EventID:%d.\n", (void*)socket, EventID);
#endif
}

