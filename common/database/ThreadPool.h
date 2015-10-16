#pragma once

#include "boost/thread.hpp"
#include "boost/unordered_set.hpp"
#include "boost/thread/condition.hpp"
#include "PerhandleDataDB.h"

class cThreadPool
{
	typedef boost::shared_lock<boost::shared_mutex> _read_lock;
	typedef boost::unique_lock<boost::shared_mutex> _write_lock;

public:
	cThreadPool(void);
	virtual ~cThreadPool(void);

	virtual bool  Initialize   ( int numWorkerThreads=2 );
	virtual bool  QueueRequest ( mc_system_db::PPerhandleDataDB perhandledata_db );

protected:
	virtual unsigned int WorkerThread ( ) = 0;
	mc_system_db::PPerhandleDataDB GetData();

protected:
	int		_work_thread_count;
	bool	_is_exit;	//true:exit, false:not exit

	boost::unordered_set<mc_system_db::PPerhandleDataDB> _data_set;
	
	boost::thread_group		_thread_group;
	boost::shared_mutex		_mutex;			//������Ա����

	boost::condition		_condition;		//�̵߳ȴ�
	boost::recursive_mutex	_notify_mutex;	//�� ���_condition����Ϊ_condition��һ����ʹ�ã�����ʹ������������
};
