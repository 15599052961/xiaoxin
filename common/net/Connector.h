/*
 *	author:wl(oiooooio)
 *
 *	Connector:
 *	**	����ǿ��һ�´����ʹ�÷�Χ��������Ҫ�����ڵ����׽������ӷ������ģ�Ҳ�����ڴ��൱�У��Ὠ��һ��socketȥ���ӷ�������
 *		�����socket�Ͽ����ӣ����������������һ��socket�����ٴ����ӷ��������������������ͨ�š�(δ��)
 *
 *	**	Ŀǰ������Ҫ�������������ֱ�ӵĽ��������½��������Ҫ�����м������ȥ��ȡ�ӷ������б��ӷ������������м������ȥ
 *		��֪�м���������Լ���һ��ע�ᣬ�Ա��м������֪ͨ��½���������ӷ��������ߵȡ���Щ������ֻ��Ҫһ�����Ӽ��ɡ�
 *
 *	**	�����Ҫһ��Connector���кܶ�socketȥ���ӷ���������ô�ڲ��Կͻ��ˣ�TestSendTextMessage������һ��BigConne
 *		ctor�࣬�������һ��io_service�����ǿ��Դ����ܶ�socket���������ӷ�����������ָ�������߳�������
 */

#pragma once

#include "Acceptor_Connector_Base.h"

class Connector : public Acceptor_Connector_Base
{
public:
	Connector(const char* ip, unsigned int port);
	virtual ~Connector(void);

	virtual void* Initialize(ReceiveManager* recv_mng);
	virtual bool  Start();
	virtual bool  Stop();

private:
	bool ConnectServer();

	_pmy_socket CreateSocket();

	virtual void SocketCloseNotify(_pmy_socket socket, int EventID);

private:
	_pmy_socket _socket;
};

