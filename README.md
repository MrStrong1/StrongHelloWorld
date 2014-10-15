StrongHelloWorld
================

this is helloWorld 

--背景
	local bg=display.newSprite("shop/shopBack.png")
	bg:setAnchorPoint(ccp(0, 0))
	bg:setScaleX(display.width/bg:getContentSize().width)
	bg:setScaleY(display.height/bg:getContentSize().height)
	bg:setPosition(ccp(0, 0))
	self:addChild(bg,0)
