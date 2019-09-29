global = global or {}

framework = framework or {}

framework.ApplicationName = "ApplicationName"

framework.Facade =         require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.facade.Facade')
framework.Mediator =       require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.mediator.Mediator')
framework.Proxy =          require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.proxy.Proxy')
framework.SimpleCommand =  require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.command.SimpleCommand')
framework.MacroCommand =   require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.command.MacroCommand')
framework.Notifier =       require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.observer.Notifier')
framework.Notification =   require( global.FRAMEWORK_PUREMVC_PATH .. 'patterns.observer.Notification')
