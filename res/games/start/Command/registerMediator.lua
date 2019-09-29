local registerMediator = class('registerMediator', framework.SimpleCommand)

function registerMediator:ctor() 
    registerMediator.super.ctor(self)
    require("games.config.mediatorConfig")
end

function registerMediator:execute(notification)
    for k, v in ipairs(global.meditorTable) do
        local Mediator = require(v)
        local mediatorInst = Mediator.new()
        global.facade:registerMediator(mediatorInst)
    end
end

return registerMediator
