local GameSceneController = class("GameSceneController", global.fsm.Controller)

local LoginScene = require("games.logic.sceneLogic.LoginScene")
local GameScene = require("games.logic.sceneLogic.GameScene")

function GameSceneController:ctor( )
    GameSceneController.super.ctor(self)
    self.onEnterStart = false
    self:addState(LoginScene.new())
    self:addState(GameScene.new())
end

function GameSceneController:onEnter( )
    
end

function GameSceneController:onExit( )
    
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
    self.preState = self.curState
    self.curState = self.states[nextScene]
    return true
end

-- 更新
function GameSceneController:tick( )
    if self.preState then
        self.preState:onExit()
        self.preState = nil
    end
    if self.stateNew then 
        self.curState:onEnter()
        self.stateNew = false
        self.onEnterStart = true
        return
    elseif self.onEnterStart then 
        if self.curState.onEnterFisih then 
            self.curState:onEnterFisih()
        end
        self.onEnterStart = false
    end
    if self.curState == nil then return end
    self.curState:tick()
end

return GameSceneController