#include "stdafx.h"
#include "InfoTransferStation.h"
#include "boost/bind.hpp"
#include "ServerConfig.h"


InfoTransferStation::InfoTransferStation(void)
	:_is_exit(false)
	,_buffer_size(0)
	,_database(NULL)
	,_buffer_pool(NULL)
{
	_is_exit = false;
}

bool InfoTransferStation::Init( cSQLPool* database, unsigned short workThreadCount /*= 4*/, unsigned int bufferSize/* = 0x8000*/ )
{
	assert(workThreadCount != 0 && database != NULL);
	_database = database;

	_buffer_pool = new boost::pool<>(_buffer_size = bufferSize);
	if(_buffer_pool == NULL){
		assert(false);
		return false;
	}

	for (int i=0; i<workThreadCount; ++i)
	{
		_thread_group.create_thread(boost::bind(&InfoTransferStation::WorkThread, this));
	}

	if(_thread_group.size() != workThreadCount){
		assert(false && "create thread failed");
		return false;
	}

	return true;
}

void InfoTransferStation::WorkThread()
{
	//只有在调试模式下设置线程名称有效
	mc_system_public_function::SetThreadName(::GetCurrentThreadId(), __FUNCTION__);

	//////////////////////////////////////////////////////////////////////////
	while(!_is_exit)
	{
		_condition.wait(_notify_mutex);
		mc_system_db::PPerhandleDataDB tmpData = GetData();

		if(tmpData != NULL){
			//dispatcher
			DoData(tmpData);

			//release memory
			Release(tmpData);
		}
	}
}

void InfoTransferStation::Exit()
{
	_is_exit = true;

	_condition.notify_all();

	if(_database != NULL){
		_database->NotifyAllAndClose(true);
	}

	//等待其他线程执行完毕
	Sleep(1000);

	_thread_group.interrupt_all();

	SAFE_DELETE(_database);
	SAFE_DELETE1(_buffer_pool, purge_memory);
}

