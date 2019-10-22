local Scene = require("games.logic.sceneLogic.Scene")
local GameScene = class("GameScene", Scene)

GameScene.NAME = "GameScene"

function GameScene:ctor( )
    GameScene.super.ctor(self)
    print("GameScene:ctor")
end


function GameScene:tick( )
    print("GameScene:tick")
end


return GameScene