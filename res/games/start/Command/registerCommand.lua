local registerCommand = class('registerCommand', framework.SimpleCommand)

function registerCommand:ctor() 
    registerCommand.super.ctor(self)
    
end

function registerCommand:execute(notification)
    require("games.config.commandConfig")
    for k, v in ipairs(globel.commandTable) do
        
    end
end

return registerCommand
