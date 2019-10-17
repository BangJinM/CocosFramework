local Task = class("Task")
local Queue = require("utils.Queue")
local Schedule = cc.Director:getInstance():getScheduler()

function Task:ctor()
    self._timerID = nil
    self._taskQueue = Queue.new()
    self.time = 0.01
end

function Task:addLoadingTask(param, Callback)
    local task = {}
    task.param = param
    task.callback = Callback
    self._taskQueue:push(task)
end

function Task:tick()
    local task = self._taskQueue:front()
    if task and task.callback then
        task.callback(task.param)
        self._taskQueue:pop()
    end
    if self._taskQueue:empty() then
        self:finish()
    end
end

function Task:timerBegan(time)
    if not self._timerID then
        self._timerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.tick), time or 0.01, false)
    end
end

function Task:timerEnded()
    if self._timerID then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timerID)
        self._timerID = nil
        self._taskQueue:clear()
    end
end

function Task:finish()
    self:timerEnded()
    print("Task:finish()")
end

return Task
