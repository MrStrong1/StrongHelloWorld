local ShopScene = class("ShopScene", function()
	return display.newScene("ShopScene")
end)
require("app.ShopDefine")

function ShopScene:ctor()
	--当前选中商品的编号
	SHOP_BUYNUMBER = 0

	--
	self.Func = true

	--UI
	self:CreateBG() --背景
	self:CreateItems() --道具菜单
	self:MoneyShow() --金币显示
	self:Introduce() --文字介绍

end

-- 创建背景
function ShopScene:CreateBG()
	local shop_Background = display.newSprite(SHOP_PICTURE.SHOP_BACKGROUND)
	shop_Background:setAnchorPoint(ccp(0, 0))
	shop_Background:setScaleX(display.width/shop_Background:getContentSize().width)
	shop_Background:setScaleY(display.height/shop_Background:getContentSize().height)
	shop_Background:setPosition(ccp(0, 0))
	self:addChild(shop_Background,0)
end

-- 创建道具框
function ShopScene:CreateItems()
	local shop_ItemsBox = display.newSprite(SHOP_PICTURE.SHOP_TABBG)
		shop_ItemsBox:setAnchorPoint(ccp(0.5, 0))
		shop_ItemsBox:setScaleX(display.cx/shop_ItemsBox:getContentSize().width)
		shop_ItemsBox:setScaleY(display.cy/shop_ItemsBox:getContentSize().height*2)
		shop_ItemsBox:setPosition(ccp(display.cx/2+20, 0))
		self:addChild(shop_ItemsBox,0)

	--返回按钮
	local back_Button = cc.ui.UIPushButton.new({normal = SHOP_BUTTON.BUTTON_BACK[1],pressed = SHOP_BUTTON.BUTTON_BACK[2]},{scale9 = true})
		back_Button:setAnchorPoint(ccp(0.5, 0.5))
		back_Button:setPosition(ccp(50,shop_ItemsBox:getContentSize().height-50))
		shop_ItemsBox:addChild(back_Button,0)
		back_Button:onButtonClicked(function()
			if self.Func then
				local scene = MainScene.new()
				CCDirector:sharedDirector():replaceScene(scene)
			end
		end)

	--道具的创建
	--转换为int类型，用checkint,但是这个函数是使用四舍五入的方法
	local menus = {} --设置菜单的items表
	for k,v in pairs(SHOP_PICTURE.ITEMSBOX_ITEM) do
		local menu_Item = ui.newImageMenuItem({
				image = v,
				imageSelected = v,
				tag = k,
				listener = function ()
					if self.Func then
						self:Panduan(k)
					end
				end,
				x =SHOP_MENUITEM.ITEM_DIS*((k-1)%4)-SHOP_MENUITEM.ITEM_LEFT,
				y = SHOP_MENUITEM.ITEM_TOP-checkint(k/4+0.4)*SHOP_MENUITEM.ITEM_DIS 
			})
		menus[k] = menu_Item --将item存到表中
	end

	local menu = ui.newMenu(menus) --将表中的项添加到menu中
	--menu:alignItemsVertically() --默认设置items的位置，自己设定的x和y无法使用
	--menu:setAnchorPoint(ccp(0.5, 1))  --无法更改锚点
	menu:setPosition(ccp(shop_ItemsBox:getContentSize().width/2, shop_ItemsBox:getContentSize().height/2))
	shop_ItemsBox:addChild(menu,0)


	--购买按钮
	local menu_Button = cc.ui.UIPushButton.new({normal = SHOP_BUTTON.BUTTON_BUY[1],pressed = SHOP_BUTTON.BUTTON_BUY[2]},{scale9 = true})
		menu_Button:setAnchorPoint(ccp(0.5, 0.5))
		menu_Button:setPosition(ccp(display.cx*3/2,display.cy/4))
		self:addChild(menu_Button,0)
		menu_Button:onButtonClicked(function (  )
			if self.Func then
				if SHOP_BUYNUMBER == 0 then  --判断是否已经选择商品
					shop_introduce:setString("请选择商品，谢谢！")
				else
					if UserMoney<BUY_MONEY[SHOP_BUYNUMBER] then --金币是否够
						self:PromptBox(SHOP_PICTURE.SHOP_NOENOUGH)
					else
						self:BuyBox(SHOP_BUYNUMBER)--弹出购买提示框
					end
				end
			end
		end)
	end

--显示欢迎语和产品介绍
--改变label的值用setString函数
function ShopScene:Introduce(  )
	shop_introduce = ui.newTTFLabel({text = SHOP_STRING.STRING_WELCOME,color = ccc3(255, 255, 0),size = 20})
	shop_introduce:setAnchorPoint(ccp(0.5, 0.5))
	shop_introduce:setPosition(ccp(display.cx*3/2, display.cy))
	self:addChild(shop_introduce,0)
end

