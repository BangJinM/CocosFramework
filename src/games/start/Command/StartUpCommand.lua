local StartUpCommand = class('StartUpCommand', framework.SimpleCommand)

function StartUpCommand:ctor()

end

function StartUpCommand:execute(notification)
    release_print("StartUpCommand!")
end

return StartUpCommand
