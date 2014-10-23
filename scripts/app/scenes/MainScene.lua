
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

  --SimpleAudioEngine:sharedEngine():playBackgroundMusic("gemeBM.mp3",true)
  audio.playMusic("gemeBM.mp3",true)
	--背景
  local bg=display.newSprite("bg1.png")
  bg:setAnchorPoint(ccp(0, 0))
  bg:setScaleX(display.width/bg:getContentSize().width)
  bg:setScaleY(display.height/bg:getContentSize().height)
  bg:setPosition(ccp(0, 0))
  self:addChild(bg,0)
    --文字名字
    local label= ui.newTTFLabelWithShadow({text="疯狂逃跑",size = 64,shadowcolor=ccc3(250, 50, 10),color=ccc3(0, 0, 255),font="Marker Felt",align = ui.TEXT_ALIGN_CENTER,})
    label:setAnchorPoint(ccp(1, 0.5))
    label:setPosition(ccp(display.cx-20, display.cy+100))
    self:addChild(label)

    --音乐开关
   local music_btn=cc.ui.UICheckBoxButton.new({on="soundController.png",off="soundController2.png"})
    music_btn:setPosition(ccp(display.cx-200, display.cy-130))
    music_btn:onButtonStateChanged(function(event)
        if event.state=="on" then
      print("on")
      audio.resumeMusic()
      elseif event.state=="off" then
      print("off")
      audio.pauseMusic()
        end
    end)
    music_btn:setButtonSelected(true)
    self:addChild(music_btn, 0)

  --一些Menu
  --关于按钮
  local aboutBtn=cc.ui.UIPushButton.new({normal="guanyuBt1.png"},{scale9=true})
  aboutBtn:setScale(0.75)
  aboutBtn:setPosition(ccp(display.cx+140, display.cy+50))
  self:addChild(aboutBtn, 0)
  aboutBtn:onButtonClicked(function(event)
        
    local about=display.newSprite("wzabout.png")
    about:setPosition(ccp(display.cx+40, display.cy))
    about:setAnchorPoint(ccp(0, 0))
    about:setScale(1);
    self:addChild(about)
    

    local fanhuiBtn=cc.ui.UIPushButton.new({normal="fanhui.png"},{scale9=true})
    fanhuiBtn:setScale(1)
    fanhuiBtn:setPosition(ccp(display.cx+140,  display.cy+20))
    self:addChild(fanhuiBtn, 0)

    fanhuiBtn: onButtonClicked(function(event)
      about:removeFromParent()
      fanhuiBtn:removeFromParent()
    end)

  end)
     --帮助按钮
  local HelpMenu=cc.ui.UIPushButton.new({normal="help.png"},{scale9=true})
  HelpMenu:setScale(0.75)
  HelpMenu:setPosition(ccp(display.cx+140,display.cy))
  self:addChild(HelpMenu, 0)

  HelpMenu:onButtonClicked(function(event)
    local  help=display.newSprite("wzhelp.png")
    help:setPosition(ccp(display.cx+40, display.cy))
    help:setAnchorPoint(ccp(0, 0))
    self:addChild(help)

  

    local fanhuiBtn=cc.ui.UIPushButton.new({normal="fanhui.png"},{scale9=true})
    fanhuiBtn:setScale(1)
    fanhuiBtn:setPosition(ccp(display.cx+140,  display.cy+20))
    self:addChild(fanhuiBtn, 0)

    fanhuiBtn: onButtonClicked(function(event)
      help:removeFromParent()
      fanhuiBtn:removeFromParent()
    end)
  end)
    --开始按钮
	local PlayBtn=cc.ui.UIPushButton.new({normal="kaishi1.png",pressed="kaishi11.png"},{scale9=true})
	PlayBtn:setScale(0.5)
	PlayBtn:setPosition(ccp(display.cx-20, display.cy-50))
    self:addChild(PlayBtn, 0)

    PlayBtn:onButtonClicked(function(event)
        local gameScene = GameScene.new()
        CCDirector:sharedDirector():replaceScene(gameScene)
    end)
  --商城界面
  local shopBtn=cc.ui.UIPushButton.new({normal="shop.png"},{scale9=true})
  shopBtn:setScale(0.75)
  shopBtn:setPosition(ccp(display.cx+140, display.cy-50))
  self:addChild(shopBtn, 0)

  shopBtn:onButtonClicked(function(event)
    print("......")
  end)

  local overBtn=cc.ui.UIPushButton.new({normal="tuichu.png"},{scale9=true})
  overBtn:setScale(0.75)
  overBtn:setPosition(ccp(display.cx+140, display.cy-100))
  self:addChild(overBtn, 0)

    overBtn:onButtonClicked(function(event)
       print("退出游戏")
       CCDirector:sharedDirector():endToLua()
    end)
end
function MainScene:onEnter()
end

function MainScene:onExit()
end
return MainScene
