/*
 *	author:wl(oiooooio)
 *	time:2014/8/12
 *
 *	Acceptor_Connector_Base:
 *	as a base class for SendManager and ReceiveManager
 *	
 *	
 */


#pragma once

#include "IdentifiersDefine.h"
#include "msg\PerHandleData.h"
#include "boost/pool/object_pool.hpp"
#include "boost/pool/pool.hpp"
#include "boost/thread.hpp"


class SendOrRecvMngBase
{
protected:
	SendOrRecvMngBase(unsigned int bufferSize);
	virtual ~SendOrRecvMngBase(void);

protected:
	mc_system_msg::PPerHandleData GetData(_pmy_socket socket);

	void ReleaseMemory(mc_system_msg::PPerHandleData handledata);

	unsigned int GetBufferSize()const{return _buffer_size;}

	virtual void First(_pmy_socket socket){/*可以不继承*/};

	virtual void CloseSocket(_pmy_socket socket, const char* description){/*此方法主要用于ReceiveManager继承*/};

protected:
	boost::object_pool<mc_system_msg::PerHandleData>* _obj_pool;
	boost::pool<>* _buffer_pool;
	boost::recursive_mutex _buffer_mutex;

	unsigned int _buffer_size;
};

