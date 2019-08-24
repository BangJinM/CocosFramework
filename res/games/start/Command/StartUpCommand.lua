local StartUpCommand = class('StartUpCommand', framework.SimpleCommand)

function StartUpCommand:ctor()

end

function StartUpCommand:execute(notification)
    release_print("StartUpCommand!")
    local scene = require("views.lobby.Scene").create()
    local s = display.newScene("NewScene")
    s:addChild(scene["root"])
    display.runScene(s)
end

return StartUpCommand
