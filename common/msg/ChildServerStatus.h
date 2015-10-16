#pragma once

namespace mc_system_child_server
{
	enum eChildServerStatus
	{
		eCSS_none = 0,
		eCSS_ready,
		eCSS_online,
		eCSS_offline,
	};


	enum EPeopleCount
	{
		ePC_none = 0,

		ePC_100		= 100,
		ePC_500		= 500,
		ePC_1000	= 1000,
		ePC_5000	= 5000,
		ePC_10000	= 10000,
		ePC_20000	= 20000,
		ePC_30000	= 30000,
		ePC_40000	= 40000,
		ePC_50000	= 50000,
		ePC_60000	= 60000,
		ePC_70000	= 70000,
		ePC_80000	= 80000,
		ePC_90000	= 90000,

		ePC_max,
	};
};