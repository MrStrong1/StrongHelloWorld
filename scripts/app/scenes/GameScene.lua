local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

require("app.LevelConfig")
require("app.MyData")

function GameScene:ctor()
	--获取当前关卡数据
	local levelData = LevelConfig.getItemData(MyData.getLevel())

	--背景
    local bg = display.newSprite(LevelConfig.getBG_ITEM(MyData.getLevel()))
    bg:setAnchorPoint(ccp(0,0))
    bg:setPosition(ccp(0, 0))
    bg:setScale(display.width/bg:getContentSize().width)
    self:addChild(bg, 0)

   	--设置关卡时间
    self._times = 60

    --时间lab
    self._timesLab = ui.newTTFLabel({
    		text = "" .. self._times,
    		size = 30,
    	})
    self._timesLab:setAnchorPoint(ccp(1,0.5))
    self._timesLab:setPosition(ccp(display.width - 10, display.height - self._timesLab:getContentSize().height))
    self:addChild(self._timesLab, 0)


    --金钱lab
    self._goldenLab = ui.newTTFLabel({
    		text = "" .. MyData.getGolden(),
    		size = 30,
    	})
    self._goldenLab:setAnchorPoint(ccp(0,0.5))
    self._goldenLab:setPosition(ccp(10, display.height - self._timesLab:getContentSize().height))
    self:addChild(self._goldenLab, 0)

    
    --创建矿石
    self.goods_tab = {}
    for k,v in pairs(levelData) do
    	local goods = Goods.new({path = v.pic, weight = v.weight, price = v.price})
	    goods:setPosition(v.pos)
	    self:addChild(goods, 0)
	    table.insert(self.goods_tab, goods)
    end



    --创建矿工
    local hero = Hero.new()
    hero:setPosition(ccp(display.cx, display.cy + 150))
    self:addChild(hero, 0)


    --创建钩子
    self._hook = Hook.new({
    	funcL = function ( ... ) --设置发射钩子的回调
        	self:startTimerTask()
        	hero:startAction()
        end,
        funcBE = function (goods) --设置钩子回收完成的回调
        	hero:endAction()
        	print(goods)
        	if goods then
        		MyData.setGolden(MyData.getGolden()+goods._price)
        		self._goldenLab:setString(MyData.getGolden())
        		print("gold = " .. MyData.getGolden())
        	end
        end,
        funcBB = function ( goods ) --设置钩子刚开始回收的回调
        	self:stopTimerTask()
        	
        	local index = 0
        	for k,v in pairs(self.goods_tab) do
        		if v == goods then
        			index = k
        			break
        		end
        	end
        	if index ~= 0 then
        		
        		local time = 1
				if goods then
					time = goods._weight/10
				end
        		goods:runAction(getSequence({CCMoveTo:create(time, ccp(display.cx, display.cy + 120)), CCCallFunc:create(function ( ... )
        			goods:removeFromParentAndCleanup(true)
        		end)}))
        		
        		table.remove(self.goods_tab, index)
        	end
        end,
        })
    self._hook:setPosition(ccp(display.cx, display.cy + 120))
    self:addChild(self._hook, 0)

    self._hook:startRotation()

    --创建用于接收触摸事件的层
    local touchLayer = TouchLayer.new({func = function ( ... )
    	if not self._hook._launchFlag then
	    	self._hook:hookLaunch()
	    end
    end})
    self:addChild(touchLayer, 0)
   	
   	--开始计时器-----倒计时
   	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._schedule1 = sharedScheduler:scheduleScriptFunc(function ( ... )
		self:timeDeal1()
	end, 1, false)
end

--开始检测碰撞
function GameScene:startTimerTask( ... )
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._schedule = sharedScheduler:scheduleScriptFunc(function ( ... )
		self:timeDeal()
	end, 0.01, false)
end

--停止检测碰撞
function GameScene:stopTimerTask()
	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	if self._schedule then
		sharedScheduler:unscheduleScriptEntry(self._schedule)
		self._schedule = nil
	end
end

--碰撞检测
function GameScene:timeDeal( ... )
	local hPosX = self._hook:getPositionX()
	local hPosY = self._hook:getPositionY()

	for k,v in pairs(self.goods_tab) do
		local posX = v:getPositionX()
		local posY = v:getPositionY()

		if math.abs(hPosX - posX) < v:getContentSize().width*0.3 and math.abs(hPosY - posY) < v:getContentSize().height*0.3 then
			self:stopTimerTask()
			self._hook:setGoods(v)
			self._hook:hookBack()

		end
	end
end

--游戏倒计时
function GameScene:timeDeal1( ... )
	self._times = self._times - 1
	self._timesLab:setString(self._times .. "")
	if self._times <= 0 then
		self._times = 0
		local sharedScheduler = CCDirector:sharedDirector():getScheduler()
		if self._schedule1 then
			sharedScheduler:unscheduleScriptEntry(self._schedule1)
			self._schedule1 = nil
		end
		self:stopTimerTask()
		local scene = nil
		--判断是否达成通关条件
		if LevelConfig.getLIMIT_ITEM(MyData.getLevel()) < MyData.getGolden() then
			scene = ShopScene.new()
		else
			MyData.setGolden(0)
			scene = MainScene.new()
		end

        CCDirector:sharedDirector():replaceScene(scene)
	end
end

function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene
