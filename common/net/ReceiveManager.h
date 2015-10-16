/*
 * author:wl(oiooooio)
 *
 *	ReceiveManager：
 *		类@class Acceptor, @class Connector的辅助类
 *
 *	凡继承ReceiveManager的类，在处理从ReceiveManager处获取的socket*对象时，都不得擅自关闭socket*以及释放，如要关闭，
 *	应该使用ReceiveManager::CloseSocket(...)方法来处理
 */


#pragma once

#include "SendOrRecvMngBase.h"
#include "MessageQueue.h"
#include "SocketManager.h"

class ReceiveManager : public SendOrRecvMngBase
{
	friend class Acceptor_Connector_Base;

protected:
	ReceiveManager(unsigned int recvBufferSize);
	virtual ~ReceiveManager(void);

protected:
	virtual void First(boost::asio::ip::tcp::socket* socket){/*可以不继承*/};
	virtual void DoData(mc_system_msg::PPerHandleData handledata, std::size_t bytes_transferred) = 0{assert(false);throw;}

private:
	void SetSocketManager(SocketManager* socketManager){_socket_manager = socketManager;}
	void Dispatch(mc_system_msg::PPerHandleData handledata);
	virtual void CloseSocket(_pmy_socket socket, const char* description);

private:
	bool PostReceive(boost::asio::ip::tcp::socket* socket);
	bool PostReceive(mc_system_msg::PPerHandleData handledata);

	void AsynReceive(mc_system_msg::PPerHandleData handledata, const boost::system::error_code& error, std::size_t bytes_transferred);
	bool Receive(mc_system_msg::PPerHandleData handledata, std::size_t bytes_transferred);

private:
	SocketManager* _socket_manager;
	MessageQueue* _msg_queue;
};


inline
	void ReceiveManager::CloseSocket(_pmy_socket socket, const char* description)
{
	if(socket == NULL){
		return ;
	}

	if(_socket_manager != NULL)
	{
		_socket_manager->SocketClosed(socket);
	}
}

inline
	bool ReceiveManager::PostReceive( boost::asio::ip::tcp::socket* socket )
{
	if(!socket->is_open()){
		CloseSocket(socket, __FUNCTION__);
		return false;
	}

	mc_system_msg::PPerHandleData tmp_perHandledata = GetData(socket);

	if(tmp_perHandledata == NULL){
		assert(false && "allocate memory failed");
		return false;
	}

	socket->async_receive(boost::asio::buffer(tmp_perHandledata->_buffer, _buffer_size), 
		boost::bind(&ReceiveManager::AsynReceive, this, tmp_perHandledata, _1, _2));
	
	return true;
}

inline
	bool ReceiveManager::PostReceive( mc_system_msg::PPerHandleData handledata )
{
	if(!handledata->_socket->is_open()){
		CloseSocket(handledata->_socket, __FUNCTION__);
		return false;
	}

	if(handledata == NULL){
		assert(handledata);
		return false;
	}

	handledata->_socket->async_receive(boost::asio::buffer(((char*)handledata->_buffer+handledata->_offset), _buffer_size-handledata->_offset), 
		boost::bind(&ReceiveManager::AsynReceive, this, handledata, _1, _2));

	return true;
}

inline
	void ReceiveManager::Dispatch(mc_system_msg::PPerHandleData handledata)
{
	DoData(handledata, handledata->_offset);
}