local StartUpCommand = class('StartUpCommand', framework.MacroCommand)

function StartUpCommand:ctor()
    StartUpCommand.super.ctor(self)
end

function StartUpCommand:initializeMacroCommand() 
    require("games.config.config")
end

function StartUpCommand:execute(notification)
    release_print("StartUpCommand!")
    for k,v in ipairs(config.meditor) do
        
    end
end

return StartUpCommand
