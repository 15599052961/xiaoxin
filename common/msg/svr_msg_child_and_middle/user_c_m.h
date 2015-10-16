#pragma once

#include "..\MessageType.h"

#pragma pack(push, 1)

namespace mc_system_msg_c_m
{
	enum eC_M_user
	{
		eCMU_none = 0,				//none

		eCMU_add_user_c_m_req,		//c->m 添加用户

		eCMU_remove_user_c_m_req,	//c->m 移除用户
			
		eCMU_send_msg_c_m_req,		//c->m 给指定用户发送消息
		eCMU_send_msg_c_m_res,		//m->c 返回给c-s发送情况
		eCMU_send_msg_m_c_req,		//m->c 发送给指定子服务器消息体，然后子服务器再次转发给用户
		eCMU_send_msg_m_c_res,		//c->m 目的c-s给m-s返回结果，希望把结果告知给始发c-s
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
		 *	目标用户id，需要在始发c-s给定
		 */
		unsigned __int64 _target_user_id;
		
		/*
		 *	这个id的目的在于，当m-s把消息成功发送到目标c-s时，却因用户下线等错误导致消息最终传递失败，而把消息原路返回，
		 *	这时当m-s收到消息时，就可以根据_socket_id再次把消息原路返回到始发c-s,这个_socket_id需要m-s赋值。
		 */
		int _socket_id;

		/*
		 *	消息体，此消息体的结构比较特殊，因为这个消息包从客户端发到子服务器，子服务器在通过m-s转发到目的地，
		 *	为了减少性能和速度的开销，就把从客户端发来的消息包原封不动的拷贝到_message中，_message是一个可变长的数组。
		 *	有一个限制，就是拷贝到_message里的内容的长度+_target_user_id不能大于发送缓冲区的长度，这点需要特别注意。
		 *	消息包原封不动的拷贝到_message中：对这句话的解释为整个完整的包，包括包头+消息体
		 *	这个消息体需要在始发c-s给定
		 */
		char _message[1];

	};

	enum eCMSendMsgToUser
	{
		eCMSMTU_none = 0,

		/*
		 *	未找到的用户
		 */
		eCMSMTU_not_found_user,

		/*
		 *	用户就在自己的服务器，也就是用户本就存在于发送方自己的服务器上，发送方指子服
		 */
		eCMSMTU_user_at_self_server,
	};

	struct sCMSendMsgToUserRes : public sCMSendMsgToUserReq
	{
		/*
		 *	一般来说，如果成功发送，就不返回结果，一旦返回结果，就表示发生错误
		 *	
		 *	当因为出现错误或者发送失败时，会把sCMSendMsgToUserReq消息结构体完整的返回给c-s，这时
		 *	_target_user_id里存的是返回的错误码，不再是用户id
		 */
	};
};


#pragma pack(pop)