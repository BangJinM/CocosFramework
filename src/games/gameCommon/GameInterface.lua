local GameInterface =class("GameInterface")
local gameData = require("games.gameCommon.GameData")
function GameInterface:ctor(  )
    -- body
end

function GameInterface:startGame(gameID)
    local gameSenePath = gameData.GameType[gameID].GameScenePath
    print(gameSenePath)
    if(gameSenePath)then 
        local gameScene = require(gameSenePath).new()
        display.runScene(gameScene)
    end 
end

return GameInterface