#pragma once
#include "boost/asio.hpp"
#include "IdentifiersDefine.h"
#include <assert.h>
#include <memory.h>
#include "ChildServerStatus.h"

namespace mc_system_db
{
	struct sChildServerDatabaseData
	{
		unsigned __int32	_db_id;

		char				_db_ip[IP_V4_LEN_END_SYMBOL];
		unsigned short		_db_port;

		wchar_t				_db_name[DATABASE_NAME_LEN];
		wchar_t				_db_account_name[DATABASE_ACCOUNT_NAME_LEN];
		wchar_t				_db_account_pwd[DATABASE_ACCOUNT_PWD];

		unsigned __int32	_db_perfect_user_count;

		sChildServerDatabaseData()
		{
			memset(this, 0, sizeof(sChildServerDatabaseData));
		}

		sChildServerDatabaseData& operator= (sChildServerDatabaseData& obj){
			assert(false && "Please finish the partial code");
			return *this;
		}

		bool operator== (sChildServerDatabaseData& data){
			return _db_id == data._db_id;
		}
	};
};


namespace mc_system_child_server_data{

	struct sChildServerData
	{
#if defined(MIDDLE_SERVER)
		boost::asio::ip::tcp::socket* _socket;
#elif defined(LOGIN_SERVER)
		int _svr_index;
#endif

		//////////////////////////////////////////////////////////////////////////
		mc_system_db::sChildServerDatabaseData _database_data;

		//////////////////////////////////////////////////////////////////////////
		char _ip[IP_V4_LEN_END_SYMBOL];
		unsigned __int32 port;

		//////////////////////////////////////////////////////////////////////////
		mc_system_child_server::eChildServerStatus _status;
		mc_system_child_server::EPeopleCount _people_count;
		__int64 _user_count;

		sChildServerData(){
			memset(this, 0, sizeof(sChildServerData));
		}

		bool operator== (sChildServerData& data){
			if(strcmp(_ip, data._ip) == 0 &&
				port == data.port){
					return _database_data == data._database_data;
			}

			return false;
		}
	};
};