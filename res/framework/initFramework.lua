require(global.FRAMEWORK_PUREMVC_PATH.."init")

require(global.FRAMEWORK_PATH.."UIManager")

global.facade = framework.Facade.getInstance(framework.ApplicationName)

print("----------------------------------------------------------")
print("--------------------初始化purelua成功!----------------------")
print("----------------------------------------------------------")