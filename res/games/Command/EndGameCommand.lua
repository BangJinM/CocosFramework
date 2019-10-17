local EndGameCommand = class('EndGameCommand', framework.SimpleCommand)

function EndGameCommand:ctor()

end

function EndGameCommand:execute(note)
    cc.Director:getInstance():endToLua()
    os.exit()
end

return EndGameCommand
