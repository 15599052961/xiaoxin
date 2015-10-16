#pragma once

#include "boost/unordered_set.hpp"
#include "boost/thread/condition.hpp"
#include "boost/unordered_set.hpp"
#include "boost/pool/pool.hpp"
#include "boost/pool/object_pool.hpp"
#include "database/PerhandleDataDB.h"
#include "database/SQLPool.h"
#include "IdentifiersDefine.h"

/// <summary>
/// 此函数主要用于跟数据库交互，作为一个承上启下的中间件。
/// info transfer station 也就是数据中转的意思
/// </summary>
class InfoTransferStation
{
	typedef boost::shared_lock<boost::shared_mutex> _read_lock;
	typedef boost::unique_lock<boost::shared_mutex> _write_lock;

public:
	virtual ~InfoTransferStation();

	void Exit();

	/// <summary>
	/// 上层代码(应用层/功能层面)发出的数据库操作请求,此函数只能用于上层代码调用
	/// </summary>
	/// <param name="data">The data.</param>
	void SendRequest(mc_system_db::PPerhandleDataDB data){PushData_me_to_db(data);}

	/// <summary>
	/// 当上层要发出调用之前，需要用此函数获取数据对象，上层的请求都封装在此数据对象中，之后再调用SendRequest发出数据库执行请求
	/// </summary>
	/// <returns>@see mc_system_db::PPerhandleDataDB.</returns>
	mc_system_db::PPerhandleDataDB Get( );



	/// <summary>
	/// 数据库执行完毕后的数据通知，此函数只能被数据库层调用，上层不得调用
	/// </summary>
	/// <param name="data">The data.</param>
	void PushData_db_to_me(mc_system_db::PPerhandleDataDB data);

protected:
	InfoTransferStation();

	bool Init(cSQLPool* database, unsigned short workThreadCount = 4, unsigned int bufferSize = 0x8000);
	virtual void DoData(mc_system_db::PPerhandleDataDB data) = 0;

private:
	void WorkThread();

	void Release( mc_system_db::PPerhandleDataDB perhandledata );

	void PushData_me_to_db(mc_system_db::PPerhandleDataDB data);
	mc_system_db::PPerhandleDataDB GetData();

private:
#pragma region SQL
	/// <summary>
	/// 数据库执行对象 @see DatabaseConfig
	/// </summary>
	cSQLPool*				_database;
#pragma endregion SQL

#pragma region THREAD
	/// <summary>
	/// 当前类实例线程组
	/// </summary>
	boost::thread_group		_thread_group;

	/// <summary>
	/// @see boost::condition
	/// </summary>
	boost::condition		_condition;
	/// <summary>
	/// 锁 针对_condition，作为_condition的一部分使用，切勿使用在其他部分
	/// </summary>
	boost::recursive_mutex	_notify_mutex;
#pragma endregion THREAD

#pragma region DATA MAP
	/// <summary>
	/// 用于与_db_config交互的数据表，_db_config执行完毕的数据都存到此表中，此类对象从这个表里获取数据，这个表也就相当于缓存
	/// </summary>
	boost::unordered_set<mc_system_db::PPerhandleDataDB> _data_set;
	/// <summary>
	/// 互斥对象 @see boost::mutex,此对象用于锁 表操作
	/// </summary>
	boost::shared_mutex		_mutex;
#pragma endregion DATA MAP

#pragma region MEMORY POOL
	/// <summary>
	/// 内存池，@see boost::object_pool
	/// </summary>
	boost::object_pool<mc_system_db::PerhandleDataDB> _obj_pool;
	/// <summary>
	/// 内存池，@see boost::pool
	/// </summary>
	boost::pool<>*			_buffer_pool;
	/// <summary>
	/// 缓冲区大小
	/// </summary>
	unsigned int			_buffer_size;
	/// <summary>
	/// _buffer_pool和_obj_pool内存操作的锁
	/// </summary>
	boost::recursive_mutex	_buffer_mutex;
#pragma endregion MEMORY POOL

	/// <summary>
	/// 是否退出，如果要退出，此值为true，否则为false
	/// </summary>
	bool					_is_exit;
};


inline
	InfoTransferStation::~InfoTransferStation(void)
{
	Exit();
}

inline
	mc_system_db::PPerhandleDataDB InfoTransferStation::Get()
{
	boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);

	mc_system_db::PPerhandleDataDB tmpPtr = _obj_pool.construct(_buffer_pool->malloc(), _buffer_size);

	if(tmpPtr != NULL && tmpPtr->_buffer != NULL){
		memset(tmpPtr->_buffer, 0, _buffer_size);
		return tmpPtr;
	}
	else{
		if(tmpPtr != NULL){
			_obj_pool.destroy(tmpPtr);
		}

		//assert(false && "allocate memory failed");
		return NULL;
	}
}

inline
	void InfoTransferStation::Release( mc_system_db::PPerhandleDataDB perhandledata )
{
	boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);

	_buffer_pool->free(perhandledata->_buffer);

	//这里经常出现崩溃，不知道为什么
	_obj_pool.destroy(perhandledata);
}

inline
	void InfoTransferStation::PushData_db_to_me( mc_system_db::PPerhandleDataDB data )
{
	_write_lock tmpWl(_mutex);

	_data_set.insert(data);
	_condition.notify_one();
}

inline
	void InfoTransferStation::PushData_me_to_db( mc_system_db::PPerhandleDataDB data )
{
	if(_database != NULL){
		_database->QueueRequest(data);
	}
}

inline
	mc_system_db::PPerhandleDataDB InfoTransferStation::GetData()
{
	_write_lock tmpWl(_mutex);

	if(_data_set.size() == 0){
		return NULL;
	}

	mc_system_db::PPerhandleDataDB tmpData = *(_data_set.begin());
	_data_set.erase(_data_set.begin());
	return tmpData;
}

inline
	void InfoTransferStation::DoData( mc_system_db::PPerhandleDataDB data )
{
	assert(false && "please overload this function");
}