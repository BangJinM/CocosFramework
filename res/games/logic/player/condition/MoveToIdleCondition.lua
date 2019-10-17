local MoveToIdleCondition  = class("MoveToIdleCondition", global.fsm.Condition)

MoveToIdleCondition.NAME = "MoveToIdleCondition"

function MoveToIdleCondition:ctor( )
    MoveToIdleCondition.super.ctor(self)
end

function MoveToIdleCondition:checkTransition( curState, nextState )
    return true
end

return MoveToIdleCondition