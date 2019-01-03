local Interface = class("Interface")

require("framework.FrameworkInit")

Interface.SCENETYPE = {
    LOBBYSCENE = 1,
}

function Interface:reLoadCommonMode()
    package.loaded["games.init"] = nil
    require("games.init")
end

function Interface.startScene(SceneType , data)
    -- Interface.reLoadCommonMode()
    if(SceneType == Interface.SCENETYPE.LOBBYSCENE)then 
        local mainScene = require("MainScene").new()
        display.runScene(mainScene)
    end
    local test = fm.LuaBindingTest.new(1)
    local num1 = test:getNum1()
    test:setNum1(2)
    local nu2 = test:getNum1()
end

return Interface