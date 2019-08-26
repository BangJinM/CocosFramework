local registerProxy = class('registerProxy', framework.SimpleCommand)

function registerProxy:ctor() 
    registerProxy.super.ctor(self)
    require("games.config.proxyConfig")
end

function registerProxy:execute(notification)
    for k, v in ipairs(globel.proxyTable) do
        
    end
end

return registerProxy
