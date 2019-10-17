-- DEBUG. reload some lua, for fast edit ui

global.Platform =  CCApplication:getInstance():getTargetPlatform()

if global.Platform == cc.PLATFORM_OS_WINDOWS then
    local function callback(keycode, evt)
        if keycode == cc.KeyCode.KEY_F5 then

        elseif keycode == cc.KeyCode.KEY_F1 then
            -- F1 restart game
            global.facade:sendNotification("EndGameCommand")

        elseif keycode == cc.KeyCode.KEY_F2 then

        elseif keycode == cc.KeyCode.KEY_0 then

        elseif keycode == cc.KeyCode.KEY_F9 then

        elseif keycode == cc.KeyCode.KEY_F11 then

        elseif keycode == cc.KeyCode.KEY_F12 then
  
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    listener:registerScriptHandler(callback, cc.Handler.EVENT_KEYBOARD_RELEASED)
    eventDispatcher:addEventListenerWithFixedPriority(listener, 1)
end