

function CreateCsd(fileName)
    local ui = require(fileName).create()
    if ui.root then
        local new_widget = ccui.Widget:create()
        new_widget:setAnchorPoint(cc.p(0, 0))

        local children = ui.root:getChildren()
        for _, child in pairs(children) do
            child:removeFromParent()
        end
        for _, child in pairs(children) do
            new_widget:addChild(child)
        end

        local name = ui.root:getName()
        -- 自适应代码
        if name ~= "Layer" and name ~= "Node" then
            local visible = cc.Director:getInstance():getVisibleSize()
            new_widget:setContentSize(visible)
            ccui.Helper:doLayout(new_widget)
        else
            new_widget:setContentSize(ui.root:getContentSize())
        end
        return new_widget
    end
    return nil
end