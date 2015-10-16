#pragma once

#include "boost/asio.hpp"

class ReceiveManager;
class SendManager;
class SendOrRecvMngBase;

namespace mc_system_msg
{
	typedef struct sPerHandleData
	{
		friend class::ReceiveManager;
		friend class::SendManager;
		friend class::SendOrRecvMngBase;

/*	private:*/
		boost::asio::ip::tcp::socket* _socket;

		char* _buffer;

		unsigned __int32 _buffer_size;

		unsigned __int32 _offset;
		 
	public:
		boost::asio::ip::tcp::socket* Socket() const { return _socket; }
		unsigned __int32 Buffer_size() const { return _buffer_size; }
		unsigned __int32 Offset() const { return _offset; }
		char* Buffer() const { return _buffer; }

	public:
		void Offset(unsigned __int32 val) { _offset = val; }
		void Socket(boost::asio::ip::tcp::socket* val) { _socket = val; }

	private:
		void Clear(){
			_socket = NULL;
			_buffer_size = 0;
			_offset = 0;

			//在调用此方法之前，请释放_buffer内存
			_buffer = NULL;
		}

	public:
		sPerHandleData(char* buffer, unsigned __int32 buffer_size, boost::asio::ip::tcp::socket* socket)
		{
			_socket = socket;
			_buffer = buffer;
			_buffer_size = buffer_size;
			_offset = 0;
		}

		~sPerHandleData(){
			Clear();
		}

		const sPerHandleData& operator= (const sPerHandleData& data)
		{
			_socket = data._socket;
			_buffer_size = data._buffer_size;
			_offset = data._offset;
			memcpy(_buffer, data._buffer, _buffer_size);
			
			return *this;
		}

	}PerHandleData, *PPerHandleData;
};

