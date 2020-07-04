local loginMediator = class("loginMediator",framework.Mediator)

loginMediator.NAME = "loginMediator"



function loginMediator:ctor( )
    loginMediator.super.ctor(self)
end

function loginMediator:listNotificationInterests()
	return {
        "open"
    }
end

function loginMediator:handleNotification( notification )
    if notification.name == "open" then 
        local s = display.newScene("NewScene")
        local _root = framework.UIManager.createCsd("views.login.login")
        s:addChild(_root)
        display.runScene(s)

        local bg = _root:getChildByName("Image_2")
        
        local GL_P = cc.GLProgramCache:getInstance():getGLProgram( "ttttt" )
        if not GL_P then 
            local glProgram = cc.GLProgram:createWithFilenames("games/shaders/ccShader.vert", "games/shaders/ccShader.frag","ttttt")
            local glProgramState = bg:getGLProgramState()
            if not glProgramState then  
                glProgramState = cc.GLProgramState:create(glProgram)
            else
                glProgramState:setGLProgram(glProgram)
            end
            
            local texture = display.loadImage("ui/" .. "pet_icon_1_2.jpg")
            glProgramState:setUniformTexture("textures", texture)
            glProgramState:applyUniforms()
            bg:setGLProgramState( glProgramState )
        end
    end
end

return loginMediator