
globel = globel or {}

globel.PROJECT_PATH = ""
globel.FRAMEWORK_PATH           = globel.PROJECT_PATH .. "framework."
globel.FRAMEWORK_PUREMVC_PATH   = globel.FRAMEWORK_PATH .. "puremvc."

require("init.game_platform")
require(globel.FRAMEWORK_PATH .. "initFramework")

