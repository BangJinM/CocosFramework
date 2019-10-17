
cc.FileUtils:getInstance():setPopupNotify(false)
local breakSocketHandle,debugXpCall = require("LuaDebugjit")("localhost",7003)
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakSocketHandle, 0.3, false)
require("config")
require "cocos.init"

cclog = function(...)
    print(string.format(...))
end

function __G__TRACKBACK__(msg)
    cclog("---------------------------------------------------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("---------------------------------------------------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    require "init.init"

    local StartUpCommand = require("games.Command.StartUpCommand")
    global.facade:registerCommand("StartUp", StartUpCommand)
    global.facade:sendNotification("StartUp")

    print("----------------------------------------------------------")
    print("-----------------StartUpCommandExecute!-------------------")
    print("----------------------------------------------------------")
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
