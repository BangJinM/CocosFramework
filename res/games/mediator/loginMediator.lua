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
        local s = display.getRunningScene()
        require("games.utils.UIManager")
        local _root = framework.UIManager.createCsd("games.views.csb.login.login")
        s:addChild(_root)
        display.runScene(s)

        local MainGamePadLayout = require("games.views..layer.GameRockerLayer").create()
        s:addChild(MainGamePadLayout)

        local RichTextCreator = require("games.utils.RichTextCreator")
        local str = string.format( "每次兑换扣除%s点活力,获得%s经验。", 
            string.format( "<font size='20' fontPath='fonts/font.ttf'>%s</font>", 1),
            string.format( "<font color='#%s' type='button' id='1' fontPath='fonts/font.ttf'>%s</font>", "FF7F00", "10000" )
        )
        -- local rich = RichTextCreator:CreateRichTextWithXML(str,nil,nil,nil,function( type )
        --     print("ddddddddddddddddddddddddddddd")
        -- end)

        -- rich:setPosition(cc.p(480, 320))
        -- s:addChild(rich)

        local data = { }
        data.node = _root:getChildByName("bg")
        global.facade:sendNotification("GrayShaderCommand", data)
        local UIManager = require("games.utils.utils").new()
        UIManager:_addTouchEventListener(data.node,function (  )
            print("1")
        end,function(  )
            print("...")
        end,function (  )
            print("3")
        end)
        local PlayerController = require("games.logic.player.playerController").new()
        PlayerController:transition("PlayerIdleState")
        PlayerController:tick()
        PlayerController:transition("PlayerMoveState")
        PlayerController:tick()
        PlayerController:transition("PlayerMoveState")
        PlayerController:tick()
        PlayerController:tick()
    end
end

return loginMediator