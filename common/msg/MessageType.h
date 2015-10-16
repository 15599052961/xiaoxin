#pragma once
#include "msg\Packet.h"


namespace mc_system_msg
{
#pragma pack(push, 1)

	struct sMessageRoot : Packet
	{
		unsigned __int16 _message_type_category;
		unsigned __int16 _message_type_protocol;
	};

	struct sMessageError : sMessageRoot
	{
		int _error_code;
	};

#pragma pack(pop)

};