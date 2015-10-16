#pragma once
#include "..\ChildServerData.h"
#include "IdentifiersDefine.h"
#include "..\ChildServerStatus.h"
#include "..\MessageType.h"


namespace mc_system_msg_l_m
{
#pragma pack(push, 1)

	enum eProtocolLoginMiddle_child_server_list
	{
		ePLM_none = 0,

		ePLM_child_server_list_req = 1,	// l->m get child-server list
		ePLM_child_server_list_res,		// m->l return child-server list
		ePLM_child_server_list_ree,		// m->l return error
	};

	enum eProtocolLoginMiddle_child_server_list_error
	{
		ePLME_none = 0,
		ePLME_get_child_server_list_error,
		ePLME_all_child_server_are_not_online,
	};

	struct sChildServerListRes : public mc_system_msg::sMessageRoot
	{
		unsigned __int32 _count;
		mc_system_child_server_data::sChildServerData _list[1];
	};

	//eCLM_Login_Middle_heartbeat
	enum eProtocolLoginMiddle_heartbeat
	{
		ePLM_Login_none = 0,

		ePLM_Login_heartbeat_req = 1,	// l->m get child-server list
		ePLM_Login_heartbeat_res,		// m->l return child-server list
		ePLM_Login_heartbeat_ree,		// m->l return error
	};


	struct sLoginMiddleHeartReq : mc_system_msg::sMessageRoot
	{
		__int64 _max_user_idx;
	};

	struct sLoginMiddleHeartRes : mc_system_msg::sMessageRoot
	{
		//nothing
	};

	enum eChildServerStatus{
		eCSOL_child_server_online_none = 0,

		eCSOL_child_server_online_req,
		eCSOL_child_server_online_res,
		eCSOL_child_server_online_ree,

		eCSOL_child_server_offline_req,
		eCSOL_child_server_offline_res,
		eCSOL_child_server_offline_ree,
	};

	struct sChildServerStatusNotifyReq : mc_system_msg::sMessageRoot
	{
		mc_system_child_server_data::sChildServerData _child_server_data;
	};

#pragma pack(pop)
};