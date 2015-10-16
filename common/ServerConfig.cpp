#include "stdafx.h"
#include "ServerConfig.h"
#include <assert.h>
#include "ErrorEnum.h"
#include "PublicFunc.h"

#define DEFUALT_SEND_BUFFER_SIZE	0x4000
#define DEFUALT_RECEIVE_BUFFER_SIZE 0x4000

#define DEFUALT_DATABASE_RECEIVE_BUFFER_SIZE 0x8000	//32K

#define PORT1			"_port1"
#define PORT2			"_port2"
#define SEVER_IP1		"_server_ip1"
#define SEVER_IP2		"_server_ip2"
#define SOCKET_COUNT	"_prepare_accept_socket_count1"
#define WORK_COUNT1		"_acceptor_work_count1" 
#define WORK_COUNT2		"_acceptor_work_count2"
#define RECEIVE_BUFFER1	"_receive_buffer_size1"
#define REVEIVE_BUFFER2	"_receive_buffer_size2"
#define SEND_BUFFER1	"_send_buffer_size1"
#define SEND_BUFFER2	"_send_buffer_size2"
#define DB_NAME			"_database_name"
#define DB_ACCOUNT		"_database_account_name"
#define DB_PWD			"_database_account_pwd"
#define DB_WORK_THREAD	"_database_work_thread_count"
#define DB_RECEIVE_BUFFER			"_database_receive_buffer_size"
#define DB_TRANSFER_WORK_THREAD		"_info_transfer_station_work_thread_count"

ServerConfig* ServerConfig::_instance = NULL;

ServerConfig::_config_data::_config_data()
	:_acceptor_work_count1(0)
	,_acceptor_work_count2(0)
	,_port1(0)
	,_port2(0)
	,_prepare_accept_socket_count1(0)
	,_receive_buffer_size1(0)
	,_receive_buffer_size2(0)
	,_send_buffer_size1(0)
	,_send_buffer_size2(0)
{
	memset(_database_account_name, 0, sizeof(_database_account_name));
	memset(_database_account_pwd, 0, sizeof(_database_account_pwd));
	memset(_database_name, 0, sizeof(_database_name));
}

ServerConfig::ServerConfig(void)
{
	#if defined(MIDDLE_SERVER)
	_c_d._acceptor_work_count1	= 4;
	_c_d._acceptor_work_count2	= 1;
	_c_d._port1					= 8001;
	_c_d._port2					= 8002;
	_c_d._receive_buffer_size1	= DEFUALT_RECEIVE_BUFFER_SIZE;
	_c_d._receive_buffer_size2	= DEFUALT_RECEIVE_BUFFER_SIZE;
	_c_d._send_buffer_size1		= DEFUALT_SEND_BUFFER_SIZE;
	_c_d._send_buffer_size2		= DEFUALT_SEND_BUFFER_SIZE;
	_c_d._server_ip1				= "192.168.1.78";
	_c_d._server_ip2				= "192.168.1.78";
	_c_d._prepare_accept_socket_count1 = 2000;
	_c_d._info_transfer_station_work_thread_count = 4;

	_c_d._database_receive_buffer_size = DEFUALT_DATABASE_RECEIVE_BUFFER_SIZE;
	_c_d._database_work_thread_count = 1;

	wcscpy_s(_c_d._database_name,		 L"ConfigDb");
	wcscpy_s(_c_d._database_account_name,L"millionserver");
	wcscpy_s(_c_d._database_account_pwd, L"123456");
	#elif defined(LOGIN_SERVER)
	_c_d._acceptor_work_count1	= 8;
	_c_d._acceptor_work_count2	= 1;
	_c_d._port1					= 8003;
	_c_d._port2					= 8002;
	_c_d._receive_buffer_size1	= DEFUALT_RECEIVE_BUFFER_SIZE;
	_c_d._receive_buffer_size2	= DEFUALT_RECEIVE_BUFFER_SIZE;
	_c_d._send_buffer_size1		= DEFUALT_SEND_BUFFER_SIZE;
	_c_d._send_buffer_size2		= DEFUALT_SEND_BUFFER_SIZE;
	_c_d._server_ip1			= "192.168.1.78";
	_c_d._server_ip2			= "192.168.1.78";
	_c_d._prepare_accept_socket_count1 = 2000;
	_c_d._info_transfer_station_work_thread_count = 4;

	_c_d._database_receive_buffer_size = DEFUALT_DATABASE_RECEIVE_BUFFER_SIZE;
	_c_d._database_work_thread_count = 1;

	wcscpy_s(_c_d._database_name,		 L"UserIndexDb");
	wcscpy_s(_c_d._database_account_name,L"millionserver");
	wcscpy_s(_c_d._database_account_pwd, L"123456");
	#elif defined(CHILD_SERVER)
	_c_d._acceptor_work_count1	= 8;
	_c_d._acceptor_work_count2	= 4;
	_c_d._port1					= 8004;
	_c_d._port2					= 8001;
	_c_d._receive_buffer_size1	= DEFUALT_RECEIVE_BUFFER_SIZE;
	_c_d._receive_buffer_size2	= DEFUALT_RECEIVE_BUFFER_SIZE;
	_c_d._send_buffer_size1		= DEFUALT_SEND_BUFFER_SIZE;
	_c_d._send_buffer_size2		= DEFUALT_SEND_BUFFER_SIZE;
	_c_d._server_ip1			= "192.168.1.78";
	_c_d._server_ip2			= "192.168.1.78";
	_c_d._prepare_accept_socket_count1 = 2000;
	_c_d._info_transfer_station_work_thread_count = 4;

	_c_d._database_receive_buffer_size = DEFUALT_DATABASE_RECEIVE_BUFFER_SIZE;
	_c_d._database_work_thread_count = 1;

	wcscpy_s(_c_d._database_name,		 L"ConfigDb");
	wcscpy_s(_c_d._database_account_name,L"millionserver");
	wcscpy_s(_c_d._database_account_pwd, L"123456");
	#endif
}

