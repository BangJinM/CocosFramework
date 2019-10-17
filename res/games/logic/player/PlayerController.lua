local PlayerController = class("PlayerController", global.fsm.Controller)

local PlayerIdleState = require("games.logic.player.state.playerIdleState")
local PlayerMoveState = require("games.logic.player.state.PlayerMoveState")


function PlayerController:ctor( )
    PlayerController.super.ctor(self)
    self:init()
end

function PlayerController:init( )
    self:addState(PlayerIdleState.new())
    self:addState(PlayerMoveState.new())
end


return PlayerController