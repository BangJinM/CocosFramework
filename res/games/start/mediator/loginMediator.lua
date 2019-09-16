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

        local RichTextCreator = require("utils.RichTextCreator")
        local str = string.format( "每次<u>兑换</u>扣除%s点活力，获得%s经验。", 
            string.format( "<font size='20'>%s</font>", 1),
            string.format( "<font color='#%s' url='www.baidu.com'><br>%s<br></font>", "#f40000", 10000) 
        )
        local rich = RichTextCreator:_CreateRichTextWithAnything(str)
        rich:setPosition(cc.p(480, 320))
        s:addChild(rich)
        -- local test = require("games.start.mediator.test")
        -- local callback = test["testIndex"]
        -- callback(test,1000)
    end
end

return loginMediator