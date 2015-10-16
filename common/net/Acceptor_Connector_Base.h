/*
 *	author:wl(oiooooio)
 *	time:2014/8/12
 *
 *	Acceptor_Connector_Base:
 *	as a base class for Connector and Acceptor
 *	
 *	继承此类的子类，在继承此类的虚函数以及重写时，需要调用非纯虚函数的虚函数。
 *	
 */

#pragma once

#include "IdentifiersDefine.h"
#include "boost/asio.hpp"
#include "ReceiveManager.h"

class Acceptor_Connector_Base
{
protected:
	Acceptor_Connector_Base(const char* ip, unsigned int port);
	virtual ~Acceptor_Connector_Base(void);

protected:
	virtual void* Initialize(ReceiveManager* recvMng);
	virtual void  SocketCloseNotify(_pmy_socket socket, int EventID);
	virtual void  ReleaseResource();
	virtual void  PostRecvAndFirst(_pmy_socket socket);

	virtual bool  Start() = 0;
	virtual bool  Stop() = 0;

private:
	virtual void  SocketCloseNotify_(_pmy_socket socket, int EventID);

protected:
	char _ip[IP_V4_LEN_END_SYMBOL];
	unsigned int _port;
	boost::asio::ip::tcp::endpoint _endpoint;

	boost::shared_ptr<boost::asio::io_service> _io_service;

	ReceiveManager*	_receive_manager;
	boost::shared_ptr<SocketManager> _socket_manager;

	bool _is_run;
};

