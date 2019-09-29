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
        local _root = framework.UIManager.createCsd("views.login.login")
        s:addChild(_root)
        display.runScene(s)

        local MainGamePadLayout = require("games.start.layer.GameRockerLayer").create()
        s:addChild(MainGamePadLayout)

        local RichTextCreator = require("utils.RichTextCreator")
        local str = string.format( "每次兑换扣除%s点活力,获得%s经验。", 
            string.format( "<font size='20' fontPath='fonts/font.ttf'>%s</font>", 1),
            string.format( "<font color='#%s' type='button' id='1' fontPath='fonts/font.ttf'>%s</font>", "FF7F00", "10000" )
        )
        local rich = RichTextCreator:CreateRichTextWithXML(str,nil,nil,nil,function( type )
            print("ddddddddddddddddddddddddddddd")
        end)

        rich:setPosition(cc.p(480, 320))
        s:addChild(rich)

        local data = { }
        data.node = _root:getChildByName("bg")
        global.facade:sendNotification("GrayShaderCommand", data)
        -- local test = require("games.start.mediator.test")
        -- local callback = test["testIndex"]
        -- callback(test,1000)
    end
end

return loginMediator