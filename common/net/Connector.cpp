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
	//ֻ���ڵ���ģʽ�������߳�������Ч
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
	//��socket����������ά��, @see Acceptor_Connector_Base::PostRecvAndFirst(_pmy_socket socket)
	//SAFE_DELETE1(_socket, close);

	   /**	oiooooio, 2014-7-14, version:1.0
		*	��������￨�Ų�����˵��_io_service���¼�������һ����˵�����п�����RECV�¼�
		*	��ReceiveManager::Receive�յ���Ϣ�����û����Ϣ���й�������ֱ���ڴ˺���
		*	�а��¼����ϲ��ɷ��������DoData�����У�����ִ�е�Connector::Stop����ؿ�
		*	�ڴ˴�����Ϊ���Ҫɾ��/ֹͣ�������_io_service����Ҫֹͣ_socket���첽���գ�
		*	����ʱ��ͣ����DoData�����У�����û�а취���أ�Ҳû�а취Ͷ���첽���գ�����ɾ��
		*	_io_serviceʱ��������_io_service.reset()������
		*
		*	***	ɾ��/ֹͣ�������ʱ������Ҫ���첽���ղ�������Ͷ�ݹ����Լ�������еķ��Ͳ���
		*	***	��һ��Ҫ��DoDataɾ��/ֹͣ���������ô���Կ�һ���̲߳�������DoData������
		*		���Լ�������еķ��Ͳ���
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
	//�����ؽ�socket�����������ӷ�����(δ��)

#if SIC
	printf("[%s] socket closed. socket:%p, EventID:%d.\n", (void*)socket, EventID);
#endif
}

