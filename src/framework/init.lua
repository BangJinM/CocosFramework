globel = globel or {}

framework = framework or {}

framework.ApplicationName = "ApplicationName"

framework.Facade =         require( globel.FRAMEWORK_PATH .. '.patterns.facade.Facade')
framework.Mediator =       require( globel.FRAMEWORK_PATH .. '.patterns.mediator.Mediator')
framework.Proxy =          require( globel.FRAMEWORK_PATH .. '.patterns.proxy.Proxy')
framework.SimpleCommand =  require( globel.FRAMEWORK_PATH .. '.patterns.command.SimpleCommand')
framework.MacroCommand =   require( globel.FRAMEWORK_PATH .. '.patterns.command.MacroCommand')
framework.Notifier =       require( globel.FRAMEWORK_PATH .. '.patterns.observer.Notifier')
framework.Notification =   require( globel.FRAMEWORK_PATH .. '.patterns.observer.Notification')
