
cc.FileUtils:getInstance():setPopupNotify(false)
local breakSocketHandle,debugXpCall = require("LuaDebugjit")("localhost",7003)
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakSocketHandle, 0.3, false)

--全局变量 只能在代码完全公用的情况下才会放入全局变量中，谨慎使用
framework = {}
lobby     = {}
games     = {}

require "config"
require "cocos.init"

-- print = release_print

local cclog = function(...)
    print(string.format(...))
end

function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    local bIsOnline = true
    if bIsOnline == true then
        local interface =require("Interface")
        interface.startScene(interface.SCENETYPE.LOBBYSCENE)
    end
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
