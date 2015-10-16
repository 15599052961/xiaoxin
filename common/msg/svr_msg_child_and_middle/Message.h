#pragma once

#include "IdentifiersDefine.h"
#include "..\MessageType.h"

#pragma pack(push, 1)

#define TEST

namespace mc_system_msg_c
{
	enum eChatProtocol
	{
		eCP_none = 0,
		eCP_text,
	};

	struct sChatMessage : public mc_system_msg::sMessageRoot
	{
		unsigned __int64 _target_idx;
		unsigned __int64 _user_idx;
		unsigned __int16 _content_len;

		char _time[TIME_STRING_LEN];

		wchar_t _content[1];
	};
};


#pragma pack(pop)