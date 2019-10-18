local LoginScene = class("LoginScene", global.fsm.State)

LoginScene.NAME = "LoginScene"

function LoginScene:ctor( )
    LoginScene.super.ctor(self)
    print("LoginScene:ctor")
end

function LoginScene:onEnter( )
    if self.scene == nil then 
        self.scene = display.newScene("LoginScene")
    end
    cc.Director:getInstance():replaceScene(self.scene)
end

function LoginScene:onEnterFisih( )
    global.facade:sendNotification("open")
end

function LoginScene:onExit( )
    print("LoginScene:onExit")
end

function LoginScene:tick( )
    print("LoginScene:tick")
end

return LoginScene