#pragma once

#include "Acceptor.h"
#include "boost/shared_ptr.hpp"
#include "boost/thread.hpp"
#include "boost/function.hpp"

class AcceptorManager
{
public:
	virtual ~AcceptorManager(void);

	bool	RunAll(char* ip, unsigned int port, ReceiveManager* recvMng, unsigned int prepare_accept_socket_count);
	void	StopAll();

protected:
	AcceptorManager(unsigned int work_thread_count = 4);

	virtual bool Initialize() = 0;

protected:
	ReceiveManager* _receive;

private:
	bool			_is_end;
	unsigned int	_work_thread_count;

	boost::thread_group _thread_group;
};



inline
	AcceptorManager::AcceptorManager( unsigned int work_thread_count /*= 4*/ )
	:_work_thread_count(work_thread_count)
	,_is_end(false)
	,_receive(NULL)
{
}

inline
	AcceptorManager::~AcceptorManager( void )
{
	StopAll();
}

inline
	void AcceptorManager::StopAll()
{
	_is_end = true;
	_thread_group.interrupt_all();
}

inline
	bool AcceptorManager::Initialize()
{
	assert(false && "overload this function");
}