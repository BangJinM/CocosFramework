require(globel.FRAMEWORK_PATH.."init")

globel.facade = framework.Facade.getInstance(framework.ApplicationName)

print("----------------------------------------------------------")
print("--------------------初始化purelua成功!----------------------")
print("----------------------------------------------------------")

local StartUpCommand = require("games.start.Command.StartUpCommand")
globel.facade:registerCommand("StartUp", StartUpCommand)
globel.facade:sendNotification("StartUp")


print("----------------------------------------------------------")
print("-----------------StartUpCommandExecute!-------------------")
print("----------------------------------------------------------")