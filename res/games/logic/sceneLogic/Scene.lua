local Scene = class("Scene", global.fsm.State)

Scene.NAME = "Scene"

function Scene:ctor( )
    Scene.super.ctor(self)
    print("Scene:ctor")
end

function Scene:onEnterState( )
    if self.scene == nil then 
        self.scene = display.newScene(self.NAME)
        self.scene:registerScriptHandler(handler(self,self.sceneEvent))
    end
    cc.Director:getInstance():replaceScene(self.scene)
end

function Scene:tick( )
    print("Scene:tick")
end


function Scene.sceneEvent(self,event)
    if event == "enter" and self.onEnter ~= nil then
        self:onEnter()
    elseif event == "exit" and self.onExit ~= nil then
        self:onExit()
    elseif event == "enterTransitionFinish" and self.onEnterTransitionDidFinish ~= nil  then
        self:onEnterTransitionDidFinish()
    elseif event == "exitTransitionStart" and self.onExitTransitionDidStart ~= nil then
        self:onExitTransitionDidStart()
    elseif event == "cleanup" and self.onCleanup ~= nil then
        self:onCleanup()
    end
end


return Scene