ServerConfig::~ServerConfig(void)
{
}

int ServerConfig::Initialize( const wchar_t* script_file_name )
{
	assert(script_file_name != NULL);

	if(ReadConfigScript(script_file_name) != mc_system::SUCCESS)
	{
		assert(false && "read script file failed");
		return mc_system::FAILED;
	}

	//initialize work thread count is the same as the count of cpu * 2 
	//...

	return mc_system::SUCCESS;
}

int ServerConfig::ReadConfigScript( const wchar_t* file_name )
{
	using namespace std;
	using namespace mc_system_public_function;

	fstream tmpFile(file_name, ios_base::in);

	if(!tmpFile.is_open()){
		assert(false);
		return mc_system::FAILED;
	}

	string tmp_string = "";
	char tmpBuffer[4096] = {};
	char tmpTransferStation[4096] = {};

	while (tmpFile.getline(tmpBuffer, 4096))
	{
		for (size_t i=0, j=0; i<strlen(tmpBuffer); ++i)
		{
			if(tmpBuffer[i] == '-'){
				break;
			}

			if(tmpBuffer[i] >= 'a' && tmpBuffer[i] <= 'z' ||\
				tmpBuffer[i] >= 'A' && tmpBuffer[i] <= 'Z' ||\
				tmpBuffer[i] >= '0' && tmpBuffer[i] <= '9' ||\
				tmpBuffer[i] == ':' ||\
				tmpBuffer[i] == '_' ||\
				tmpBuffer[i] == '.'){
				
					tmpTransferStation[j++] = tmpBuffer[i];
			}
		}

		if(strlen(tmpTransferStation) == 0){
			continue;
		}

		tmp_string = tmpTransferStation;
		size_t tmpPos = tmp_string.find(":");

		if( tmp_string.find(PORT1)!=-1)
			_c_d._port1 = atoi(tmpTransferStation+tmpPos+1);
		else if( tmp_string.find(PORT2)!=-1 )
			_c_d._port2 = atoi( tmpTransferStation+tmpPos+1);
		else if( tmp_string.find(SEVER_IP1)!=-1 )
			_c_d._server_ip1 = tmpTransferStation+tmpPos+1;
		else if( tmp_string.find(SEVER_IP2)!=-1 )
			_c_d._server_ip2 = tmpTransferStation+tmpPos+1;
		else if( tmp_string.find(SOCKET_COUNT)!=-1 )
			_c_d._prepare_accept_socket_count1 = atoi(tmpTransferStation+tmpPos+1);
		else if( tmp_string.find(WORK_COUNT1)!=-1 )
			_c_d._acceptor_work_count1 = atoi(tmpTransferStation+tmpPos+1);
		else if( tmp_string.find(WORK_COUNT2)!=-1 )
			_c_d._acceptor_work_count2 = atoi(tmpTransferStation+tmpPos+1);
		else if(tmp_string.find(RECEIVE_BUFFER1)!=-1 )
			_c_d._receive_buffer_size1 = strtol( tmpTransferStation+tmpPos+1, NULL, 16);
		else if( tmp_string.find(REVEIVE_BUFFER2)!=-1 )
			_c_d._receive_buffer_size2 = strtol( tmpTransferStation+tmpPos+1, NULL, 16);
		else if( tmp_string.find(SEND_BUFFER1)!=-1 )
			_c_d._send_buffer_size1 = strtol(tmpTransferStation+tmpPos+1, NULL, 16);
		else if( tmp_string.find(SEND_BUFFER2)!=-1 )
			_c_d._send_buffer_size2 = strtol(tmpTransferStation+tmpPos+1, NULL, 16);
		else if( tmp_string.find(DB_TRANSFER_WORK_THREAD)!=-1 )
			_c_d._info_transfer_station_work_thread_count = atoi(tmpTransferStation+tmpPos+1);
		else if( tmp_string.find(DB_RECEIVE_BUFFER)!=-1 )
			_c_d._database_receive_buffer_size = strtol(tmpTransferStation+tmpPos+1, NULL, 16);
		else if( tmp_string.find(DB_WORK_THREAD)!=-1 )
			_c_d._database_work_thread_count = atoi(tmpTransferStation+tmpPos+1);
		else if( tmp_string.find(DB_NAME)!=-1 ) 
			CharConvertToWchar(tmpTransferStation+tmpPos+1, strlen(tmpTransferStation+tmpPos+1), _c_d._database_name, sizeof(_c_d._database_name));
		else if( tmp_string.find(DB_ACCOUNT)!=-1 )
			CharConvertToWchar(tmpTransferStation+tmpPos+1, strlen(tmpTransferStation+tmpPos+1), _c_d._database_account_name, sizeof(_c_d._database_account_name));
		else if( tmp_string.find(DB_PWD)!=-1 )
			CharConvertToWchar(tmpTransferStation+tmpPos+1, strlen(tmpTransferStation+tmpPos+1), _c_d._database_account_pwd, sizeof(_c_d._database_account_pwd));
	
		memset(tmpBuffer, 0, 4096);
		memset(tmpTransferStation, 0, 4096);
	}

	//do nothing
	return mc_system::SUCCESS;
}


