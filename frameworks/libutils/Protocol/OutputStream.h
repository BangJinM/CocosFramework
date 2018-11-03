#pragma once
#include "StreamBase.h"
class OutputStream: public StreamBase
{
public:
	STREAMMODE mode;
	OutputStream();
	~OutputStream();

private:

};