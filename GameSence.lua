local GameScene=class("GameScene", function()
    return display.newScene("GameScene")
end)
function GameScene:ctor()
  local bg=display.newSprite("BG2.png")
  bg:setAnchorPoint(ccp(0, 0))
  --bg:setScaleX(display.width/bg:getContentSize().width)
  bg:setScaleY(display.height/bg:getContentSize().height)
  bg:setPosition(ccp(0, 0))
  self:addChild(bg, 0, 1)

  local bg1=display.newSprite("BG2.png")
  bg1:setAnchorPoint(ccp(0, 0))
  --bg1:setScaleX(display.width/bg1:getContentSize().width)
  bg1:setScaleY(display.height/bg1:getContentSize().height)
  bg1:setPosition(ccp(display.width,0))
  self:addChild(bg1, 0, 2)

  --暂停游戏
  local zanTingBtn=cc.ui.UIPushButton.new({normal="zanting.png"},{scale9=true})
    zanTingBtn:setScale(0.3)
    zanTingBtn:setPosition(ccp(display.width-20,  display.height-20))
    self:addChild(zanTingBtn, 1)

    zanTingBtn: onButtonClicked(function(event)
      local pausesence=pauseSence.new()
      CCDirector:sharedDirector():replaceScene(pausesence)
      print ("暂停游戏")
    end)

   ---添加瓦片地图
  local filemap=CCTMXTiledMap:create("fileMap/33.tmx")
  filemap:setAnchorPoint(ccp(0,0))
  filemap:setPosition(ccp(0, 0))
  self:addChild(filemap) 

   ---创建主角英雄
  hero=Hero.new()
  hero:setAnchorPoint(ccp(0,0))
  hero:setPosition(ccp(display.cx-200,display.cy-100))
  hero:StartRun()
  self:addChild(hero ,0)
   --创建用于接收触摸事件的层
    local touchLayer=TouchLayer.new(hero)
    self:addChild(touchLayer,0)
  --开始计时，时间调度
  local sharedScheduler=CCDirector:sharedDirector():getScheduler()
    self._schedule=sharedScheduler:scheduleScriptFunc(function(...)
  --self:timeDeal()
  local move1=cc.MoveBy:create(0.1, ccp(-20,0))
  local move2=cc.MoveBy:create(0.1, ccp(-20,0))
  bg:runAction(move1)
  bg1:runAction(move2)
  if bg:getPositionX()<= -bg:getContentSize().width then
    bg:setPositionX(bg1:getPositionX()+bg:getContentSize().width)
  end
  if bg1:getPositionX()<=-bg1:getContentSize().width then
     bg1:setPositionX(bg:getPositionX() + bg1:getContentSize().width)
  end
  --print("时间调度")
  end,0.1,false)

end

function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene