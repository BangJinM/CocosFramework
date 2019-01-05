framework = framework or {}
local tempmt = getmetatable(framework)

local mt = {
    __index = function(framework, key)
        if key == "ViewBase" then 
            framework.ViewBase = require("framework.ViewBase")
            return framework.ViewBase
        else
            if tempmt ~= nil then
                return tempmt.__index(framework, key)
            end
        end
    end
}

setmetatable(framework, mt)