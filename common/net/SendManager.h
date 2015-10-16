#pragma once

#include "SendOrRecvMngBase.h"
#include "msg\Packet.h"
#include "msg\MessageType.h"

class SendManager : public SendOrRecvMngBase
{
protected:
	virtual ~SendManager(void);
	SendManager(unsigned int bufferSize);

public:
	int PostSend( mc_system_msg::sPerHandleData* data );
	int PostError(boost::asio::ip::tcp::socket* socket, int errorcode, __int16 categoty, __int16 protocol, 
		mc_system_msg::ePacketType packet, mc_system_msg::eDeviceType device);

	virtual mc_system_msg::sPerHandleData* GetData(boost::asio::ip::tcp::socket* socket, __int16 categoty, __int16 protocol);
	virtual mc_system_msg::sPerHandleData* GetData( boost::asio::ip::tcp::socket* socket, __int16 categoty, __int16 protocol, 
		int wholePacketSize, mc_system_msg::ePacketType packet, mc_system_msg::eDeviceType device);

private:
	void SendComplete( mc_system_msg::sPerHandleData* data, const boost::system::error_code& error, std::size_t bytes_transferred );
};

inline
	mc_system_msg::sPerHandleData* SendManager::GetData( boost::asio::ip::tcp::socket* socket, __int16 categoty, __int16 protocol )
{
	mc_system_msg::PPerHandleData tmp_data = SendOrRecvMngBase::GetData(socket);
	//assert(tmp_data != NULL);

	if(tmp_data != NULL){
		mc_system_msg::sMessageRoot* tmp_root = (mc_system_msg::sMessageRoot*)tmp_data->_buffer;
		tmp_root->_message_type_category = categoty;
		tmp_root->_message_type_protocol = protocol;
	}
	
	return tmp_data;
}

inline
	mc_system_msg::sPerHandleData* SendManager::GetData( boost::asio::ip::tcp::socket* socket, __int16 categoty, __int16 protocol, int wholePacketSize,
													 mc_system_msg::ePacketType packet, mc_system_msg::eDeviceType device)
{
	mc_system_msg::PPerHandleData tmp_data = SendManager::GetData(socket, categoty, protocol);
	//assert(tmp_data != NULL);

	if(tmp_data != NULL){
		mc_system_msg::sMessageRoot* tmp_root = (mc_system_msg::sMessageRoot*)tmp_data->_buffer;
		tmp_root->_the_packet_header_size = sizeof(mc_system_msg::Packet);
		tmp_root->_the_whole_packet_size = tmp_data->_offset = wholePacketSize;
		tmp_root->_device_type = device;
		tmp_root->_packet_type = packet;
	}

	return tmp_data;
}
