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
        s:addChild(framework.UIManager.createCsd("views.lobby.Scene"))
        display.runScene(s)
    end
end

return loginMediator