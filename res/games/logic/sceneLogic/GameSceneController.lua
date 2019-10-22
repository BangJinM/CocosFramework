local GameSceneController = class("GameSceneController", global.fsm.Controller)

local LoginScene = require("games.logic.sceneLogic.LoginScene")
local GameScene = require("games.logic.sceneLogic.GameScene")

function GameSceneController:ctor( )
    GameSceneController.super.ctor(self)
    self.onEnterStart = false
    self:addState(LoginScene.new())
    self:addState(GameScene.new())
end

function GameSceneController:transition( nextScene )
    if not self.curState then 
        self.stateNew = true
        self.curState = self.states[nextScene]
        return true
    end
    if self.curState:getName() == nextScene then
        return false
    end 
    self.stateNew = true
    self.curState = self.states[nextScene]
    return true
end

-- 更新
function GameSceneController:tick( )
    if self.stateNew then 
        self.curState:onEnterState()
        self.stateNew = false
        return
    end
    if self.curState == nil then return end
    self.curState:tick()
end

return GameSceneController