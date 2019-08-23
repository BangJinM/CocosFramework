#include "base/ccConfig.h"
#include "LuaBindingTest/CPP/LuaBindingTest.h"
#ifndef __RegisterLuaBindingTest__
#define __RegisterLuaBindingTest__

#ifdef __cplusplus
extern "C" {
#endif
#include "tolua++.h"
#ifdef __cplusplus
}
#endif

int register_all_test_cc(lua_State* tolua_S);


#endif // RegisterLuaBindingTest