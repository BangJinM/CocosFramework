local GameData = {}

GameData.GameID = {
    ["Tetris"] = 1,
}
GameData.Tetris={
    GameScenePath = "games.tetris.GameScene"
}

GameData.GameType = {
    [GameData.GameID["Tetris"]] = GameData.Tetris,
}


return GameData