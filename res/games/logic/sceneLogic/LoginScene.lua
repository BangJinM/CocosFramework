local Scene = require("games.logic.sceneLogic.Scene")
local LoginScene = class("LoginScene",Scene )

LoginScene.NAME = "LoginScene"

function LoginScene:ctor( )
    LoginScene.super.ctor(self)
    print("LoginScene:ctor")
end

function LoginScene:onEnter( )
    global.facade:sendNotification(global.NotificationType.Login_Open)
end

function LoginScene:tick( )
    print("LoginScene:tick")
end

return LoginScene