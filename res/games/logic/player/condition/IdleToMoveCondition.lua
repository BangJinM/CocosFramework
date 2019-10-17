local IdleToMoveCondition  = class("IdleToMoveCondition", global.fsm.Condition)

IdleToMoveCondition.NAME = "IdleToMoveCondition"

function IdleToMoveCondition:ctor( )
    IdleToMoveCondition.super.ctor(self)
end

function IdleToMoveCondition:checkTransition( curState, nextState )
    return true
end

return IdleToMoveCondition