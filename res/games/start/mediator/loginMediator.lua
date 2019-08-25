local loginMediator = class("loginMediator",framework.Mediator)

loginMediator.NAME = "loginMediator"

function loginMediator:ctor( )
    loginMediator.super.ctor(self,self.NAME)
end

function loginMediator:listNotificationInterests()
	return {
        "login"
    }
end

function loginMediator:handleNotification( notification )
    if notification == "login" then 
        cclog("login")
    end
end

return loginMediator