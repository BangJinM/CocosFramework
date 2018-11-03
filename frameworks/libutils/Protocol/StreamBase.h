#pragma once
class StreamBase
{
public:
	enum STREAMMODE {
		IN = 1,		//输入流
		OUT = 2		//输出流
	};
	enum SEEKDIR {
		BEGIN = 0,
		CURRENT,
		END
	};
protected:
	char*	pbase;		//缓冲区的头指针
	char*	pcurr;		//缓冲区中的当前指针
	char*	pend;		//缓冲区的尾指针
	int		m_mode;		//该流的模式 in or out
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

	//将流关联到一个缓冲区
	//pch 缓冲区的开始地址
	//nLength: 缓冲区的大小
	void attach(char* pch, long nLength) {
		pbase = pcurr = pch;
		pend = pbase + nLength;
	}

	//将流与缓冲区脱离
	void detach() { pbase = pcurr = pend = 0; }

	//得到缓冲区剩余可用的长度
	//seek到不同的位置会影响该函数结果
	long avail() const { return (long)(pend - pcurr); }

	//得到缓冲区被使用的长度
	//seek到不同的位置会影响该函数结果
	long length() const { return (long)(pcurr - pbase); }
};