--创建金币框
function ShopScene:MoneyShow()
	--底框
	local shop_moneybox = display.newSprite(SHOP_PICTURE.SHOP_MONEYBOX)
	shop_moneybox:setScaleY(0.5)
	shop_moneybox:setScaleX(0.7)
	shop_moneybox:setAnchorPoint(ccp(0,0))
	shop_moneybox:setPosition(ccp(display.width-150, display.height-50))
	self:addChild(shop_moneybox,0)

	--金币
	local shop_moneyImage = display.newSprite(SHOP_PICTURE.SHOP_MONEY)
	shop_moneyImage:setScale(shop_moneybox:getContentSize().height/shop_moneyImage:getContentSize().height)
	shop_moneyImage:setAnchorPoint(ccp(0, 0))
	shop_moneyImage:setPosition(ccp(-15, 0))
	shop_moneybox:addChild(shop_moneyImage,0)

	--添加
	local shop_moneyAdd = cc.ui.UIPushButton.new({normal = SHOP_PICTURE.SHOP_CLOSE[2],pressed = SHOP_PICTURE.SHOP_CLOSE[1]},{scale9 = true})
	--shop_moneyAdd:setScale(shop_moneybox:getContentSize().height/shop_moneyImage:getContentSize().height)
	shop_moneyAdd:setAnchorPoint(ccp(0, 0))
	shop_moneyAdd:setPosition(ccp(shop_moneybox:getContentSize().width-30, 0))
	shop_moneybox:addChild(shop_moneyAdd,0)
	shop_moneyAdd:onButtonClicked(function()
		if  self.Func then
			self:PromptBox(SHOP_PICTURE.SHOP_ADDCOIN)
		end
	end)

	--金币数量
	shop_moneyLabel = ui.newTTFLabel({text = tostring(UserMoney),color = ccc3(255, 255, 0),size = 40})
	shop_moneyLabel:setAnchorPoint(ccp(0.5, 0.5))
	shop_moneyLabel:setPosition(ccp(shop_moneybox:getContentSize().width/2, shop_moneybox:getContentSize().height/2))
	shop_moneybox:addChild(shop_moneyLabel,0)
end


--是否购买提示框
function ShopScene:BuyBox(number)

	self.Func = false

	--购买提示框
	local buyorNot = display.newSprite(SHOP_PICTURE.SHOP_BUYTRUE)
	buyorNot:setScale(0.01)
	buyorNot:setPosition(ccp(display.cx, display.cy))
	self:addChild(buyorNot,1)

	--Label
	local coinnumber_label = ui.newTTFLabel({ text = "将花费" .. BUY_MONEY[number],color = ccc3(255, 0, 0),size = 50})
	coinnumber_label:setAnchorPoint(ccp(0.5, 0.5))
	--coinnumber_label:setPosition(ccp(0, 0))
	coinnumber_label:setPosition(ccp(buyorNot:getContentSize().width/2, buyorNot:getContentSize().height/2))
	buyorNot:addChild(coinnumber_label,0)

	--是按钮
	local button_yes = cc.ui.UIPushButton.new({normal = SHOP_PICTURE.SHOP_YES[1],pressed = SHOP_PICTURE.SHOP_YES[2]},{scale9 = true})
	button_yes:setAnchorPoint(ccp(0.5, 0.5))
	button_yes:setScale(2)
	button_yes:setPosition(ccp(buyorNot:getContentSize().width/4, buyorNot:getContentSize().height/4))
	button_yes:onButtonClicked(function()
		self.Func = true
		SHOP_BUYBUTTON[number] = true --
		self:Panduan(number)
		UserMoney = UserMoney - BUY_MONEY[number] --更改金钱
		shop_moneyLabel:setString(tostring(UserMoney)) --更改金钱的显示
		button_yes:removeFromParentAndCleanup(true)
		buyorNot:removeFromParentAndCleanup(true)
	end)
	buyorNot:addChild(button_yes)

	--否按钮
	local button_no = cc.ui.UIPushButton.new({normal = SHOP_PICTURE.SHOP_NO[1],pressed = SHOP_PICTURE.SHOP_NO[2]},{scale9 = true})
	button_no:setScale(2)
	button_no:setAnchorPoint(ccp(0.5, 0.5))
	button_no:setPosition(ccp(buyorNot:getContentSize().width/4*3, buyorNot:getContentSize().height/4))
	button_no:onButtonClicked(function()
		self.Func = true
		button_no:removeFromParentAndCleanup(true)
		buyorNot:removeFromParentAndCleanup(true)
	end)
	buyorNot:addChild(button_no)
	--提示框放大
	local scaleTo = cc.ScaleTo:create(0.5,0.5)
	buyorNot:runAction(scaleTo)
end

--金币不足/添加金币提示框
function ShopScene:PromptBox(stringPic)

	self.Func = false

	local NoEnough = display.newSprite(stringPic)
	NoEnough:setScale(0.01)
	NoEnough:setPosition(ccp(display.cx, display.cy))
	self:addChild(NoEnough,1)
	local scaleTo = cc.ScaleTo:create(0.5,0.5)
	--关闭按钮
	local closeBox = cc.ui.UIPushButton.new({normal = SHOP_PICTURE.SHOP_CLOSE[1],pressed = SHOP_PICTURE.SHOP_CLOSE[2]},{scale9 = true})
	closeBox:setAnchorPoint(ccp(1, 1))
	closeBox:setPosition(ccp(NoEnough:getContentSize().width, NoEnough:getContentSize().height))
	closeBox:onButtonClicked(function()
		self.Func = true
		closeBox:removeFromParentAndCleanup(true)
		NoEnough:removeFromParentAndCleanup(true)
	end)
	NoEnough:addChild(closeBox)

	NoEnough:runAction(scaleTo)
end

--显示商品的介绍信息
function ShopScene:Panduan(_number)
	SHOP_BUYNUMBER = _number
	local num = 2
	--print("···" .. SHOP_BUYBUTTON[SHOP_BUYNUMBER])
	if SHOP_BUYBUTTON[SHOP_BUYNUMBER] == true then
		num = 1
	end
	shop_introduce:setString(SHOP_STRING.STRING_BUY[SHOP_BUYNUMBER].."\n$"..tostring(BUY_MONEY[SHOP_BUYNUMBER]) .. SHOP_STRING.STRING_TISHI[num])
end



return ShopScene