#pragma once

#include "..\MessageType.h"

#pragma pack(push, 1)

namespace mc_system_msg_c_m
{
	enum eProtocolUserChildAndMiddle
	{
		ePUCAM_none = 0,

		ePUCAM_user_online_req = 1,
		ePUCAM_user_online_res,
		ePUCAM_user_online_ree,

		ePUCAM_user_offline_req = 4,
		ePUCAM_user_offline_res,
		ePUCAM_user_offline_ree,

		ePUCAM_user_cross_server_send_msg_req = 7,
		ePUCAM_user_cross_server_send_msg_res,
		ePUCAM_user_cross_server_send_msg_ree,
	};

#pragma region online
	enum eProtocolUser_online_err
	{
		ePUOE_none = 0,

		ePUOE_user_exist,		//该用户已存在
	};

	struct sUserOnlineReq : public mc_system_msg::sMessageRoot
	{
		unsigned __int64 _user_idx;
	};

	struct sUserOnlineReq : public mc_system_msg::sMessageError
	{
	};
#pragma endregion


#pragma region offline
	//////////////////////////////////////////////////////////////////////////
	struct sUserofflineReq : public sUserOnlineReq
	{
	};
#pragma endregion


#pragma region cross server send message
	//////////////////////////////////////////////////////////////////////////
	enum eProtocolUser_cross_server_send_msg_err
	{
		ePUCAM_none = 0,

		ePUCAM_CSSME_user_not_found,	//没有找到该用户
	};

	struct sUserCrossSvrSendMsgReq : public mc_system_msg::sMessageRoot
	{
		char _message[1];
	};
#pragma endregion
};


#pragma pack(pop)