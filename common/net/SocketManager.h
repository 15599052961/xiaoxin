/*
 *	add:	2014-8-4
 *	author:	wl(oiooooio)
 *
 *	SocketManager:
 *		socket对象管理器
 *		此类适用于 @class Acceptor, @class Connector
 *		用于对分配到socket对象的管理以及资源释放
 *		
 *	waring:
 *		此类非单例模式，也不要改成单例模式
 *		此类由@class Acceptor, @class Connector管理和维护
 */


#pragma once

#include "IdentifiersDefine.h"
#include "boost/unordered_set.hpp"
#include "boost/thread.hpp"
#include "boost/function.hpp"

class SocketManager
{
	friend class Acceptor_Connector_Base;
	friend class ReceiveManager;
	friend class SendManager;

	enum eSocketEvent
	{
		eSE_none = 0,
		eSE_post_recv_failed,
		eSE_send_failed,
		eSE_closed,
	};

	typedef boost::unordered_set<_pmy_socket> _my_set;
	typedef boost::function<void(_pmy_socket, int)> _func_1;

public:
	~SocketManager(void);

private:
	SocketManager(const char* description);

	bool Init(_func_1 func);

	void ClearAll();

	//Acceptor or Connector can add socket
	void Add(_pmy_socket socket);

	//only ReceiveManager may post receive operator failed
	void PostRecvFailed(_pmy_socket socket);

	//only SendManager may post receive operator failed
	void SendFailed(_pmy_socket socket);

	//socket closed
	void SocketClosed(_pmy_socket socket);

	//由函数内部调用，外部不得使用
	void SocketErrorNotify(_pmy_socket socket, int eventID);

private:
	_my_set _set;

	boost::recursive_mutex _buffer_mutex;

	/// <summary>
	/// param @_pmy_socket:socket* object
	/// param @int:see cref enum eSocketEvent
	/// </summary>
	_func_1 _func_socket_event_notify;

	/// <summary>
	/// 描述这个类对象是属于哪个对象的成员(__FUNCTION__)
	/// </summary>
	char _description[256];
};

