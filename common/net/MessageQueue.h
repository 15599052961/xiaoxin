/*
 *	add:	2014-8-4
 *	author:	wl(oiooooio)
 */

#pragma once

#include <list>
#include "boost/function.hpp"
#include "boost/thread/condition.hpp"
#include "SendOrRecvMngBase.h"
#include "msg/PerHandleData.h"
#include "PublicFunc.h"


class MessageQueue : public SendOrRecvMngBase
{
	friend class ReceiveManager;

	//////////////////////////////////////////////////////////////////////////
	typedef std::list<mc_system_msg::PPerHandleData> _my_list;

	typedef boost::shared_lock<boost::shared_mutex> _read_lock;
	typedef boost::unique_lock<boost::shared_mutex> _write_lock;

	typedef boost::function<void (mc_system_msg::PPerHandleData)> _func_1;

private:
	MessageQueue(unsigned int bufferSize);
	~MessageQueue(void);

private: 
	/// <summary>
	/// Initializes the specified function release data.
	/// </summary>
	/// <param name="func">回调函数，绑定ReceiveManager::Dispatch(...)用于消息派发</param>
	/// <param name="threadCount">线程数量</param>
	/// <returns>bool.</returns>
	bool Init(_func_1 func, int threadCount = 8);
	void Add(mc_system_msg::PPerHandleData data);
	
private:
	void Dispatch();

private:
	/// <summary>
	/// 消息队列
	/// </summary>
	_my_list _handle_data_list;

	/// <summary>
	/// 消息派发
	/// </summary>
	_func_1 _dispatch_func;

#pragma region thread
	/// <summary>
	/// 消息队列读写锁
	/// </summary>
	boost::shared_mutex _mutex;

	/// <summary>
	/// work thread count 
	/// </summary>
	int _thread_count;

	/// <summary>
	/// thread_group
	/// </summary>
	boost::thread_group _thread_group;
#pragma endregion

#pragma region thread notify
	/// <summary>
	/// 配合_notify_mutex， 勿做其他用途
	/// </summary>
	boost::condition _condition;

	/// <summary>
	/// 配合_condition， 勿做其他用途
	/// </summary>
	boost::recursive_mutex	_notify_mutex;	
#pragma endregion
};


inline
	void MessageQueue::Add(mc_system_msg::PPerHandleData data)
{
	mc_system_msg::PPerHandleData tmpData = GetData(data->Socket());
	if(tmpData == NULL){
		//分配缓冲区失败，那么直接派发消息
		_dispatch_func(data);
		return;
	}
	else{
		//消息复制
		*tmpData = *data;

		//否则，写入消息队列，等等处理
		_write_lock tmpWl(_mutex);
		_handle_data_list.push_front(tmpData);
		_condition.notify_all();
	}
}

inline
	void MessageQueue::Dispatch()
{
	//只有在调试模式下设置线程名称有效
	mc_system_public_function::SetThreadName(::GetCurrentThreadId(), __FUNCTION__);

	//////////////////////////////////////////////////////////////////////////
	using namespace mc_system_msg;

	//////////////////////////////////////////////////////////////////////////
	PPerHandleData tmpData = NULL;

	boost::function<PPerHandleData (void)> tmpFunc = [&](void) -> PPerHandleData {
		//多线程，锁起来操作
		_write_lock tmpWl(_mutex);

		if(_handle_data_list.size() == 0){
			return NULL;
		}

		//添加数据在头部，从尾部取数据
		tmpData = _handle_data_list.back();
		_handle_data_list.pop_back();

		return tmpData;
	};

	while (_dispatch_func != NULL)
	{
		if(tmpFunc() == NULL){
			_condition.wait(_notify_mutex);

			if(_dispatch_func == NULL){
				break;
			}

			continue;
		}

		_dispatch_func(tmpData);
		ReleaseMemory(tmpData);
	}
}