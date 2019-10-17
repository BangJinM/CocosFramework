--[[
    富文本生成器
    例如：<font type='button' buttonID='1' color='#ffffff' size='20' >    dajljl</font>
    解释成：生成《    dajljl》并拥有点击事件，并对调事件ID为1，字体颜色为#ffffff,字体大小为20
--]]

local RichTextCreator = class('RichTextCreator')

local fontPath = "fonts/font.ttf"
local DEFAULTSIZE =  20
local DEFAULTCOLOR = cc.c3b(0, 0, 0)
local DEFAULTWIDTH = 200

function RichTextCreator:TransformToRGBValue(value)
    local _r = tonumber("0x" .. string.sub(value, 1, 2))
    local _g = tonumber("0x" .. string.sub(value, 3, 4))
    local _b = tonumber("0x" .. string.sub(value, 5, 6))
    return cc.c3b(_r, _g, _b)
end

function RichTextCreator:createRichElement(richText, strValue, size, color)
    for _, value in pairs(strValue.strValues) do
        if value == "\n" then
            richText:pushBackElement(ccui.RichElementNewLine:create(0, color, 255))
        else
            local elementNode
            local fp = strValue.attributes.fontPath or fontPath
            if strValue.attributes.type == "button" then 
                local label = ccui.Text:create(value, fp, size)
                label:setTextColor(cc.c4b(color.r, color.g, color.b, 255))
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
                elementNode = ccui.RichElementText:create(0, color, 255, value, fp, size)
            end
            richText:pushBackElement(elementNode)
        end
    end

end

function RichTextCreator:createRichText(value, width, defaultSize, defaultColor, callback)
    width = width or DEFAULTWIDTH
    defaultSize = defaultSize or DEFAULTSIZE
    defaultColor = defaultColor or DEFAULTCOLOR

    if nil == value or string.len(value) == 0 then
        print("-------------------RichTextCreator:createRichText invalid value")
        return nil
    end

    self.callback = callback

    local _strValue = value
    _strValue = string.gsub(_strValue, "<p>", "")

    local _richText = ccui.RichText:create()
    _richText:ignoreContentAdaptWithSize(false)
    _richText:setContentSize(width, 0)

    local RichTextParser = require("utils.RichTextParser")
    local elements = RichTextParser:parser(_strValue)

    -- 遍历所有字块
    for _, value in pairs(elements) do 
        local color = value.attributes.color ~= nil and self:TransformToRGBValue(value.attributes.color) or defaultColor
        local size = value.attributes.size ~= nil and tonumber(value.attributes.size) or defaultSize
        self:createRichElement(_richText, value, size, color)
    end

    _richText:formatText()
    return _richText
end

function RichTextCreator:setCallBack( callback )
    self.callback = callback
end

function RichTextCreator:setFontPath( path )
    if cc.FileUtils:getInstance():isFileExist(path) == true then 
        fontPath = path
    else
        printError(path.." is not Exist!!!!")
    end
end

return RichTextCreator