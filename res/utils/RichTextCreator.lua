--[[
    富文本生成器
    例如：<font type='button' buttonID='1' color='#ffffff' size='20' >    dajljl</font>
    解释成：生成《    dajljl》并拥有点击事件，并对调事件ID为1，字体颜色为#ffffff,字体大小为20
--]]

local RichTextCreator = class('RichTextCreator')

function RichTextCreator:createTextWithMultirow(targetString, fontSize, color)
    -- 返回一个普通的Text
    local _transformString = string.gsub(targetString, "\\n", "\n")
    local _text = ccui.Text:create(_transformString, nil, fontSize)
    _text:setColor(color)
    return _text
end

function RichTextCreator:TransformToRGBValue(value)
    local _r = tonumber("0x" .. string.sub(value, 1, 2))
    local _g = tonumber("0x" .. string.sub(value, 3, 4))
    local _b = tonumber("0x" .. string.sub(value, 5, 6))
    return cc.c3b(_r, _g, _b)
end

function RichTextCreator:_CreateRichElement(richText, strValue, size, color)

    local function createElement(_strValue, _size, _color)
        return ccui.RichElementText:create(0, _color, 255, _strValue, nil, _size)
    end

    for _, value in pairs(strValue.strValues) do
        if value == "\n" then
            richText:pushBackElement(ccui.RichElementNewLine:create(0, color, 255))
        else
            local elementNode
            if strValue.attributes.type == "button" then 
                local label = ccui.Text:create()
                label:setString(value)
                label:setTextColor(cc.c4b(color.r, color.g, color.b, 255))
                label:setFontSize(size)
                elementNode = ccui.RichElementCustomNode:create(0, cc.c3b(0, 0, 0), 255, label)

                label:setTouchEnabled(true)
                label:addClickEventListener( function()
                    if self.callback then
                        if nil == strValue.attributes.id then 
                            printError("strValue.attribute.buttonID = nil")
                        end
                        self.callback(strValue.attributes.id)
                    end
                end )
            else
                elementNode = createElement(value, size, color)
            end
            richText:pushBackElement(elementNode)
        end
    end

end

function RichTextCreator:_CreateRichTextWithAnything(value, width, defaultSize, defaultColor, callback)
    -- local _str = "打算的撒的<font color="1fcb20" size="a14a">大量经验</font>"
    if nil == value or string.len(value) == 0 then
        print("-------------------RichTextCreator:_CreateRichTextWithAnything invalid value")
        return nil
    end

    self.callback = callback

    local _strValue = value
    _strValue = string.gsub(_strValue, "<p>", "")

    --
    width = width or 400
    defaultSize = defaultSize or 20
    defaultColor = defaultColor or cc.c3b(0, 0, 0)

    local _richText = ccui.RichText:create()
    _richText:ignoreContentAdaptWithSize(false)
    _richText:setContentSize(width, 0)

    local RichTextParser = require("utils.RichTextParser")
    local elements = RichTextParser:Parser(_strValue)

    for _, value in pairs(elements) do 
        local color = value.attributes.color ~= nil and self:TransformToRGBValue(value.attributes.color) or defaultColor
        local size = value.attributes.size ~= nil and tonumber(value.attributes.size) or defaultSize
        self:_CreateRichElement(_richText, value, size, color)
    end

    

    _richText:formatText()
    return _richText
end

function RichTextCreator:setCallBack( callback )
    self.callback = callback
end

return RichTextCreator