local registerCommand = class('registerCommand', framework.SimpleCommand)

function registerCommand:ctor() 
    registerCommand.super.ctor(self)
    
end

function registerCommand:register( )

    local commandTable = {
        [global.CommandType.GrayShaderCommand] = "games.Command.GrayShaderCommand",
        [global.CommandType.EndGameCommand] = "games.Command.EndGameCommand",
        [global.CommandType.RestartGameCommand] = "games.Command.RestartGameCommand",
    }

    local callback = function (param)
        local command = require(param.key)
        self:getFacade():registerCommand( param.key, param.command)
    end

    for k, v in pairs(commandTable) do
        local param = {}
        param.key = k
        param.command = v
        global.Task:addLoadingTask(param,callback)
    end
    global.Task:timerBegan()
end

function registerCommand:execute(notification)
    self:register(0)
end

return registerCommand
