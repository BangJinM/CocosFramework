#pragma once
class StreamBase
{
public:
	enum STREAMMODE {
		IN = 1,		//������
		OUT = 2		//�����
	};
	enum SEEKDIR {
		BEGIN = 0,
		CURRENT,
		END
	};
protected:
	char*	pbase;		//��������ͷָ��
	char*	pcurr;		//�������еĵ�ǰָ��
	char*	pend;		//��������βָ��
	int		m_mode;		//������ģʽ in or out
	bool	m_bigendian;// 
public:

	StreamBase(bool bigendian) :pbase(0), pcurr(0), pend(0), m_mode(0), m_bigendian(bigendian)
	{
	}

	StreamBase(char* pch, long nLength, int mode, bool bigendian) :pbase(pch), pcurr(pch), m_mode(mode), m_bigendian(bigendian)
	{
		pend = pch + nLength;
	}
	~StreamBase() {}

	//����������һ��������
	//pch �������Ŀ�ʼ��ַ
	//nLength: �������Ĵ�С
	void attach(char* pch, long nLength) {
		pbase = pcurr = pch;
		pend = pbase + nLength;
	}

	//�����뻺��������
	void detach() { pbase = pcurr = pend = 0; }

	//�õ�������ʣ����õĳ���
	//seek����ͬ��λ�û�Ӱ��ú������
	long avail() const { return (long)(pend - pcurr); }

	//�õ���������ʹ�õĳ���
	//seek����ͬ��λ�û�Ӱ��ú������
	long length() const { return (long)(pcurr - pbase); }
};