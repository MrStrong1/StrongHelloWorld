--ShopScene
--picture
SHOP_PICTURE = {
	--道具框图片
	SHOP_TABBG = "Shop/tabBg1.png",
	--背景图片
	SHOP_BACKGROUND = "Shop/mainBG.png",
	--menu中各项的图片
	ITEMSBOX_ITEM = {
		"Shop/b1.png",
		"Shop/b2.png",
		"Shop/b3.png",
	},
	--金币图片
	SHOP_MONEY = "Shop/coin2.png",
	--金币显示底框
	SHOP_MONEYBOX = "Shop/moneyBox.png",
	--金币不足提示框图片
	SHOP_NOENOUGH = "Shop/noenough.png",
	--购买提示框的图片
	SHOP_BUYTRUE = "Shop/noenough.png",
	--增加金币提示框
	SHOP_ADDCOIN = "Shop/addCoin.png",
	--关闭按钮的图片
	SHOP_CLOSE = {
		"Shop/buyCoin11.png",
		"Shop/buyCoin1.png"
	},
	--是，的图片
	SHOP_YES = {
		"Shop/backmenu11.png",
		"Shop/backmenu1.png"
	},
	--否，的图片
	SHOP_NO = {
		"Shop/backmenu22.png",
		"Shop/backmenu2.png"
	}
}
--产品介绍
SHOP_STRING = {
	STRING_WELCOME = "欢迎亲爱的您光临本小店\n请尽情挑选",
	STRING_BUY = {
		"死亡时急速冲刺15秒",
		"开局急速冲刺600米",
		"保护主角，吸收一次伤害"
	},
	STRING_TISHI = {
		"(已拥有)",
		"(未拥有)"
	}
}
--商品价格
BUY_MONEY = {
	800,
	2000,
	800
}

--位置
-- SHOP_CCP = {
-- 	ITEMSBOX_ANCHOR = ccp(0, 0),
-- 	ITEMSBOX_POSITION = ccp(display.cx, 0),
-- 	BCKGROUND_ANCHOR = ccp(0, 0),
-- 	BCKGROUND_POSITIN = ccp(0, 0)
-- }
--金币图片
SHOP_BUTTON = {
	--购买的图片
	BUTTON_BUY = {
		"Shop/buyBt1.png",
		"Shop/buyBt.png"
	},
	--金币添加的图片
	BUTTON_ADD = {
		"Shop/buyCoin11.png",
		"Shop/buyCoin1.png"
	},
	--返回的图片
	BUTTON_BACK = {
		"Shop/fanhui.png",
		"Shop/fanhui1.png"
	}
}
--menu菜单中Items的位置相关参数
--x =130*((k-1)%4)-200,y = 300-checkint(k/4+0.4)*130 
SHOP_MENUITEM = {
	ITEM_DIS = 130,
	ITEM_LEFT = 200,
	ITEM_TOP = 300,
	ITEM_NUM = 3
}
--判断道具是否拥有（bool类型）
SHOP_BUYBUTTON = {
	BUY_DIED,
	BUY_GO,
	BUY_PRO
}

--顾客的金钱数量 --暂时放在这里
UserMoney = 1300