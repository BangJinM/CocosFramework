local loginMediator = class("loginMediator",framework.Mediator)

loginMediator.NAME = "loginMediator"



function loginMediator:ctor( )
    loginMediator.super.ctor(self)
end

function loginMediator:listNotificationInterests()
	return {
        "open"
    }
end

function loginMediator:handleNotification( notification )
    if notification.name == "open" then 
        local s = display.newScene("NewScene")
        s:addChild(framework.UIManager.createCsd("views.login.login"))
        display.runScene(s)

        local MainGamePadLayout = require("games.start.layer.GameRockerLayer").create()
        s:addChild(MainGamePadLayout)
        local test = require("games.start.mediator.test")
        local callback = test["testIndex"]
        callback(test,1000)
    end
end

return loginMediator