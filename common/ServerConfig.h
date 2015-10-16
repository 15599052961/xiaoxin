#pragma once
#include <string>
#include "IdentifiersDefine.h"
#include <fstream>

/// <summary>
/// �����������࣬�����벻Ҫֱ��������Common�ļ�������κ��ļ�����������
/// </summary>
class ServerConfig
{
	class _config_data
	{
	public:
		_config_data();

	public:
		/// <summary>
		/// child-server:	���û������Ľӿ�
		/// middle-server:	��child-server�����Ľӿ�
		/// login-server:	���û������Ľӿ�
		/// </summary>
		unsigned int		_port1;
		/// <summary>
		/// child-server:	��middle-server�����Ľӿ�
		/// middle-server:	��login-server�����Ľӿ�
		/// login-server:	��middle-server�����Ľӿ�
		/// </summary>
		unsigned int		_port2;

		/// <summary>
		/// ip-v4 ip
		/// child-server:	���û�������ip
		/// middle-server:	null
		/// login-server:	���û�������ip
		/// </summary>
		std::string			_server_ip1;
		/// <summary>
		/// ip-v4 ip
		/// child-server:	��middle-server������ip
		/// middle-server:	null
		/// login-server:	��middle-server������ip
		/// </summary>
		std::string			_server_ip2;

		/// <summary>
		/// ׼�����ܿͻ��˵�socket����
		/// child-server:	���û�������acceptor��׼�����ܿͻ��˵�socket����
		/// middle-server:	null
		/// login-server:	���û�������acceptor��׼�����ܿͻ��˵�socket����
		/// </summary>
		unsigned int		_prepare_accept_socket_count1;
		/// <summary>
		/// child-server:	���û�������acceptor�Ĺ����߳�
		/// middle-server:	��child-server������acceptor�Ĺ����߳�
		/// login-server:	���û�������acceptor�Ĺ����߳�
		/// </summary>
		unsigned short		_acceptor_work_count1;
		/// <summary>
		/// child-server:	��middle-server������acceptor�Ĺ����߳�
		/// middle-server:	��login-server������acceptor�Ĺ����߳�
		/// login-server:	��middle-server������acceptor�Ĺ����߳�
		/// </summary>
		unsigned short		_acceptor_work_count2;

		/// <summary>
		/// child-server:	���û������Ľ��ջ�������С
		/// middle-server:	��child-server�����Ľ��ջ�������С
		/// login-server:	���û������Ľ��ջ�������С
		/// </summary>
		unsigned int		_receive_buffer_size1;
		/// <summary>
		/// child-server:	��middle-server�����Ľ��ջ�������С
		/// middle-server:	��login-server�����Ľ��ջ�������С
		/// login-server:	��middle-server�����Ľ��ջ�������С
		/// </summary>
		unsigned int		_receive_buffer_size2;

		/// <summary>
		/// child-server:	���û������ķ��ͻ�������С
		/// middle-server:	��child-server�����ķ��ͻ�������С
		/// login-server:	���û������ķ��ͻ�������С
		/// </summary>
		unsigned int		_send_buffer_size1;
		/// <summary>
		/// child-server:	��middle-server�����ķ��ͻ�������С
		/// middle-server:	��login-server�����ķ��ͻ�������С
		/// login-server:	��middle-server�����ķ��ͻ�������С
		/// </summary>
		unsigned int		_send_buffer_size2;


		/// <summary>
		/// �����ݿ�������ݽ����ĺͰ����ݽ����ϲ㴦��ġ�������תվ���߳�����
		/// </summary>
		unsigned short		_info_transfer_station_work_thread_count;


		/// <summary>
		/// ���ݿ�����
		/// child-server:	null
		/// middle-server:	���������ݿ����ӵ����ݿ�����
		/// login-server:	���û�ע�����ݿ����ӵ����ݿ����ƣ��û��������ݿ⣩
		/// </summary>
		wchar_t				_database_name[DATABASE_NAME_LEN];
		/// <summary>
		/// ���ݿ��˻�����
		/// child-server:	null
		/// middle-server:	���������ݿ����ӵ����ݿ��˻�����
		/// login-server:	���û�ע�����ݿ����ӵ����ݿ��˻����ƣ��û��������ݿ⣩
		/// </summary>
		wchar_t				_database_account_name[DATABASE_ACCOUNT_NAME_LEN];
		/// <summary>
		/// ���ݿ��˻�����
		/// child-server:	null
		/// middle-server:	���������ݿ����ӵ����ݿ��˻�����
		/// login-server:	���û�ע�����ݿ����ӵ����ݿ��˻����루�û��������ݿ⣩
		/// </summary>
		wchar_t				_database_account_pwd[DATABASE_ACCOUNT_PWD];

		/// <summary>
		/// ���ݿ⽻����������С
		/// </summary>
		unsigned int		_database_receive_buffer_size;
		/// <summary>
		/// ���ݿ⹤���߳�
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