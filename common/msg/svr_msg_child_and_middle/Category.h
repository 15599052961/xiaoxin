#pragma once

namespace mc_system_msg_c_m
{
	enum eMessage_type
	{
		eMT_none				= 0,
		eMT_Child_and_Middle	= 1,	//����c-m֮����ӷ�������Ϣ��������Ϣ��
		eMT_loading_report		= 2,	//���ر���
		eMT_user_c_m,					//����c-m֮����û���Ϣ

		eMT_max,
	};
};