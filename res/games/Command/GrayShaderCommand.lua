local GrayShaderCommand = class('GrayShaderCommand', framework.SimpleCommand)

function GrayShaderCommand:ctor()
end

function GrayShaderCommand:execute(notification)
    local data = notification:getBody()
    local node = data.node
    if not node then
        return
    end

    local GL_P = cc.GLProgramCache:getInstance():getGLProgram( "ShaderUIGrayScale" )

    if GL_P then
        if tolua.type(node) == "ccui.Button" then
            local normal = node:getRendererNormal()
            local clicked = node:getRendererClicked()
            local disabled = node:getRendererDisabled()

            if normal then
                normal:setGLProgram(GL_P)
            end

            if clicked then
                clicked:setGLProgram(GL_P)
            end

            if disabled then
                disabled:setGLProgram(GL_P)
            end
        elseif tolua.type(node) == "ccui.LoadingBar" then
            local renderer = node:getVirtualRenderer()
            if renderer then
                renderer:setGLProgram(GL_P)
            end
        else
            node:setGLProgram( GL_P );
        end

    end
    

end


return GrayShaderCommand
