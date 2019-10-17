local PlayerController = class("PlayerController")

function PlayerController:ctor(  )
    self.states = {}
    self.curState = nil
    self.preState = nil
    self.stateNew = false
end

function PlayerController:addState( state )
    if not state then return end
    self.states[state:getName()] = state
end

function PlayerController:removeState( state )
    if not state then return end
    self.states[state:getName()] = nil
end

function PlayerController:transition( nextState )
    if not self.curState then 
        self.stateNew = true
        self.curState = self.states[nextState]
        return true
    end
    if self.curState:getName() == nextState then
        return false
    end 
    if self.curState:transition(self.states[nextState]) then 
        self.stateNew = true
        self.preState = self.curState
        self.curState = self.states[nextState]
        return true
    end
    return false
end

function PlayerController:update( )
    if self.preState then
        self.preState:onExit()
        self.preState = nil
    end
    if self.stateNew then 
        self.curState:onEnter()
        self.stateNew = false
    end
    self.curState:update()
end

return PlayerController