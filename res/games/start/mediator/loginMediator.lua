local loginMediator = class("loginMediator",framework.Mediator)

loginMediator.NAME = "loginMediator"

function loginMediator:ctor( )
    loginMediator.super.ctor(self)
end

function loginMediator:listNotificationInterests()
	return {
        "login"
    }
end

function loginMediator:handleNotification( notification )
    if notification.name == "login" then 
        cclog("login")
    end
end

return loginMediator