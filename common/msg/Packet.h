#pragma once

namespace mc_system_msg
{
	enum ePacketType
	{
		ePT_none		= 0,

		/// <summary>
		/// the first server
		/// </summary>
		ePT_middle		= 1,

		/// <summary>
		/// the second server
		/// </summary>
		ePT_child		= 2,

		ePT_login		= 100,

		ePT_max,
	};

	enum eDeviceType
	{
		eDT_unknown		= 0,
		eDT_pc			= 1,
		eDT_android		= 2,
		eDT_ios			= 3,

		eDT_max,
	};


#pragma pack(push, 1)

	typedef struct sPacket
	{
		unsigned __int8		_packet_type;
		unsigned __int8		_device_type;
		unsigned __int16	_the_packet_header_size;
		unsigned __int32	_the_whole_packet_size;
	}Packet, *PPacket;

#pragma pack(pop)

#define PACKET_SIZE	8
};

