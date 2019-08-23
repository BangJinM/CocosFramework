globel = globel or {}

framework.ApplicationName = "ApplicationName"

framework.Facade =         import( globel.FRAMEWORK_PATH .. '.patterns.facade.Facade')
framework.Mediator =       import( globel.FRAMEWORK_PATH .. '.patterns.mediator.Mediator')
framework.Proxy =          import( globel.FRAMEWORK_PATH .. '.patterns.proxy.Proxy')
framework.SimpleCommand =  import( globel.FRAMEWORK_PATH .. '.patterns.command.SimpleCommand')
framework.MacroCommand =   import( globel.FRAMEWORK_PATH .. '.patterns.command.MacroCommand')
framework.Notifier =       import( globel.FRAMEWORK_PATH .. '.patterns.observer.Notifier')
framework.Notification =   import( globel.FRAMEWORK_PATH .. '.patterns.observer.Notification')

globel.facade = framework.Facade.getInstance(framework.ApplicationName);

print("")
print("初始化purelua成功!")
print("")
