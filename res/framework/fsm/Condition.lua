local Conditions  = class("Conditions")

Conditions.NAME = "Conditions"

function Conditions:ctor( )
    
end

function Conditions:getName( )
    return self.NAME
end

function Conditions:checkTransition( curState, nextState )
    return true
end

return Conditions