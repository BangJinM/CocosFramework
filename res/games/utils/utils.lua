local Test = class("Test")

local kDoubleTime = 1

function Test:ctor( )
    self._longPressEnabled = true
    self._doubleEvent = true
end

function Test:_addTouchEventListener(object, touchCallBack, clickCallback, doubleClickCallback)
    local _delayCallback = false
    local isMoved = true

	local function delayCallback()
		_delayCallback = true
        
        if touchCallBack then
            local _distanceX = math.abs( object:getTouchMovePosition().x - object:getTouchBeganPosition().x )
            local _distanceY = math.abs( object:getTouchMovePosition().y - object:getTouchBeganPosition().y )
            if ((not isMoved) or ( _distanceX <= 15 and _distanceY <= 15 ) ) and self._longPressEnabled then
                touchCallBack( object, 0 )
            end
        end
	end

    local function destoryDelayHandler()
        if self._clickDelayHandler then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry( self._clickDelayHandler )
            self._clickDelayHandler = nil
        end
    end
    
    local function touchCallback( sender, _type )
		if ccui.TouchEventType.began == _type then
			_delayCallback = false
            isMoved = false

			if touchCallBack then
        		sender:stopAllActions()
        		sender:runAction( cc.Sequence:create( cc.DelayTime:create( 0.6 ), cc.CallFunc:create( delayCallback ) ) )
			end

		elseif ccui.TouchEventType.moved == _type then
            isMoved = true
		elseif ccui.TouchEventType.ended == _type then
           
			sender:stopAllActions()
            
			if _delayCallback == false then

                 -- 判断是否有双击事件
                if self._doubleEvent then

                    -- 记录上一次点击时间
                    if not self._lastClickTime then
                        self._lastClickTime = true
                        -- 记录单击触发
                        self._clickDelayHandler = cc.Director:getInstance():getScheduler():scheduleScriptFunc( function()
                            if clickCallback then
				               clickCallback( sender, _type,self._clickData )
				            end
                            self._lastClickTime = nil
                            destoryDelayHandler()
                        end,kDoubleTime,false)
                    else
                        destoryDelayHandler()
                        if doubleClickCallback then
                            doubleClickCallback()
                        end

                        self._lastClickTime = nil
                    end

                else
                    if clickCallback then
				       clickCallback( sender, _type, self._clickData )
				    end
                end
			end
        elseif ccui.TouchEventType.canceled == _type then
            sender:stopAllActions()
		end
	end
	object:addTouchEventListener( touchCallback )
    object:setTouchEnabled(true)
end

return Test