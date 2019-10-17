-- FSM 状态机 
-- Condition 是每个状态转换的条件
-- State 是状态
-- Event 是在StateA 转到StateB 过程中执行的事件

local fsm = fsm or {}

fsm.Condition = require("framework.fsm.Condition")
fsm.Controller = require("framework.fsm.Controller")
fsm.State = require("framework.fsm.State")
fsm.Event = require("framework.fsm.Event")

return fsm