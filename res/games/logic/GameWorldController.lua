local GameWorldController = class("GameWorldController")

local GameSceneController = require("games.logic.sceneLogic.GameSceneController")
local PlayerController = require("games.logic.player.PlayerController")

function GameWorldController:ctor( )
    self.playerController = PlayerController.new()
    self.gameSceneController = GameSceneController.new()

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.tick), 0, false)

    self:onEnter()
end

function GameWorldController:onEnter( )
    self.playerController:onEnter()
    self.gameSceneController:onEnter()

    self.gameSceneController:transition("LoginScene")
end

local i = 1
local t = 0 
function GameWorldController:tick( )
    self.playerController:tick()
    self.gameSceneController:tick()
    i = i + 1
    print(i)
    if i == 500 then 
        self.gameSceneController:transition("GameScene")
    elseif i == 1200 then 
        self.gameSceneController:transition("LoginScene")
    end 
end

function GameWorldController:onExit( )
    self.playerController:onExit()
    self.gameSceneController:onExit()
end

return GameWorldController