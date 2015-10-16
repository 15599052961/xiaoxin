#pragma once

#include "Acceptor_Connector_Base.h"

class Acceptor : public Acceptor_Connector_Base
{
public:
	Acceptor(const char* ip, unsigned int port, unsigned int prepare_accept_socket_count);
	virtual ~Acceptor(void);

	virtual void*	Initialize(ReceiveManager* recvMng);
	virtual bool	Start();
	virtual bool	Stop();

private:
	virtual void	ReleaseResource();

	int		PostAccept(boost::asio::ip::tcp::acceptor* acceptor);
	void	accept_handler(_pmy_socket socket, const boost::system::error_code& error);

private:
	boost::asio::ip::tcp::acceptor* _acceptor;
	unsigned int _max_prepare_accept_count;
};

