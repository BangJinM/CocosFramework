local MainScene =
    class(
    "MainScene",
    function()
        return display.newScene("MainScene")
    end
)

function MainScene:ctor()
    -- local image = ccui.ImageView:create("helloWorld.png",ccui.TextureResType.localType)
    local tmpButton = ccui.Button:create("helloWorld.png", "helloWorld.png", "helloWorld.png", ccui.TextureResType.localType)
    self:addChild(tmpButton)
    tmpButton:setPosition(cc.p(640,360))
    tmpButton:setName("helloWorld.png")
    -- tmpButton:setTouchEnable(true)
    tmpButton:addTouchEventListener(handler(self,self.onClickEvent))
end

function MainScene:onClickEvent(send,type)
    if(type==ccui.TouchEventType.began)then
        send:setScale(0.9)
        print("begin") 
    elseif(type==ccui.TouchEventType.moved)then 
        print("moved") 
    elseif(type==ccui.TouchEventType.ended)then
        send:setScale(1)
        print("ended") 
    else
        print("cancel") 
    end
    if type ~= ccui.TouchEventType.ended then
        return
    end
    local name =send:getName()
    if name=="helloWorld.png" then 
        local gameInterface = require("games.gameCommon.GameInterface")
        gameInterface:startGame(1)
    end
end

function MainScene:onEnter()

    print("onEnter")
end

function MainScene:onExit()
    print("onExit")
end

return MainScene
