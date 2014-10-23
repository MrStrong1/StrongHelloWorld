--[[触摸层响应]]
local TouchLayer=class("TouchLayer", function()
	--创建并返回一个ccnode的对象
	return display.newNode()
	end)
	function TouchLayer:ctor(params)
	  local hero=params
		self:init()
	end
	function TouchLayer:init()
		local colorLayer=display.newColorLayer(ccc4(23, 233, 50, 0))
		self:addChild(colorLayer,0)
		--触摸事件
		colorLayer:setTouchSwallowEnabled(true)
		colorLayer:setTouchEnabled(true)
		colorLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
            if event.name=="began" then
            	print("beganMask")
            	local jump=cc.JumpTo:create(0.8,ccp(hero:getPositionX(),hero:getPositionY()),50,1)
            	-- local seq=cc.Sequence:create(jump,CallFunc:create(function()
          --       local seq =CCSequence:createWithTwoActions(jump, cc.CallFunc:create(function()
          --   	Hero:Jump()
        		-- end))
          --   	hero:runAction(CCSequence:createWithTwoActions(jump, cc.CallFunc:create(function()
          --   	Hero:Jump()
        		-- end)))
				hero:runAction(jump)
            	return true
            	elseif event.name=="moved" then
                print("moved!")
                elseif event.name=="ended" then
                print("ended ")
                --点击回调函数
                
                return true
            end
            return false
		end)
	end
	return TouchLayer