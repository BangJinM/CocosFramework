local ViewBase = class("ViewBase",function() return display.newNode() end)

function ViewBase:ctor(  )
    local scene = cc.Director:getInstance():getRunningScene()
    scene:addChild(self)
    local image = ccui.ImageView:create("helloWorld.png",ccui.TextureResType.localType)
    self:addChild(image)
    self:setVisible(false)
end

function ViewBase:show()
    self:setVisible(true)
end

function ViewBase:hide()
    self:setVisible(false)
    self:removeFromParent()
end

return ViewBase