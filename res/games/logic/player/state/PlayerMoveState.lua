local PlayerMoveState = class("PlayerMoveState", global.fsm.State)

local MoveToIdleCondition = require("games.logic.player.condition.MoveToIdleCondition")

PlayerMoveState.NAME = "PlayerMoveState"

function PlayerMoveState:ctor( )
    PlayerMoveState.super.ctor(self)
    self:init()
end

function PlayerMoveState:init( )
    self:addCondition(MoveToIdleCondition.new())
end

function PlayerMoveState:onEnter( )
    print("PlayerMoveState" .. "onEnter")
end

function PlayerMoveState:onExit( )
    print("PlayerMoveState" .. "onExit")
end

function PlayerMoveState:update( )
    print("PlayerMoveState" .. "update")
end

return PlayerMoveState