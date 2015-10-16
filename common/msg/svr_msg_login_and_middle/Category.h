#pragma once


namespace mc_system_msg_l_m
{
	enum eCategoryLoginMiddle
	{
		eCLM_none = 0,

		eCLM_child_server_list = 1,	 // get child-server list ask middle-server 

		eCLM_child_server_status,

		eCLM_Login_Middle_heartbeat, // heartbeat
	};
};