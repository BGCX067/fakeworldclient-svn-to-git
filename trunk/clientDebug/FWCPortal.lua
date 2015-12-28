--客户端脚本入口


require "FWCLevelScene"
require "FWCMainMenuScene"

-- create scene 
levelScene = LevelSceneType:init()


-- add background
spritebg = cocos2d.CCSprite:spriteWithFile("level1_bg.png")
spritebg:setPosition(cocos2d.CCPoint(0 , 0))
spritebg:setAnchorPoint(cocos2d.CCPoint(0,0))
levelScene:addSpriteToSceneLayer(spritebg,-5)

-- add Actor
bearActor = GameActorType:init()
bearActor:setSprite("bear0.png")
bearActor:setPosition(cocos2d.CCPoint(200,100))
levelScene:addActorToScene(bearActor,-4)

--bearActor:driveRight()
--bearActor:driveLeft()
-- touch handers
pointBegin = nil

function btnTouchMove(e)
    --cocos2d.CCLuaLog("btnTouchMove")
    if pointBegin ~= nil then
        local v = e[1]
        local pointMove = v:locationInView(v:view())
        pointMove = cocos2d.CCDirector:sharedDirector():convertToGL(pointMove)
        --local positionCurrent = layerFarm.__CCNode__:getPosition()
        --layerFarm.__CCNode__:setPosition(cocos2d.CCPoint(positionCurrent.x + pointMove.x - pointBegin.x, positionCurrent.y + pointMove.y - pointBegin.y))
        --local positionCurrent = layerFarm:getPosition()
        --layerFarm:setPosition(cocos2d.CCPoint(positionCurrent.x + pointMove.x - pointBegin.x, positionCurrent.y + pointMove.y - pointBegin.y))

		pointBegin = pointMove
    end
end

function btnTouchBegin(e)
	
    for k,v in ipairs(e) do
        pointBegin = v:locationInView(v:view())
        pointBegin = cocos2d.CCDirector:sharedDirector():convertToGL(pointBegin)
        --cocos2d.CCLuaLog("btnTouchBegin, x= %d, y = %d", pointBegin.x, pointBegin.y)

		if pointBegin.x > levelScene.winSize.width/2 then
			bearActor:driveRight()
		else
			bearActor:driveLeft()
		end
    end
end

function btnTouchEnd(e)
    --cocos2d.CCLuaLog("btnTouchEnd")
    touchStart = nil
	bearActor:driveStop()
end

-- regiester touch handlers
levelScene.sceneLayer:setIsTouchEnabled(true)
levelScene.sceneLayer.__CCTouchDelegate__:registerScriptTouchHandler(cocos2d.CCTOUCHBEGAN, "btnTouchBegin")
levelScene.sceneLayer.__CCTouchDelegate__:registerScriptTouchHandler(cocos2d.CCTOUCHMOVED, "btnTouchMove")
levelScene.sceneLayer.__CCTouchDelegate__:registerScriptTouchHandler(cocos2d.CCTOUCHENDED, "btnTouchEnd")




--[[

--加入测试动画
local testAction = getAnimationActionByName("testExplosion",17)
testAction = cocos2d.CCRepeatForever:actionWithAction(testAction)
spriteDog:runAction(testAction)

getAnimationActionByName("testExplosion",17)
--]]

--[[
-- add a popup menu

function menuCallbackClosePopup()
menuPopup:setIsVisible(false)
end

menuPopupItem = cocos2d.CCMenuItemImage:itemFromNormalImage("menu2.png", "menu2.png")
menuPopupItem:setPosition( cocos2d.CCPoint(0, 0) )
menuPopupItem:registerScriptHandler("menuCallbackClosePopup")
menuPopup = cocos2d.CCMenu:menuWithItem(menuPopupItem)
menuPopup:setPosition( cocos2d.CCPoint(winSize.width/2, winSize.height/2) )
menuPopup:setIsVisible(false)
layerMenu:addChild(menuPopup)

-- add the left-bottom "tools" menu to invoke menuPopup

function menuCallbackOpenPopup()
menuPopup:setIsVisible(true)
end

menuToolsItem = cocos2d.CCMenuItemImage:itemFromNormalImage("menu1.png","menu1.png")
menuToolsItem:setPosition( cocos2d.CCPoint(0, 0) )	
menuToolsItem:registerScriptHandler("menuCallbackOpenPopup")
menuTools = cocos2d.CCMenu:menuWithItem(menuToolsItem)
menuTools:setPosition( cocos2d.CCPoint(30, 40) )
layerMenu:addChild(menuTools)
--]]

function tick()

    bearActor:actorUpdate()

end

cocos2d.CCScheduler:sharedScheduler():scheduleScriptFunc("tick", 0.01, false)


mainMenu = MainMenuSceneType:init()


-- run 
--cocos2d.CCDirector:sharedDirector():runWithScene(levelScene.scene)
cocos2d.CCDirector:sharedDirector():runWithScene(mainMenu.scene)


--luaSocket Test----------------------------------
local host,port = "localhost" , 5599
local socket = require "socket"
local ip = assert(socket.dns.toip(host))
local udp = assert(socket.udp())
print("the server ip is :"..ip)
udp:sendto("hello I'm client",ip,port)












