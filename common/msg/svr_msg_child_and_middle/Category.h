#pragma once

namespace mc_system_msg_c_m
{
	enum eMessage_type
	{
		eMT_none				= 0,
		eMT_Child_and_Middle	= 1,	//处理c-m之间的子服上线消息，心跳消息等
		eMT_loading_report		= 2,	//负载报告
		eMT_user_c_m,					//处理c-m之间的用户消息

		eMT_max,
	};
};