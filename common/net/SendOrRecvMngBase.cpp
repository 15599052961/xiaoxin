#include "stdafx.h"
#include "SendOrRecvMngBase.h"


SendOrRecvMngBase::SendOrRecvMngBase(unsigned int bufferSize)
	:_buffer_size(bufferSize)
{
	_buffer_pool = new boost::pool<>(_buffer_size);
	_obj_pool = new boost::object_pool<mc_system_msg::sPerHandleData>();

	if(_buffer_pool == NULL || _obj_pool == NULL){
		ASSERT_THROW;
	}
}

SendOrRecvMngBase::~SendOrRecvMngBase(void)
{
	SAFE_DELETE1(_buffer_pool, purge_memory);
	SAFE_DELETE(_obj_pool);
}

mc_system_msg::PPerHandleData SendOrRecvMngBase::GetData(_pmy_socket socket)
{
	boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);

	mc_system_msg::PPerHandleData tmp_perHandledata = _obj_pool->construct((char*)_buffer_pool->malloc(), _buffer_size, socket);

	if(tmp_perHandledata != NULL && tmp_perHandledata->_buffer != NULL){
		memset(tmp_perHandledata->_buffer, 0, tmp_perHandledata->_buffer_size);
		return tmp_perHandledata;
	}
	else{
		if(tmp_perHandledata != NULL){
			_obj_pool->destroy(tmp_perHandledata);
		}

		return NULL;
	}
}

void SendOrRecvMngBase::ReleaseMemory(mc_system_msg::PPerHandleData handledata)
{
	if(handledata != NULL){
		if(handledata->_socket != NULL && handledata->_offset == 0){
			//收到0字节的数据，说明客户端已经关闭了连接
			CloseSocket(handledata->_socket, __FUNCTION__);
		}

		boost::recursive_mutex::scoped_lock tmp_lock(_buffer_mutex);

		if(handledata->_buffer != NULL){
			_buffer_pool->free((void*)handledata->_buffer);
		}

		_obj_pool->destroy(handledata);
	}
}