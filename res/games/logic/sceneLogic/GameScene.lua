local GameScene = class("GameScene", global.fsm.State)

GameScene.NAME = "GameScene"

function GameScene:ctor( )
    GameScene.super.ctor(self)
    print("GameScene:ctor")
end

function GameScene:onEnter( )
    print("GameScene:onEnter")
end

function GameScene:onExit( )
    print("GameScene:onExit")
end

function GameScene:tick( )
    print("GameScene:tick")
end

return GameScene