framework = framework or {}
local tempmt = getmetatable(framework)

local mt = {
    __index = function(framework, key)
        if key == "DeviceData" then 
            framework.DeviceData = require("framework.data.DeviceData")
            return framework.DeviceData
        else
            if tempmt ~= nil then
                return tempmt.__index(framework, key)
            end
        end
    end
}

setmetatable(framework, mt)