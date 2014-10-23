--存储游戏数据
module("MyData",package.seeall)
--[[1、定义一个模块名（myData）
 生成一个用于返回的模块表
 在模块表中加入全局变量
 将模块表加入到package.seeall中，防止多次加载
 将模块表设置为函数的环境表，这使得模块中的所有操作都是在模块表中
  这样的定义的函数就直接定义在模块表中。
]]
local Money=0
local Distance=0
function setMoney(num)
	Money=num
end
function getMoney(num)
	return Money
end 
function setDistance(num)
	level=num
end 
function getDistance()
	return Distance
end