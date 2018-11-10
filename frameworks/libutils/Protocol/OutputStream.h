#pragma once
#include <string.h>
#include <algorithm>
#include "StreamBase.h"
namespace utils{
	class OutputStream: public StreamBase
	{
	public:
		STREAMMODE mode;
		OutputStream& write(const char* value,size_t offset){
			memcpy(pcurr, value, offset);
			pcurr += offset;
			return *this;
		}
		OutputStream(bool bigendian) :StreamBase(bigendian) {
			mode = OUT;
		}
		~OutputStream() {}

		inline OutputStream& operator<<(char value) {
			return write(&value, sizeof(value));
		}
		inline OutputStream& operator<<(unsigned char value) {
			//return write(&value, sizeof(value));
		}
		inline OutputStream& operator<<(signed char) {}
		inline OutputStream& operator<<(short) {}
		inline OutputStream& operator<<(unsigned short) {}
		inline OutputStream& operator<<(int) {}
		inline OutputStream& operator<<(unsigned int) {}
		inline OutputStream& operator<<(long) {}
		inline OutputStream& operator<<(unsigned long) {}
		inline OutputStream& operator<<(long long) {}
		inline OutputStream& operator<<(unsigned long long) {}
		inline OutputStream& operator<<(float) {}
		inline OutputStream& operator<<(double) {}
		inline OutputStream& operator<<(long double) {}
		inline OutputStream& operator<<(bool) {}
		inline OutputStream& operator<<(const char*) {}
		inline OutputStream& operator<<(char*) {}
		inline OutputStream& operator<<(unsigned char*) {}
		inline OutputStream& operator<<(const unsigned char*){}
	private:

	};
}