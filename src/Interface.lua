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
        require("app.MyApp"):create():run()
    end
end

return Interface