#pragma once

#include "database/PerhandleDataDB.h"
#include "msg/ChildServerData.h"
#include "../msg/ChildServerStatus.h"
#include "boost/unordered_map.hpp"
#include "boost/bind.hpp"
#include "boost/asio.hpp"
#include "boost/shared_ptr.hpp"


/// <summary>
/// m-s和l-s都需要child-server管理器，所以这个类是一个公共体，谨慎修改
///
/// 此类中的函数的参数的id需要解释一下，在：
/// middle-server:表示socket*被强转的int类型id
/// child-server:跟子数据库id一致，所以这里的id也就是子数据库的id，而不是socket*被强转的int类型id
/// </summary>
class ChildServerManager
{
	typedef boost::shared_ptr<mc_system_child_server_data::sChildServerData> _my_sp_csd;
	typedef boost::unordered_map<int, _my_sp_csd> _my_map;

public:
	ChildServerManager();
	virtual ~ChildServerManager();

public:
	virtual void ReleaseChildServer(int id);

	//////////////////////////////////////////////////////////////////////////
	mc_system_child_server::eChildServerStatus GetChildServerStatus(int id);
	bool GetChildSvrIpAndPort		(int id, unsigned __int16* port, char* ip);
	unsigned __int32 GetChildSvrDbId(int socketID);
	int  GetSvrCount				() const{return _client_map.size();};

	bool UpdateChildServerStatus	(int id, mc_system_child_server::eChildServerStatus status);
	void UpdateChildSvrPeopleCount	(int id, mc_system_child_server::EPeopleCount pc);
	void UpdateChildSvrUserCount	(int id, __int64 maxUserIdx);

protected:
	_my_sp_csd* GetDatabase(int id);

protected:
	_my_map _client_map;
};


inline
	ChildServerManager::_my_sp_csd* ChildServerManager::GetDatabase( int id )
{
	using namespace mc_system_child_server_data;

	if(_client_map.size() > 0){
		boost::unordered_map<int, boost::shared_ptr<sChildServerData>>::iterator tmpFind = _client_map.find(id);
		return tmpFind == _client_map.end() ? NULL : &tmpFind->second;
	}
	else{
		//assert(false);
		return NULL;
	}
}

inline
	bool ChildServerManager::GetChildSvrIpAndPort( int id, unsigned __int16* port, char* ip )
{
	/*
	 *	ip必须是一个指向IP_V4_LEN_END_SYMBOL个char大小的缓冲区指针
	 */

	boost::shared_ptr<mc_system_child_server_data::sChildServerData>* tmpChildData = GetDatabase(id);

	if(tmpChildData == NULL){
#ifdef SHOW_INFO
		printf("Not found server:%d", id);
#endif

		/*
		 * 这里报错，说明用户所在服务器没有开启
		 */

		//assert(false);
		return false;
	}

	*port = tmpChildData->get()->port;
	strcpy_s(ip, IP_V4_LEN_END_SYMBOL, tmpChildData->get()->_ip);

	return true;
}

inline
	mc_system_child_server::eChildServerStatus ChildServerManager::GetChildServerStatus(int id)
{
	boost::shared_ptr<mc_system_child_server_data::sChildServerData>* tmpChildData = GetDatabase(id);
	
	if(tmpChildData == NULL){
		assert(tmpChildData != NULL);
		throw new std::exception(__FILE__, __LINE__);
	}

	return tmpChildData->get()->_status;
}
