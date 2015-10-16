#include "stdafx.h"
#include "ReceiveManager.h"
#include "boost\mpl\assert.hpp"
#include "boost\bind.hpp"
#include "msg\PerHandleData.h"
#include "msg\Packet.h"


ReceiveManager::ReceiveManager(unsigned int recvBufferSize)
	:SendOrRecvMngBase(recvBufferSize)
	,_socket_manager(NULL)
{
	_msg_queue	= new MessageQueue(recvBufferSize);

	if(_msg_queue != NULL){
		if(!_msg_queue->Init(boost::bind(&ReceiveManager::Dispatch, this, _1))){
			throw;
		}
	}
	else{
		throw;
	}

#ifdef SIC
	printf("receive manager has been launched.\n");
#endif
}

ReceiveManager::~ReceiveManager(void)
{
	//此类对象由@class Acceptor, @class Connector管理和维护
	//_socket_manager = NULL;
	SAFE_DELETE(_msg_queue);
}

void ReceiveManager::AsynReceive( mc_system_msg::PPerHandleData handledata, const boost::system::error_code& error, std::size_t bytes_transferred )
{
	//在拆包的时候，这个变量是有用的，因为拆包需要移动handledata->_buffer指针，使之不断指向下一个包
	//当处理完毕后，需要对handledata->_buffer缓冲区指针还原，以免释放缓冲区时出现问题
	char* tmpPtr = handledata->_buffer;

	//设置总共收到的消息的长度，必须要用+=，而不是=
	handledata->_offset += bytes_transferred;

	if(Receive(handledata, bytes_transferred))
	{
		//投递接收操作
		PostReceive(handledata->Socket());
	}

	//防止handledata->_buffer指针在Receive中被改变,还原指针值，希望指针被正确的释放
	handledata->_buffer = tmpPtr;
	ReleaseMemory(handledata);
}

/// <summary>
/// 此过程主要处理TCP消息的拆包和粘包过程，把处理完整的消息加入到消息队列
/// </summary>
/// <param name="handledata">The handledata.</param>
/// <param name="bytes_transferred">The bytes_transferred.</param>
/// <returns>int.</returns>
bool ReceiveManager::Receive( mc_system_msg::PPerHandleData handledata, std::size_t bytes_transferred )
{
	if(bytes_transferred == 0){
		//DoData(handledata, 0);
		_msg_queue->Add(handledata);
		return false;
	}

	using namespace mc_system_msg;

	do
	{
		PPacket tmpPacket = (PPacket)handledata->_buffer;

		if(handledata->_offset < PACKET_SIZE){
			//消息不全，跳转到[2]继续读取消息
			goto FALG_4;
		}
		else if(tmpPacket->_the_packet_header_size != PACKET_SIZE){
			return false;
		}

		/*[1]*/if(tmpPacket->_the_whole_packet_size == handledata->_offset){
			//DoData(handledata, bytes_transferred);
			_msg_queue->Add(handledata);
			return true;
		}
		/*[2]*/else if(handledata->_offset < tmpPacket->_the_whole_packet_size){
			/*
			 *	代码执行到这里，说明已收到的数据不是一个完整的包，需要再次接收剩下的数据，这里或许有一个疑问，为什么重新获取数据句柄？
			 *	原因在于下面一个判断[3]：
			 *	else if(handledata->_offset > tmpPacket->_the_whole_packet_size && tmpPacket->_the_whole_packet_size != 0)
			 *	这个判断的意思是，收到的数据是几个消息包的集合，需要拆分处理，那么可能正好是3个包的集合，也可能是3个半的消息包的集合，这样，剩下的1/2
			 *	数据包的处理将会走到这个if里，这时，并不能保证handledata->_buffer指针，还指在handledata->_buffer的头部，或许已经移动到了中部，
			 *	尾部等，基于这个原因，所以再次申请一个数据句柄，用于投递接收剩下的数据。
			 *
			 *	看了以上的话，那为什么不定义一个临时指针？这里可以不用重新申请数据句柄吗？
			 *	答：就算定义一个临时指针，那么在【3个半的消息包的集合，这样，剩下的1/2数据包的处理将会走到这个if里】这种情况下，还要把剩下的数据移动到
			 *	handledata->_buffer头部，然后再去投递接收剩下的数据，这样的一个操作过程不比重新申请一个数据句柄简单
			 */
		FALG_4:
			mc_system_msg::PPerHandleData tmp_perHandledata = GetData(handledata->_socket);

			if(tmp_perHandledata == NULL){
				return false;
			}
			else{
				memcpy((tmp_perHandledata->_buffer), (handledata->_buffer), handledata->_offset);
				tmp_perHandledata->_offset = handledata->_offset;
				PostReceive(tmp_perHandledata);
			}

			//这里不需要投递接收消息
			return false;
		}
		/*[3]*/else if(handledata->_offset > tmpPacket->_the_whole_packet_size && tmpPacket->_the_whole_packet_size != 0){
			DoData(handledata, tmpPacket->_the_whole_packet_size);
			//_msg_queue->Add(handledata);

			char* tmpMovePtr	=  handledata->_buffer + tmpPacket->_the_whole_packet_size;
			handledata->_buffer =  tmpMovePtr;
			bytes_transferred	-= tmpPacket->_the_whole_packet_size;
			handledata->_offset -= tmpPacket->_the_whole_packet_size;
			
			continue;
		}
		/*[4]*/else{
			//出现这种情况呢，一般来说，正常的情况下是收到的消息/或者可能是拆包后剩下的消息长度达不到包头的长度，导致消息解析失败
			//跳转到[2]再次去读取消息
			goto FALG_4;
		}
	} while (true);
	
	assert(false);
	throw std::exception("bool ReceiveManager::Receive(...)error");
	return false;
}

