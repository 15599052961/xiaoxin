#include "stdafx.h"
#include "Acceptor_Connector_Base.h"
#include <assert.h>
#include "SocketManager.h"
#include "ErrorEnum.h"


Acceptor_Connector_Base::Acceptor_Connector_Base(const char* ip, unsigned int port)
	:_receive_manager(NULL)
	,_socket_manager(NULL)
	,_is_run(false)
	,_io_service(NULL)
{
	assert(ip != NULL && port > 1000);

	memset(_ip, 0, IP_V4_LEN_END_SYMBOL);

	_port = port;
	strcpy_s(_ip, IP_V4_LEN, ip);
	_ip[IP_V4_LEN] = 0;

	_endpoint = boost::asio::ip::tcp::endpoint(boost::asio::ip::address_v4::from_string(ip), port);
}


Acceptor_Connector_Base::~Acceptor_Connector_Base(void)
{
	Acceptor_Connector_Base::ReleaseResource();
}

/// <summary>
/// �����ڳ�ʼ��ʱ���ȵ��û���Ĵ˷���
/// </summary>
/// <param name="recvMng">The recv MNG.</param>
/// <returns>void *.</returns>
void* Acceptor_Connector_Base::Initialize(ReceiveManager* recvMng)
{
	_socket_manager = boost::shared_ptr<SocketManager>(new SocketManager(__FUNCTION__));
	if(_socket_manager == NULL){
		throw;
	}

	if(!_socket_manager->Init(boost::bind(&Acceptor_Connector_Base::SocketCloseNotify_, this, _1, _2))){
		throw;
	}

	_receive_manager = recvMng;
	if(_receive_manager == NULL){
		throw;
	}

	_io_service = boost::shared_ptr<boost::asio::io_service>(new boost::asio::io_service);
	if(_io_service == NULL){
		throw;
	}

	return (void*)mc_system::err::SUCCESS;
}

void Acceptor_Connector_Base::SocketCloseNotify_(_pmy_socket socket, int EventID)
{
	//��ΪSocketCloseNotify���麯��������ڰ󶨺���ʱ��ֱ�Ӱ�SocketCloseNotify�����ܻ����ֻ���ô����SocketCloseNotify��
	//��û�е��������SocketCloseNotify��������Ҫ����
	SocketCloseNotify(socket, EventID);
}

void Acceptor_Connector_Base::SocketCloseNotify(_pmy_socket socket, int EventID)
{
	//socket closed notify
}

void Acceptor_Connector_Base::ReleaseResource()
{
	_is_run = false;

	if(_socket_manager != NULL){
		_socket_manager->ClearAll();
		_socket_manager.reset();
	}

	if(_io_service != NULL){
		_io_service->stop();
		_io_service.reset();
	}
	
	SAFE_DELETE(_receive_manager);
}

void Acceptor_Connector_Base::PostRecvAndFirst(_pmy_socket socket)
{
	if(socket != NULL){
		_socket_manager->Add(socket);
		_receive_manager->PostReceive(socket);
		_receive_manager->First(socket);
	}
	else{
		ASSERT_THROW;
	}
}

bool Acceptor_Connector_Base::Start()
{
	ASSERT_THROW;
}

bool Acceptor_Connector_Base::Stop()
{
	ASSERT_THROW;
}


