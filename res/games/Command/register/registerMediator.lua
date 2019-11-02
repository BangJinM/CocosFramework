local registerMediator = class('registerMediator', framework.SimpleCommand)

function registerMediator:ctor() 
    registerMediator.super.ctor(self)
    require("games.config.mediatorConfig")
end

function registerMediator:execute(notification)
    local mediatorTable = {
        "games.mediator.loginMediator",
    }

    local callback = function (key)
        local meditor = require(key).new()
        global.facade:registerMediator( meditor)
    end


    for k, v in ipairs(mediatorTable) do

        local param = v
        global.Task:addLoadingTask(param,callback)
    end

    global.Task:timerBegan()
end

return registerMediator
