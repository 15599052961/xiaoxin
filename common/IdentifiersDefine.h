/*
 *	author:oiooooio(wl)
 *
 *	此头文件只定义公用部分，包括核心代码需要用到的代码
 */

#pragma once

#include "stdafx.h"

#include "boost/asio.hpp"
#include "boost/shared_ptr.hpp"


#define	IP_V4_LEN					15
#define IP_V4_LEN_END_SYMBOL		IP_V4_LEN+1

#define	PORT_STRING_LEN				5

#define DATABASE_NAME_LEN			50
#define DATABASE_ACCOUNT_NAME_LEN	50
#define DATABASE_ACCOUNT_PWD		20

#define TIME_STRING_LEN				32

//用户名和密码长度需要移动到其他地方定义
#define USER_NAME_LEN				50
#define USER_NAME_LEN_END_SYMBOL	USER_NAME_LEN+1
#define USER_PWD_LEN				50
#define USER_PWD_LEN_END_SYMBOL		USER_PWD_LEN+1


#define SINGLE_MODEL(_class)		public: \
									~_class( void ); \
									static _class* GetInstance(){return _instance == NULL ? (_instance = new _class()) : _instance;} \
									private: \
									_class( void ); \
									static _class* _instance;

#define SINGLE_MODEL_DEL(_class)	public:\
									static void DeleteInstance(){if(_instance!=NULL){\
									delete _instance; _instance = NULL;}}

#define SAFE_DELETE1(p, call_func)	{if(p!=NULL){p->call_func();delete p;p=NULL;}}
#define SAFE_DELETE(p)				{if(p!=NULL){delete p;p=NULL;}}
#define SAFE_DELETE_ARRAY(p)		{if(p!=NULL){delete [] p;p=NULL;}}

#define SIC							defined(SHOW_INFO)&&defined(_CONSOLE)
#define SID							defined(SHOW_INFO)&&defined(_DEBUG)
#define CML							defined(CHILD_SERVER) || defined(MIDDLE_SERVER) || defined(LOGIN_SERVER)

#define ASSERT_THROW				assert(false);\
									throw std::exception(__FUNCTION__, __LINE__)

#define PRINT_FFL					printf("%s:%s:%d.\n", __FILE__, __FUNCTION__, __LINE__)

//////////////////////////////////////////////////////////////////////////
#ifdef LOGIN_SERVER
#define	REGISTER_RESERVE			5000
#endif



typedef boost::asio::ip::tcp::socket	_my_socket;
typedef _my_socket*						_pmy_socket;

typedef boost::shared_ptr<_my_socket>	_my_sp_socket;
