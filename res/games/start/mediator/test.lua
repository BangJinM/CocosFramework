local test = class("test")

function test:testIndex( index )
    local task = require("utils.Task").new()
    local function InitCallback(param)
        print("utils.Task"..param)
    end
    for i=1,index do
        task:addLoadingTask(i, InitCallback)
    end
    task:timerBegan();
end

return test