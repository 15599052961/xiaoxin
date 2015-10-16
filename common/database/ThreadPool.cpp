#include "stdafx.h"
#include "boost/bind.hpp"
#include "boost/lambda/lambda.hpp"
#include "threadpool.h"
#include <assert.h>



cThreadPool::cThreadPool(void)
	:_work_thread_count(0)
	,_is_exit(false)
{
	//_mutex = new boost::shared_mutex();
	//_notify_mutex = new boost::recursive_mutex();
}

cThreadPool::~cThreadPool(void)
{
//#define _SAFE_DELETE(ptr) if(ptr!=NULL){delete ptr; ptr=NULL;}
//
	_is_exit = true;
//
//	if(_notify_mutex != NULL){
		_thread_group.interrupt_all();
//		_notify_mutex->destroy();
//
//		_SAFE_DELETE(_notify_mutex);
//		_SAFE_DELETE(_mutex);
//
//	}
}

bool cThreadPool::QueueRequest( mc_system_db::PPerhandleDataDB perhandledata_db )
{
	_write_lock tmpWl(_mutex);

	_data_set.insert(perhandledata_db);
	_condition.notify_all();
	return true;
}

mc_system_db::PPerhandleDataDB cThreadPool::GetData()
{
	_write_lock tmpWl(_mutex);

	if(_data_set.size() == 0){
		return NULL;
	}

	mc_system_db::PPerhandleDataDB tmpData = *(_data_set.begin());
	_data_set.erase(_data_set.begin());

	if (tmpData == NULL)
	{
		assert(false);
		throw new std::exception(__FILE__, __LINE__);
	}

	return tmpData;
}

unsigned int cThreadPool::WorkerThread( )
{
	assert(false && "Please overload this function");
	return -1;
}

bool cThreadPool::Initialize(int numWorkerThreads)
{
	assert(numWorkerThreads != 0);

	for (int i=0; i<numWorkerThreads; ++i)
	{
		_thread_group.create_thread(boost::bind(&cThreadPool::WorkerThread, this));
	}

	if(_thread_group.size() != numWorkerThreads){
		assert(false && "create thread failed");
		return false;
	}

	return true;
}


