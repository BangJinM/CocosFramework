#include "RegisterLuaBindingTest.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"
#include "scripting/lua-bindings/manual/CCComponentLua.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"

int register_setNum1(lua_State * tolua_S){
	int argc = 0;
	bool ok = false;
	LuaBindingTest* test;
	test = (LuaBindingTest*)tolua_tousertype(tolua_S, 1, 0);
	argc = lua_gettop(tolua_S) - 1;
	if(argc == 1){
		int num1, num2;
		luaval_to_int32(tolua_S, 2, (int *)& num2, "fm.LuaBindingTest:setNum1");
		if (num2){
			test->num1 = num2;
			return 1;
		}
	}
	return 0;
}

int register_new(lua_State * tolua_S) {
	int argc = 0;
	bool ok = false;
	LuaBindingTest* test = new LuaBindingTest();
	argc = lua_gettop(tolua_S) - 1;
	if (argc == 0) {
		int num1, num2;
		ok &= luaval_to_int32(tolua_S, 1, (int *)& num2, "fm.LuaBindingTest.new");
		if (num2) {
			test->num1 = num2;
			tolua_pushusertype(tolua_S, (void*)test, "fm.LuaBindingTest");
			tolua_register_gc(tolua_S, lua_gettop(tolua_S));
			return 1;
		}
	}
	return 0;
}


int register_getNum1(lua_State * tolua_S) {
	int argc = 0;
	bool ok = false;
	LuaBindingTest* test;
	test = (LuaBindingTest*)tolua_tousertype(tolua_S, 1, 0);
	argc = lua_gettop(tolua_S) - 1;
	if (argc == 0 & test != nullptr) {
		lua_pushnumber(tolua_S, (lua_Number)test->num1);
		return 1;
	}
	return 0;
}

int register_all_test_cc(lua_State * tolua_S)
{
	tolua_open(tolua_S);
	tolua_module(tolua_S, "fm", 0);
	tolua_beginmodule(tolua_S, "fm");

	tolua_usertype(tolua_S, "fm.LuaBindingTest");
	tolua_cclass(tolua_S, "LuaBindingTest", "fm.LuaBindingTest", "", nullptr);
	tolua_beginmodule(tolua_S, "LuaBindingTest");
		tolua_function(tolua_S, "setNum1", register_setNum1);
		tolua_function(tolua_S, "getNum1", register_getNum1);
		tolua_function(tolua_S, "new", register_new);
	tolua_endmodule(tolua_S);
	tolua_endmodule(tolua_S);
	auto typeName = typeid(LuaBindingTest).name();
	g_luaType[typeName] = "fm.LuaBindingTest";
	g_typeCast["LuaBindingTest"] = "fm.LuaBindingTest";
	return 1;
}
