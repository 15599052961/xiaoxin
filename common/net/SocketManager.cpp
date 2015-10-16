#include "stdafx.h"
#include "SocketManager.h"
#include "IdentifiersDefine.h"


SocketManager::SocketManager(const char* description)
	:_func_socket_event_notify(NULL)
{
	if(description != NULL){
		strcpy_s(_description, 255, description);
		_description[255] = 0;
	}
}

SocketManager::~SocketManager(void)
{
	ClearAll();
}

void SocketManager::ClearAll()
{
	boost::function<void (_pmy_socket socket)> tmpFunc = [](_pmy_socket socket){
		try{socket->close();}catch(...){}
	};

	boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);

	for (_my_set::iterator tmpBegin = _set.begin(); tmpBegin != _set.end(); )
	{
		_pmy_socket tmpSocket = *(tmpBegin++);

		tmpFunc(tmpSocket);
		SAFE_DELETE(tmpSocket);
	}

	_set.clear();
	_func_socket_event_notify = NULL;
}

bool SocketManager::Init(_func_1 func)
{
	//不管func是不是NULL，要不要通知在于需求
	_func_socket_event_notify = func;

	return true;
}

void SocketManager::Add(_pmy_socket socket)
{
	boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);
	_set.insert(_my_set::value_type(socket));
}

void SocketManager::PostRecvFailed(_pmy_socket socket)
{
	SocketErrorNotify(socket, eSocketEvent::eSE_post_recv_failed);
}

void SocketManager::SendFailed(_pmy_socket socket)
{
	SocketErrorNotify(socket, eSocketEvent::eSE_send_failed);
}

void SocketManager::SocketClosed(_pmy_socket socket)
{
	SocketErrorNotify(socket, eSocketEvent::eSE_closed);
}

void SocketManager::SocketErrorNotify(_pmy_socket socket, int eventID)
{
	if(socket == NULL){
		//参数错误
		ASSERT_THROW;
	}

	//此作用域代码必须是在加锁的情况下操作
	{
		boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);
		_my_set::iterator tmpFind = _set.find(socket);

		if(tmpFind != _set.end()){
			/*
			 *	@Acceptor ：	对于Acceptor来说，这个错误不是严重的，只要尝试释放此socket*资源即可
			 *	@Connector：	对于Connector来说，这可以是致命的，因为Connector需要一个socket*去连接服务器，
			 *				如果这个socket在recv/send出现异常时，这将导致socket*对象与服务器断开连接，这样
			 *				的错误需要通知Connector，所以在Connector里初始化SocketManager对象时，最好在
			 *				调用bool SocketManager::Init(_func_1 func)时，参数给非NULL函数指针，以便
			 *				接受通知
			 */

			_set.erase(tmpFind);
		}
		else
		{
			//error
			//正常情况下，在socket管理器里应该保持着所有的socket对象
		}
	}

	if(_func_socket_event_notify != NULL){
		_func_socket_event_notify(socket, eventID);
	}

	try
	{
		socket->close();
	}
	catch(...)
	{
		//nothing to do
	}

	SAFE_DELETE(socket);
}


