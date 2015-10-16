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
	//����func�ǲ���NULL��Ҫ��Ҫ֪ͨ��������
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
		//��������
		ASSERT_THROW;
	}

	//�����������������ڼ���������²���
	{
		boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);
		_my_set::iterator tmpFind = _set.find(socket);

		if(tmpFind != _set.end()){
			/*
			 *	@Acceptor ��	����Acceptor��˵��������������صģ�ֻҪ�����ͷŴ�socket*��Դ����
			 *	@Connector��	����Connector��˵��������������ģ���ΪConnector��Ҫһ��socket*ȥ���ӷ�������
			 *				������socket��recv/send�����쳣ʱ���⽫����socket*������������Ͽ����ӣ�����
			 *				�Ĵ�����Ҫ֪ͨConnector��������Connector���ʼ��SocketManager����ʱ�������
			 *				����bool SocketManager::Init(_func_1 func)ʱ����������NULL����ָ�룬�Ա�
			 *				����֪ͨ
			 */

			_set.erase(tmpFind);
		}
		else
		{
			//error
			//��������£���socket��������Ӧ�ñ��������е�socket����
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


