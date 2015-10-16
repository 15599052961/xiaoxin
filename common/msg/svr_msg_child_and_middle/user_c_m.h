#pragma once

#include "..\MessageType.h"

#pragma pack(push, 1)

namespace mc_system_msg_c_m
{
	enum eC_M_user
	{
		eCMU_none = 0,				//none

		eCMU_add_user_c_m_req,		//c->m ����û�

		eCMU_remove_user_c_m_req,	//c->m �Ƴ��û�
			
		eCMU_send_msg_c_m_req,		//c->m ��ָ���û�������Ϣ
		eCMU_send_msg_c_m_res,		//m->c ���ظ�c-s�������
		eCMU_send_msg_m_c_req,		//m->c ���͸�ָ���ӷ�������Ϣ�壬Ȼ���ӷ������ٴ�ת�����û�
		eCMU_send_msg_m_c_res,		//c->m Ŀ��c-s��m-s���ؽ����ϣ���ѽ����֪��ʼ��c-s
	};


	struct sCMAddUserReq : public mc_system_msg::sMessageRoot
	{
		unsigned __int64 _user_id;
		unsigned __int16 _svr_id;
	};

	struct sCMARemoveUserReq : public mc_system_msg::sMessageRoot
	{
		unsigned __int64 _user_id;
	};

	struct sCMSendMsgToUserReq : public mc_system_msg::sMessageRoot
	{
		/*
		 *	Ŀ���û�id����Ҫ��ʼ��c-s����
		 */
		unsigned __int64 _target_user_id;
		
		/*
		 *	���id��Ŀ�����ڣ���m-s����Ϣ�ɹ����͵�Ŀ��c-sʱ��ȴ���û����ߵȴ�������Ϣ���մ���ʧ�ܣ�������Ϣԭ·���أ�
		 *	��ʱ��m-s�յ���Ϣʱ���Ϳ��Ը���_socket_id�ٴΰ���Ϣԭ·���ص�ʼ��c-s,���_socket_id��Ҫm-s��ֵ��
		 */
		int _socket_id;

		/*
		 *	��Ϣ�壬����Ϣ��Ľṹ�Ƚ����⣬��Ϊ�����Ϣ���ӿͻ��˷����ӷ��������ӷ�������ͨ��m-sת����Ŀ�ĵأ�
		 *	Ϊ�˼������ܺ��ٶȵĿ������ͰѴӿͻ��˷�������Ϣ��ԭ�ⲻ���Ŀ�����_message�У�_message��һ���ɱ䳤�����顣
		 *	��һ�����ƣ����ǿ�����_message������ݵĳ���+_target_user_id���ܴ��ڷ��ͻ������ĳ��ȣ������Ҫ�ر�ע�⡣
		 *	��Ϣ��ԭ�ⲻ���Ŀ�����_message�У�����仰�Ľ���Ϊ���������İ���������ͷ+��Ϣ��
		 *	�����Ϣ����Ҫ��ʼ��c-s����
		 */
		char _message[1];

	};

	enum eCMSendMsgToUser
	{
		eCMSMTU_none = 0,

		/*
		 *	δ�ҵ����û�
		 */
		eCMSMTU_not_found_user,

		/*
		 *	�û������Լ��ķ�������Ҳ�����û����ʹ����ڷ��ͷ��Լ��ķ������ϣ����ͷ�ָ�ӷ�
		 */
		eCMSMTU_user_at_self_server,
	};

	struct sCMSendMsgToUserRes : public sCMSendMsgToUserReq
	{
		/*
		 *	һ����˵������ɹ����ͣ��Ͳ����ؽ����һ�����ؽ�����ͱ�ʾ��������
		 *	
		 *	����Ϊ���ִ�����߷���ʧ��ʱ�����sCMSendMsgToUserReq��Ϣ�ṹ�������ķ��ظ�c-s����ʱ
		 *	_target_user_id�����Ƿ��صĴ����룬�������û�id
		 */
	};
};


#pragma pack(pop)