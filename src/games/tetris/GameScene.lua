local GameScene = class("GameScene",function(  )
    return display.newScene("GameScene")
end)

local resource = require("games.tetris.Resource")


function GameScene:ctor()
    local mainLayer =  cc.CSLoader:createNodeWithVisibleSize(resource.GameCSBPath)
    self:addChild(mainLayer)
    
end  

function GameScene:onEnter()

end

function GameScene:onExit()

end 

return GameScene