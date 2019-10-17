local State = class("State")

State.NAME = "State"

function State:ctor( )
    self.conditions = {}
    self.events = {}
end

function State:reset( )
    self.conditions = {}
end

function State:getName( )
    return self.NAME
end

function State:addCondition( condition )
    if not condition then 
        return
    end
    self.conditions[condition:getName()] = condition
end

function State:removeConditions( condition )
    if not condition then 
        return
    end
    self.conditions[condition:getName()] = nil
end

function State:transition( nextState )
    for k,v in pairs(self.conditions) do
        if v:checkTransition(self, nextState) then 
            return true
        end
    end
    return false
end

function State:addEvent( nextstate, event )
    if not nextstate or not event then
        return 
    end
    self.events[nextstate] = event
end

function State:removeEvent( nextstate)
    if not nextstate then return end
    self.events[nextstate] = nil
end

function State:onEnter( )
end

function State:onExit( )
    
end

function State:update( )
    
end

return State