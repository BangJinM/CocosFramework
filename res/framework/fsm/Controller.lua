local Controller = class("Controller")

function Controller:ctor(  )
    self.states = {}
    self.curState = nil
    self.preState = nil
    self.stateNew = false  -- 标记State是否是调用onEnter
end

function Controller:addState( state )
    if not state then return end
    self.states[state:getName()] = state
end

function Controller:removeState( state )
    if not state then return end
    self.states[state:getName()] = nil
end

-- 转换状态
function Controller:transition( nextState )
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

-- 更新
function Controller:tick( )
    if self.preState then
        self.preState:onExit()
        self.preState = nil
    end
    if self.stateNew then 
        self.curState:onEnter()
        self.stateNew = false
    end
    if self.curState == nil then return end
    self.curState:tick()
end

function Controller:onEnter(  )
    
end

function Controller:onExit(  )
    
end

return Controller