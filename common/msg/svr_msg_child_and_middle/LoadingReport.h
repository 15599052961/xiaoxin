#pragma once

#include "..\MessageType.h"
#include "..\ChildServerStatus.h"

#pragma pack(push, 1)

namespace mc_system_msg_c_m
{
	enum eLoadingReport
	{
		eLP_none = 0,

		eLP_loading_eport_req,
		eLP_loading_eport_res,
		eLP_loading_eport_ree,
	};

	enum eLoadingReportError
	{
		eLPE_none = 0,
	};

	struct sLoadingReportReq : public mc_system_msg::sMessageRoot 
	{
		mc_system_child_server::EPeopleCount _people_count;
	};

	struct sLoadingReportRee : public mc_system_msg::sMessageRoot 
	{
		eLoadingReportError _error;
	};
};


#pragma pack(pop)