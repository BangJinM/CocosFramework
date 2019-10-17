require(global.FRAMEWORK_PUREMVC_PATH.."init")

global.facade = framework.Facade.getInstance(framework.ApplicationName)

global.fsm = require("framework.fsm.init")

print("----------------------------------------------------------")
print("--------------------初始化purelua成功!----------------------")
print("----------------------------------------------------------")