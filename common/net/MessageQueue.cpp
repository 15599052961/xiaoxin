#include "stdafx.h"
#include "boost/bind.hpp"
#include "MessageQueue.h"
#include <assert.h>



MessageQueue::MessageQueue(unsigned int bufferSize)
	:SendOrRecvMngBase(bufferSize)
	,_thread_count(0)
	,_dispatch_func(NULL)
{
}

MessageQueue::~MessageQueue(void)
{
	_condition.notify_all();
	Sleep(1000);

	//////////////////////////////////////////////////////////////////////////
	_thread_group.interrupt_all();

	//////////////////////////////////////////////////////////////////////////
	for (_my_list::iterator tmpBegin = _handle_data_list.begin(); tmpBegin != _handle_data_list.end(); )
	{
		mc_system_msg::PPerHandleData tmpData = *(tmpBegin++);
		ReleaseMemory(tmpData);
	}

	_handle_data_list.clear();
}

bool MessageQueue::Init(_func_1 func, int threadCount /*= 8*/)
{
	if(threadCount == 0 || func == NULL){
		assert(false);
		throw;
	}

	_thread_count = threadCount;
	_dispatch_func = func;

	for (int i=0; i<_thread_count; ++i)
	{
		_thread_group.create_thread(boost::bind(&MessageQueue::Dispatch, this));
	}

	return true;
}
