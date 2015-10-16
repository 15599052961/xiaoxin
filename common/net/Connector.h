/*
 *	author:wl(oiooooio)
 *
 *	Connector:
 *	**	着重强调一下此类的使用范围：此类主要是用于单个套接字连接服务器的，也就是在此类当中，会建立一个socket去连接服务器，
 *		如果此socket断开连接，则会马上重新申请一个socket对象再次连接服务器，保持与服务器的通信。(未做)
 *
 *	**	目前此类主要负责各个服务器直接的交互，如登陆服务器需要连接中间服务器去获取子服务器列表，子服务器需连接中间服务器去
 *		告知中间服务器对自己的一个注册，以便中间服务器通知登陆服务器有子服务器在线等。这些操作都只需要一个连接即可。
 *
 *	**	如果需要一个Connector持有很多socket去连接服务器，那么在测试客户端（TestSendTextMessage），有一个BigConne
 *		ctor类，此类基于一个io_service，但是可以创建很多socket，可以连接服务器，可以指定工作线程数量。
 */

#pragma once

#include "Acceptor_Connector_Base.h"

class Connector : public Acceptor_Connector_Base
{
public:
	Connector(const char* ip, unsigned int port);
	virtual ~Connector(void);

	virtual void* Initialize(ReceiveManager* recv_mng);
	virtual bool  Start();
	virtual bool  Stop();

private:
	bool ConnectServer();

	_pmy_socket CreateSocket();

	virtual void SocketCloseNotify(_pmy_socket socket, int EventID);

private:
	_pmy_socket _socket;
};

