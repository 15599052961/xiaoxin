#pragma once

#include "IdentifiersDefine.h"
#include "..\MessageType.h"
#include "..\ChildServerData.h"
#include "..\ChildServerStatus.h"

#pragma pack(push, 1)

namespace mc_system_msg_c_m
{
	enum eChild_and_Middle_Message_type
	{
		eCMMT_none				= 0,
		eCMMT_child_online_req	= 1,
		eCMMT_child_online_res	= 2,
		eCMMT_child_online_ree	= 3,

		eCMMT_child_status_req,
		eCMMT_child_status_res,
		eCMMT_child_status_ree,

		eCMMT_heart_packet_req,
		eCMMT_heart_packet_res,
		eCMMT_heart_packet_ree,

		eCMMT_max, 
	};

	enum eChild_online_error
	{
		eCOE_none = 0,
		eCOE_no_database = 1,
	};

	struct sChildOnlineReq : mc_system_msg::sMessageRoot
	{
		char _ip[IP_V4_LEN_END_SYMBOL];
		unsigned __int32 _port;
	};

	struct sChildOnlineRes : mc_system_msg::sMessageRoot
	{
		int _index;
		mc_system_db::sChildServerDatabaseData _sql_data;
	};


	//////////////////////////////////////////////////////////////////////////
	struct sUpdateStatusReq : mc_system_msg::sMessageRoot
	{
		mc_system_child_server::eChildServerStatus _status;
	};

	struct sUpdateStatusRes : mc_system_msg::sMessageRoot
	{
		//true:ok
		//false:error
		bool _is_ok;
	};


	//////////////////////////////////////////////////////////////////////////
	struct sHeartpacketReq : mc_system_msg::sMessageRoot
	{
		mc_system_child_server::EPeopleCount _people_count;
		unsigned __int32 _user_count;
	};

	struct sHeartpacketRes : mc_system_msg::sMessageRoot
	{
		//nothing
	};
};

 
#pragma pack(pop)