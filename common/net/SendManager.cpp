#include "stdafx.h"
#include "SendManager.h"
#include "ErrorEnum.h"
#include "boost/bind.hpp"
#include "boost/function.hpp"
#include "ServerConfig.h"


SendManager::SendManager(unsigned int bufferSize)
	:SendOrRecvMngBase(bufferSize)
{
}

SendManager::~SendManager(void)
{
}

int SendManager::PostSend( mc_system_msg::sPerHandleData* data )
{
	if(data == NULL || data->_socket == NULL){
		assert(false && "The data or socket is null");
		//throw new std::exception("The data or socket is null");
		return mc_system::FAILED;
	}

	if(data->_offset > _buffer_size){
		assert(false && "it is larger data");
		//throw new std::exception("it is larger data");
		return mc_system::FAILED;
	}

	data->_socket->async_write_some(boost::asio::buffer(data->_buffer, data->_offset), 
		boost::bind(&SendManager::SendComplete, this, data, _1, _2));

	return mc_system::SUCCESS;
}

int SendManager::PostError( boost::asio::ip::tcp::socket* socket, int errorcode, __int16 categoty, __int16 protocol, mc_system_msg::ePacketType packet, mc_system_msg::eDeviceType device )
{
	assert(socket != NULL);

	mc_system_msg::sPerHandleData* tmpData = SendManager::GetData(socket, categoty, protocol, sizeof(mc_system_msg::sMessageError), packet, device);

	//assert(tmpData != NULL);

	if(tmpData == NULL){
		return mc_system::FAILED;
	}

	mc_system_msg::sMessageError* tmpErr = (mc_system_msg::sMessageError*) tmpData->_buffer;

	tmpErr->_error_code = errorcode;

	return PostSend(tmpData);
}

void SendManager::SendComplete( mc_system_msg::sPerHandleData* data, const boost::system::error_code& error, std::size_t bytes_transferred )
{
	ReleaseMemory(data);
}
