local pauseSence=class("pauseSence", function()
    return display.newScene("pauseSence")
end)

function pauseSence:ctor()
  local pabg=display.newSprite("pause.png")
  pabg:setPosition(ccp(0, 0))
  self:addChild(pabg,0)

end
function pauseSence:onEnter()
end
function pauseSence:onExit()
end
return pauseSence
