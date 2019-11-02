local StartUpCommand = class('StartUpCommand', framework.MacroCommand)

function StartUpCommand:ctor() 
    StartUpCommand.super.ctor(self)
end

function StartUpCommand:initializeMacroCommand()
    cclog("StartUpCommand initializeMacroCommand!")

    local command = require("games.Command.register.registerCommand")
    local mediator = require("games.Command.register.registerMediator")
    local proxy = require("games.Command.register.registerProxy")

    self:addSubCommand(command)
    self:addSubCommand(proxy)
    self:addSubCommand(mediator)

    cclog("dddddddddddddddddddddddddddddddddddddddddddddddd")
end

function StartUpCommand:execute( note )
    cclog("StartUpCommand execute!")
    StartUpCommand.super.execute(self, note)
    cclog("StartUpCommand execute Exit!")

    cclog("StartUpCommand sendNotification to LoginMediator!")

    local gameWorldController = require("games.logic.GameWorldController")
    gameWorldController.new()
    -- global.facade:sendNotification("open")
end

return StartUpCommand
