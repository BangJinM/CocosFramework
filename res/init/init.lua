
global = global or {}

global.PROJECT_PATH = ""
global.FRAMEWORK_PATH           = global.PROJECT_PATH .. "framework."
global.FRAMEWORK_PUREMVC_PATH   = global.FRAMEWORK_PATH .. "puremvc."

require("init.game_platform")
require(global.FRAMEWORK_PATH .. "initFramework")

require("init.initWindowsUtils")

