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
/// �˺�����Ҫ���ڸ����ݿ⽻������Ϊһ���������µ��м����
/// info transfer station Ҳ����������ת����˼
/// </summary>
class InfoTransferStation
{
	typedef boost::shared_lock<boost::shared_mutex> _read_lock;
	typedef boost::unique_lock<boost::shared_mutex> _write_lock;

public:
	virtual ~InfoTransferStation();

	void Exit();

	/// <summary>
	/// �ϲ����(Ӧ�ò�/���ܲ���)���������ݿ��������,�˺���ֻ�������ϲ�������
	/// </summary>
	/// <param name="data">The data.</param>
	void SendRequest(mc_system_db::PPerhandleDataDB data){PushData_me_to_db(data);}

	/// <summary>
	/// ���ϲ�Ҫ��������֮ǰ����Ҫ�ô˺�����ȡ���ݶ����ϲ�����󶼷�װ�ڴ����ݶ����У�֮���ٵ���SendRequest�������ݿ�ִ������
	/// </summary>
	/// <returns>@see mc_system_db::PPerhandleDataDB.</returns>
	mc_system_db::PPerhandleDataDB Get( );



	/// <summary>
	/// ���ݿ�ִ����Ϻ������֪ͨ���˺���ֻ�ܱ����ݿ����ã��ϲ㲻�õ���
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
	/// ���ݿ�ִ�ж��� @see DatabaseConfig
	/// </summary>
	cSQLPool*				_database;
#pragma endregion SQL

#pragma region THREAD
	/// <summary>
	/// ��ǰ��ʵ���߳���
	/// </summary>
	boost::thread_group		_thread_group;

	/// <summary>
	/// @see boost::condition
	/// </summary>
	boost::condition		_condition;
	/// <summary>
	/// �� ���_condition����Ϊ_condition��һ����ʹ�ã�����ʹ������������
	/// </summary>
	boost::recursive_mutex	_notify_mutex;
#pragma endregion THREAD

#pragma region DATA MAP
	/// <summary>
	/// ������_db_config���������ݱ�_db_configִ����ϵ����ݶ��浽�˱��У�����������������ȡ���ݣ������Ҳ���൱�ڻ���
	/// </summary>
	boost::unordered_set<mc_system_db::PPerhandleDataDB> _data_set;
	/// <summary>
	/// ������� @see boost::mutex,�˶��������� �����
	/// </summary>
	boost::shared_mutex		_mutex;
#pragma endregion DATA MAP

#pragma region MEMORY POOL
	/// <summary>
	/// �ڴ�أ�@see boost::object_pool
	/// </summary>
	boost::object_pool<mc_system_db::PerhandleDataDB> _obj_pool;
	/// <summary>
	/// �ڴ�أ�@see boost::pool
	/// </summary>
	boost::pool<>*			_buffer_pool;
	/// <summary>
	/// ��������С
	/// </summary>
	unsigned int			_buffer_size;
	/// <summary>
	/// _buffer_pool��_obj_pool�ڴ��������
	/// </summary>
	boost::recursive_mutex	_buffer_mutex;
#pragma endregion MEMORY POOL

	/// <summary>
	/// �Ƿ��˳������Ҫ�˳�����ֵΪtrue������Ϊfalse
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

	//���ﾭ�����ֱ�������֪��Ϊʲô
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