local registerProxy = class('registerProxy', framework.SimpleCommand)

function registerProxy:ctor() 
    registerProxy.super.ctor(self)
    require("games.config.proxyConfig")
end

function registerProxy:execute(notification)
    local proxyTable = {

    }
    
    local callback = function (key)
        local proxy = require(key).new()
        global.facade:registerProxy( proxy)
    end

    for k, v in ipairs(proxyTable) do
        local param = v
        global.Task:addLoadingTask(param,callback)
    end

    global.Task:timerBegan()
end

return registerProxy
