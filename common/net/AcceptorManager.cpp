#include "stdafx.h"
#include "AcceptorManager.h"
#include "ErrorEnum.h"
#include "boost/thread.hpp"
#include "boost/bind.hpp"
#include "ServerConfig.h"
#include "IdentifiersDefine.h"



bool AcceptorManager::RunAll(char* ip, unsigned int port, ReceiveManager* recvMng, unsigned int prepare_accept_socket_count)
{
	if(recvMng == NULL || ip == NULL || port < 1000){
		assert(false);
		throw new std::exception("error");
	}

	unsigned int tmp_count = 3;

	while(!_is_end)
	{
		boost::shared_ptr<Acceptor> tmp_acceptor(new Acceptor(ip, port, prepare_accept_socket_count));

		if(tmp_acceptor->Initialize(recvMng) != (void*)mc_system::err::SUCCESS){
			ASSERT_THROW;
		}

		for (unsigned int i=0; i<_work_thread_count; ++i)
		{
			_thread_group.create_thread(boost::bind(&Acceptor::Start, tmp_acceptor));
		}

		_thread_group.join_all();
		tmp_acceptor.reset();

		--tmp_count;

		if(_is_end || tmp_count <= 0){
#ifdef _DEBUG
			if(tmp_count <= 0 && (!_is_end)){
				assert(false && "it occurs error and exit loop");
				throw new std::exception("void AcceptorManager::RunAll(...) occurs error");
			}
#endif
			break;
		}
	}

	return true;

	return false;
}


