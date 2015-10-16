#pragma once
#include <string>
#include "IdentifiersDefine.h"
#include <fstream>

/// <summary>
/// 服务器配置类，此类请不要直接作用于Common文件夹里的任何文件，除过本身
/// </summary>
class ServerConfig
{
	class _config_data
	{
	public:
		_config_data();

	public:
		/// <summary>
		/// child-server:	与用户交互的接口
		/// middle-server:	与child-server交互的接口
		/// login-server:	与用户交互的接口
		/// </summary>
		unsigned int		_port1;
		/// <summary>
		/// child-server:	与middle-server交互的接口
		/// middle-server:	与login-server交互的接口
		/// login-server:	与middle-server交互的接口
		/// </summary>
		unsigned int		_port2;

		/// <summary>
		/// ip-v4 ip
		/// child-server:	与用户交互的ip
		/// middle-server:	null
		/// login-server:	与用户交互的ip
		/// </summary>
		std::string			_server_ip1;
		/// <summary>
		/// ip-v4 ip
		/// child-server:	与middle-server交互的ip
		/// middle-server:	null
		/// login-server:	与middle-server交互的ip
		/// </summary>
		std::string			_server_ip2;

		/// <summary>
		/// 准备接受客户端的socket数量
		/// child-server:	与用户交互的acceptor的准备接受客户端的socket数量
		/// middle-server:	null
		/// login-server:	与用户交互的acceptor的准备接受客户端的socket数量
		/// </summary>
		unsigned int		_prepare_accept_socket_count1;
		/// <summary>
		/// child-server:	与用户交互的acceptor的工作线程
		/// middle-server:	与child-server交互的acceptor的工作线程
		/// login-server:	与用户交互的acceptor的工作线程
		/// </summary>
		unsigned short		_acceptor_work_count1;
		/// <summary>
		/// child-server:	与middle-server交互的acceptor的工作线程
		/// middle-server:	与login-server交互的acceptor的工作线程
		/// login-server:	与middle-server交互的acceptor的工作线程
		/// </summary>
		unsigned short		_acceptor_work_count2;

		/// <summary>
		/// child-server:	与用户交互的接收缓冲区大小
		/// middle-server:	与child-server交互的接收缓冲区大小
		/// login-server:	与用户交互的接收缓冲区大小
		/// </summary>
		unsigned int		_receive_buffer_size1;
		/// <summary>
		/// child-server:	与middle-server交互的接收缓冲区大小
		/// middle-server:	与login-server交互的接收缓冲区大小
		/// login-server:	与middle-server交互的接收缓冲区大小
		/// </summary>
		unsigned int		_receive_buffer_size2;

		/// <summary>
		/// child-server:	与用户交互的发送缓冲区大小
		/// middle-server:	与child-server交互的发送缓冲区大小
		/// login-server:	与用户交互的发送缓冲区大小
		/// </summary>
		unsigned int		_send_buffer_size1;
		/// <summary>
		/// child-server:	与middle-server交互的发送缓冲区大小
		/// middle-server:	与login-server交互的发送缓冲区大小
		/// login-server:	与middle-server交互的发送缓冲区大小
		/// </summary>
		unsigned int		_send_buffer_size2;


		/// <summary>
		/// 与数据库进行数据交互的和把数据交给上层处理的‘数据中转站’线程数量
		/// </summary>
		unsigned short		_info_transfer_station_work_thread_count;


		/// <summary>
		/// 数据库名称
		/// child-server:	null
		/// middle-server:	与配置数据库连接的数据库名称
		/// login-server:	与用户注册数据库连接的数据库名称（用户索引数据库）
		/// </summary>
		wchar_t				_database_name[DATABASE_NAME_LEN];
		/// <summary>
		/// 数据库账户名称
		/// child-server:	null
		/// middle-server:	与配置数据库连接的数据库账户名称
		/// login-server:	与用户注册数据库连接的数据库账户名称（用户索引数据库）
		/// </summary>
		wchar_t				_database_account_name[DATABASE_ACCOUNT_NAME_LEN];
		/// <summary>
		/// 数据库账户密码
		/// child-server:	null
		/// middle-server:	与配置数据库连接的数据库账户密码
		/// login-server:	与用户注册数据库连接的数据库账户密码（用户索引数据库）
		/// </summary>
		wchar_t				_database_account_pwd[DATABASE_ACCOUNT_PWD];

		/// <summary>
		/// 数据库交互缓冲区大小
		/// </summary>
		unsigned int		_database_receive_buffer_size;
		/// <summary>
		/// 数据库工作线程
		/// </summary>
		unsigned int		_database_work_thread_count;
	};

	SINGLE_MODEL(ServerConfig)

public:
	int				Initialize(const wchar_t* script_file_name);

public:
	const char*		ServerIp1(void) const{return (const char*)_c_d._server_ip1.c_str();}
	const char*		ServerIp2(void) const{return (const char*)_c_d._server_ip2.c_str();}
	unsigned int	Port1(void)const{return _c_d._port1;}
	unsigned int	Port2(void)const{return _c_d._port2;}

	unsigned int	PrepareAcceptSocketCount1(void)const{return _c_d._prepare_accept_socket_count1;}
	unsigned short  AcceptorWorkCount1(void)const{return _c_d._acceptor_work_count1;}
	unsigned short  AcceptorWorkCount2(void)const{return _c_d._acceptor_work_count2;}


	unsigned int	ReceiveBufferSize1(void)const{return _c_d._receive_buffer_size1;}
	unsigned int	SendBufferSize1(void)const{return _c_d._send_buffer_size1;}
	unsigned int	ReceiveBufferSize2(void)const{return _c_d._receive_buffer_size2;}
	unsigned int	SendBufferSize2(void)const{return _c_d._send_buffer_size2;}


	unsigned short	InfoTransferStationWorkThreadCount(void)const{return _c_d._info_transfer_station_work_thread_count;}

	const wchar_t*	DatabaseName()const{return _c_d._database_name;}
	const wchar_t*	DatabaseAccountName()const{return _c_d._database_account_name;}
	const wchar_t*	DatabaseAccountPwd()const{return _c_d._database_account_pwd;}

	unsigned int	DatabaseReceiveBufferSize()const {return _c_d._database_receive_buffer_size;}
	unsigned int	DatabaseWorkThreadCount()const{return _c_d._database_work_thread_count;}

private:
	int				ReadConfigScript(const wchar_t* file_name);

private:
	_config_data _c_d;
};

#define SVRCONFIG ServerConfig::GetInstance()