local registerCommand = class('registerCommand', framework.SimpleCommand)

function registerCommand:ctor() 
    registerCommand.super.ctor(self)
    
end

function registerCommand:execute(notification)
    require("games.config.commandConfig")
    for k, v in pairs(global.commandTable) do
        local command = require(v)
        self:getFacade():registerCommand( k, command)
    end
end

return registerCommand
