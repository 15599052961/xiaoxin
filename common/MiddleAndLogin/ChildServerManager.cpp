#include "stdafx.h"
#include "ErrorEnum.h"
#include <algorithm>
#include "ErrorPrint.h"
#include "ChildServerManager.h"

#if defined(SHOW_INFO)&&defined(_CONSOLE)
#include "boost/function.hpp"
#include "boost/format.hpp"
#include "boost/thread.hpp"
#endif


ChildServerManager::ChildServerManager(void)
{
#if defined(SHOW_INFO)&&defined(_CONSOLE)
	boost::function<void(const _my_map&)> tmpFunc = [](const _my_map& myMap){
		while (true)
		{
			printf("on-line total server:%d.\n", (int)myMap.size());
			Sleep(10000);
		}
	};

	boost::thread tmpThread(boost::bind(tmpFunc, boost::ref(_client_map)));
#endif
}

ChildServerManager::~ChildServerManager(void)
{
	using namespace mc_system_child_server_data;

	for (boost::unordered_map<int, boost::shared_ptr<sChildServerData>>::iterator tmpBegin = _client_map.begin(); \
		tmpBegin != _client_map.end(); /**/)
	{
		boost::shared_ptr<sChildServerData>& tmp_ptr = (*tmpBegin).second;

		tmp_ptr.reset();
	}

	_client_map.clear();
}

bool ChildServerManager::UpdateChildServerStatus( int id, mc_system_child_server::eChildServerStatus status )
{
	using namespace mc_system_child_server_data;

	assert(socket != NULL && status != mc_system_child_server::eCSS_none);

	if(socket == NULL || status == mc_system_child_server::eCSS_none){
		throw new std::exception("update child-server param error.");
		//return;
	}

	boost::shared_ptr<sChildServerData>* tmp_data = GetDatabase(id);

	if(tmp_data != NULL){
		tmp_data->get()->_status = status;
	}
	else{
		mc_system::ErrorPrint()(mc_system::eEPCV_yellow, "Not found child-database.");
		return false;
	}

	return true;
}

void ChildServerManager::ReleaseChildServer( int id )
{
	if(_client_map.size() == 0){
		mc_system::ErrorPrint()(mc_system::eEPCV_yellow, "map sis empty.");
		return;
	}

	using namespace mc_system_child_server_data;

	boost::unordered_map<int, boost::shared_ptr<sChildServerData>>::iterator tmp_find = _client_map.find(id);

	assert(tmp_find != _client_map.end());

	if(tmp_find == _client_map.end()){
		//throw;
		return;
	}

	boost::shared_ptr<sChildServerData> tmp_data = tmp_find->second;

	_client_map.erase(tmp_find);

	tmp_data.reset();
}

void ChildServerManager::UpdateChildSvrPeopleCount( int id, mc_system_child_server::EPeopleCount pc )
{
	using namespace mc_system_child_server_data;

	//assert(socket != NULL);

	//if(socket == NULL){
	//	throw new std::exception("update child-server param error.");
	//	//return;
	//}

	boost::shared_ptr<sChildServerData>* tmp_data = GetDatabase(id);

	assert(tmp_data);

	if(tmp_data != NULL){
		tmp_data->get()->_people_count = pc;
	}
	else{
		assert(false);
	}
}

void ChildServerManager::UpdateChildSvrUserCount( int id, __int64 userCount )
{
	using namespace mc_system_child_server_data;

	//assert(socket != NULL);

	//if(socket == NULL){
	//	throw new std::exception("update child-server param error.");
	//	//return;
	//}

	boost::shared_ptr<sChildServerData>* tmp_data = GetDatabase(id);

	if(tmp_data != NULL){
		tmp_data->get()->_user_count = userCount;
	}
	else{
		assert(false);
	}

}

/// <summary>
/// 通过socketID获取该子服务器的数据库的id
/// </summary>
/// <param name="socketID">(int)boost::asio::ip::tcp::socket*.</param>
/// <returns>unsigned __int32.</returns>
unsigned __int32 ChildServerManager::GetChildSvrDbId(int socketID)
{
	boost::shared_ptr<mc_system_child_server_data::sChildServerData>* tmp_data = GetDatabase(socketID);

	if(tmp_data != NULL){
		return tmp_data->get()->_database_data._db_id;
	}
	else{
		assert(false);
		throw new std::exception(__FILE__, __LINE__);
	}

	return 0;
}

