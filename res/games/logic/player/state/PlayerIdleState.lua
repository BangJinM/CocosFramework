local PlayerIdleState = class("PlayerIdleState", global.fsm.State)

local IdleToMoveCondition = require("games.logic.player.condition.IdleToMoveCondition")

PlayerIdleState.NAME = "PlayerIdleState"

function PlayerIdleState:ctor( )
    PlayerIdleState.super.ctor(self)
    self:init()
end

function PlayerIdleState:init( )
    self:addCondition(IdleToMoveCondition.new())
end

function PlayerIdleState:onEnter( )
    PlayerIdleState.super.onEnter(self)
    print("PlayerIdleState" .. "onEnter")
end

function PlayerIdleState:onExit( )
    print("PlayerIdleState" .. "onExit")
end

function PlayerIdleState:tick( )
    print("PlayerIdleState" .. "tick")
end

return PlayerIdleState