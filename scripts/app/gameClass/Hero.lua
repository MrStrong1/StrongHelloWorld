local Hero = class("Hero", function()
	return display.newNode()
end)

function Hero:ctor()
	local png = "run.png"
	local plist = "run.plist"
    --print("sdfsdfsfsfsdfsdfs")
	display.addSpriteFramesWithFile(plist, png);
	self._sp = display.newSprite("#run1.png")
	self:addChild(self._sp, 0)
end

-- 开始跑步动画
function Hero:StartRun()
	local frames = display.newFrames("run%d.png",1, 10)
	local animate = display.newAnimation(frames, 0.1)
	self._sp:playAnimationForever(animate, 0.1)
end
-- 停止动画
function Hero:StopRun()
	self._sp:stopAllActions()
end
-- 开始挥刀动画
function Hero:StartDao()
	self._sp:stopAllActions()
	display.addSpriteFramesWithFile("att.plist", "att.png");
	local frames = display.newFrames("att%d.png",1, 6)
	local animate = display.newAnimation(frames, 0.1)
	self._sp:playAnimationOnce(animate)
end
--英雄跳动
function Hero:Jump()
    self._sp:stopAllActions()
    display.addSpriteFramesWithFile("jump.plist", "jump.png");
	local frames = display.newFrames("jump1%d.png",1, 8)
	local animate = display.newAnimation(frames, 0.1)
	self._sp:playAnimationOnce(animate)
end
return Hero
