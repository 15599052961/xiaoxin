#pragma once

#include "boost/asio.hpp"

namespace mc_system_db
{
	typedef struct sPerhandleDataDB
	{
		int								_sql_msg_type;
		boost::asio::ip::tcp::socket*	_client;

		void*							_buffer;
		unsigned __int32				_buffer_size;
		unsigned __int32				_offset;

		unsigned __int32				_buffer_ex_size;
		void*							_buffer_ex;

		explicit sPerhandleDataDB(void* buffer, unsigned __int32 buffer_size)
		{
			_buffer = buffer;
			_buffer_size = buffer_size;
			_offset = 0;
			_buffer_ex_size = 0;
			_buffer_ex = NULL;
			_sql_msg_type = 0;
			_client = NULL;
		}
	}PerhandleDataDB, *PPerhandleDataDB;
};