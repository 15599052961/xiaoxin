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
	//���������@class Acceptor, @class Connector�����ά��
	//_socket_manager = NULL;
	SAFE_DELETE(_msg_queue);
}

void ReceiveManager::AsynReceive( mc_system_msg::PPerHandleData handledata, const boost::system::error_code& error, std::size_t bytes_transferred )
{
	//�ڲ����ʱ��������������õģ���Ϊ�����Ҫ�ƶ�handledata->_bufferָ�룬ʹ֮����ָ����һ����
	//��������Ϻ���Ҫ��handledata->_buffer������ָ�뻹ԭ�������ͷŻ�����ʱ��������
	char* tmpPtr = handledata->_buffer;

	//�����ܹ��յ�����Ϣ�ĳ��ȣ�����Ҫ��+=��������=
	handledata->_offset += bytes_transferred;

	if(Receive(handledata, bytes_transferred))
	{
		//Ͷ�ݽ��ղ���
		PostReceive(handledata->Socket());
	}

	//��ֹhandledata->_bufferָ����Receive�б��ı�,��ԭָ��ֵ��ϣ��ָ�뱻��ȷ���ͷ�
	handledata->_buffer = tmpPtr;
	ReleaseMemory(handledata);
}

/// <summary>
/// �˹�����Ҫ����TCP��Ϣ�Ĳ����ճ�����̣��Ѵ�����������Ϣ���뵽��Ϣ����
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
			//��Ϣ��ȫ����ת��[2]������ȡ��Ϣ
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
			 *	����ִ�е����˵�����յ������ݲ���һ�������İ�����Ҫ�ٴν���ʣ�µ����ݣ����������һ�����ʣ�Ϊʲô���»�ȡ���ݾ����
			 *	ԭ����������һ���ж�[3]��
			 *	else if(handledata->_offset > tmpPacket->_the_whole_packet_size && tmpPacket->_the_whole_packet_size != 0)
			 *	����жϵ���˼�ǣ��յ��������Ǽ�����Ϣ���ļ��ϣ���Ҫ��ִ�����ô����������3�����ļ��ϣ�Ҳ������3�������Ϣ���ļ��ϣ�������ʣ�µ�1/2
			 *	���ݰ��Ĵ������ߵ����if���ʱ�������ܱ�֤handledata->_bufferָ�룬��ָ��handledata->_buffer��ͷ���������Ѿ��ƶ������в���
			 *	β���ȣ��������ԭ�������ٴ�����һ�����ݾ��������Ͷ�ݽ���ʣ�µ����ݡ�
			 *
			 *	�������ϵĻ�����Ϊʲô������һ����ʱָ�룿������Բ��������������ݾ����
			 *	�𣺾��㶨��һ����ʱָ�룬��ô�ڡ�3�������Ϣ���ļ��ϣ�������ʣ�µ�1/2���ݰ��Ĵ������ߵ����if���������£���Ҫ��ʣ�µ������ƶ���
			 *	handledata->_bufferͷ����Ȼ����ȥͶ�ݽ���ʣ�µ����ݣ�������һ���������̲�����������һ�����ݾ����
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

			//���ﲻ��ҪͶ�ݽ�����Ϣ
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
			//������������أ�һ����˵����������������յ�����Ϣ/���߿����ǲ����ʣ�µ���Ϣ���ȴﲻ����ͷ�ĳ��ȣ�������Ϣ����ʧ��
			//��ת��[2]�ٴ�ȥ��ȡ��Ϣ
			goto FALG_4;
		}
	} while (true);
	
	assert(false);
	throw std::exception("bool ReceiveManager::Receive(...)error");
	return false;
}

