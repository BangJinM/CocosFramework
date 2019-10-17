local GameRockerLayer = class("GameRockerLayer", function()
    return cc.Layer:create()
end )

local mainFile = "ui/rocker/"

function GameRockerLayer:ctor()
end

function GameRockerLayer.create()
    local layout = GameRockerLayer.new()
    if layout:Init() then
        return layout
    else
        return nil
    end
end

function GameRockerLayer:Init()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    self._enableSize = cc.size(visibleSize.width * 0.264, visibleSize.height * 0.3125)
    -- 触摸有效区

    -- 背景
    self._bgOrigin = cc.p(visibleSize.width * 0.125, visibleSize.height * 0.2)
    -- 背景默认位置
    self._bg = ccui.ImageView:create(mainFile .. "btm_dire_key.png")
    -- 背景
    local bgSize = self._bg:getContentSize()
    self._limitRadius = bgSize.width * 0.5
    -- joystick限制半径
    self._limitRadiusSq = self._limitRadius * self._limitRadius
    -- 半径的平方
    self._joystickOrigin = cc.p(bgSize.width * 0.5, bgSize.height * 0.5)
    -- joystick 原点
    self._angle = cc.p(0,0)
    -- joystick 方向(度数)
    self._bgSize = bgSize

    self:setContentSize(self._enableSize)
    self._bg:setPosition(self._bgOrigin)
    self._bg:setCascadeOpacityEnabled(true)
    self:addChild(self._bg, 2)

    -- 摇杆
    self._gamePad = ccui.ImageView:create(mainFile .. "coin_dire_key_1.png")
    self._bg:addChild(self._gamePad)
    self._gamePad:setPosition(cc.p(self._bgSize.width / 2, self._bgSize.height / 2))

    self._eventGuideCount = 0
    self:gamePadVisible(true)
    self:registerTouchListener()

    self:InitShow()
    return true
end

function GameRockerLayer:InitShow()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local viewSize = cc.Director:getInstance():getVisibleSize()

    self:setPosition(cc.p(origin.x, origin.y))
end

function GameRockerLayer:onTouchBegan(touch, event)
    if not self:isVisible() then
        return false
    end

    if not self:CheckTouch(touch) then
        -- 是否是当前触摸对象
        return false
    end

    if not self:checkGamePadRect(touch) then
        -- 是否在点击rect
        return false
    end

    self:gamePadVisible(true)
    self:JoystickLogic(touch)

    return true
end


function GameRockerLayer:onTouchMoved(touch, event)
    if not self:CheckTouch(touch) then
        return
    end

    self:JoystickLogic(touch)
end


function GameRockerLayer:onTouchEnded(touch, event)
    if not self:CheckTouch(touch) then
        return
    end

    self:ResetGamePad()
end

function GameRockerLayer:CheckTouch(touch)
    if (self._curTouch and touch and self._curTouch:getId() ~= touch:getId()) then
        return false
    end

    return true
end


function GameRockerLayer:JoystickLogic(touch)
    -- swallow touch
    self._listener:setSwallowTouches(true)

    if self._curTouch == nil then
        self._curTouch = touch
    end

    local touchPoint = self._bg:convertTouchToNodeSpace(touch)
    local targPos = self:calcTargPos(touchPoint)

    self._gamePad:setPosition(targPos)

    self:SetGamePadDir(cc.pSub(targPos, self._joystickOrigin))
end


function GameRockerLayer:calcTargPos(movePos)
    local diff = cc.pSub(movePos, self._joystickOrigin)
    local distSq = cc.pLengthSQ(diff)

    if (distSq <= self._limitRadiusSq) then
        return movePos
    end

    diff = cc.pNormalize(diff)
    diff = cc.pMul(diff, self._limitRadius)

    return cc.pAdd(self._joystickOrigin, diff)
end


function GameRockerLayer:gamePadVisible(visible)
    local opacityPad = visible and 255 or 63
    local opacityBG = visible and 255 or 102
    self._gamePad:setOpacity(opacityPad)
    self._bg:setOpacity(opacityBG)
end


function GameRockerLayer:checkGamePadRect(touch)
    local bOutSide = true
    local touchPoint = self:convertTouchToNodeSpace(touch)
    local gamePadRect = cc.rect(0, 0, self._enableSize.width, self._enableSize.height)

    if (cc.rectContainsPoint(gamePadRect, touchPoint)) then
        self._bg:setPosition(touchPoint)
        bOutSide = false
    end

    return not bOutSide
end


function GameRockerLayer:SetGamePadDir(vec)
    local dis = cc.pLengthSQ(vec)
    if (dis <= 900) then
        self._angle = cc.p(0,0)
    else
        self._angle = cc.p(GetPreciseDecimal(vec.x/self._limitRadius,3),GetPreciseDecimal(vec.y/self._limitRadius))
    end
end


function GameRockerLayer:GetGamePadAngle()
    return self._angle
end


function GameRockerLayer:InitTouchLayout()

    self._touchLayout = ccui.Layout:create()
    local viewSize = cc.Director:getInstance():getVisibleSize()
    self._touchLayout:setContentSize(self._enableSize.width, self._enableSize.height)
    self._touchLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    self._touchLayout:setBackGroundColor(cc.Color3B.GRAY)
    self._touchLayout:setAnchorPoint(0, 0)
    self:addChild(self._touchLayout, 0)
end


function GameRockerLayer:registerTouchListener()
    local function began(touch, event)
        return self:onTouchBegan(touch, event)
    end
    local function moved(touch, event)
        return self:onTouchMoved(touch, event)
    end
    local function ended(touch, event)
        return self:onTouchEnded(touch, event)
    end
    local function cancelled(touch, event)
        return self:onTouchEnded(touch, event)
    end

    self:setTouchEnabled(true)
    local listener = cc.EventListenerTouchOneByOne:create()
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    listener:registerScriptHandler(began, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(moved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(ended, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(cancelled, cc.Handler.EVENT_TOUCH_CANCELLED)
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    self._listener = listener
end

function GameRockerLayer:ResetGamePad()
    if (self._listener) then
        self._listener:setSwallowTouches(false)
    end

    self._angle = cc.p(0,0)
    self._curTouch = nil
    self._bg:setPosition(self._bgOrigin)
    self._gamePad:setPosition(cc.p(self._bgSize.width / 2, self._bgSize.height / 2))
end


function GameRockerLayer:SetDir(dir)
    if not dir or not dir.x or not dir.y then
        return
    end

    local targPos1 = cc.p((dir.x + 1) * self._bgSize.width * 0.5,(dir.y + 1) * self._bgSize.height * 0.5)
    local targPos = self:calcTargPos(targPos1)
    self._gamePad:setPosition(targPos)
    self:SetGamePadDir(cc.pSub(targPos, self._joystickOrigin))


    if 0 == dir.x and 0 == dir.y then
        self:ResetGamePad()
    else
        self:gamePadVisible(true)
    end
end

function GetPreciseDecimal(nNum, n)
    if type(nNum) ~= "number" then
        return nNum;
    end
    
    n = n or 0;
    n = math.floor(n)
    local fmt = '%.' .. n .. 'f'
    local nRet = tonumber(string.format(fmt, nNum))

    return nRet;
end

return GameRockerLayer