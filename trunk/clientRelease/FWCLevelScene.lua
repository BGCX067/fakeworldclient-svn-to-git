
--游戏场景
--包含一个静态背景,生命值label,积分label,主角,各种敌人，

require "FWCGameActor"

__selfID__ = nil

function sysTouchMove(e)
	__selfID__:hahaTouchMove(e)
end

function sysTouchBegin(e)
	__selfID__:hahaTouchBegin(e)
end

function sysTouchEnd(e)
	__selfID__:hahaTouchEnd(e)
end

function sysTick()
	__selfID__:hahaTick()
end

function sysPauseCallBack()
	__selfID__:gamePause()
end

function sysResumeCallBack()
	__selfID__:gameResume()
end

function sysMainMenuCallBack()
	__selfID__:gameExit()
end

function sysPopMenufunc0()
	__selfID__.popMenu:removeFromParentAndCleanup(true)
end


LevelSceneType = {
	scene = nil,
	winSize = nil,
	sceneLayer = nil,
	backGroundSprite = nil,
	bloodLabel = nil,
	mainActor = nil,
	
	init = function(self,object)
		object = object or {}
		setmetatable(object,self)
		self.__index = self
		self:reInit()
		__selfID__ = self
		return object
	end,
	
	reInit = function(self)
		self.scene = cocos2d.CCScene:node()
		self.sceneLayer = cocos2d.CCLayer:node()
		self.winSize = cocos2d.CCDirector:sharedDirector():getWinSize()
		self.scene:addChild(self.sceneLayer)
		
		self:addBackGround()
		self:addPauseButton()
		self:addActor()
		self:addTouchCallBack()
		self:addTickCallBack()
	end,
	
	addActorToScene = function(self,_actor,zOrder)
		--加入演员到场景中
		self:addSpriteToSceneLayer(_actor.sprite,zOrder)
	end,
	
	addSpriteToSceneLayer = function(self,_sprite,zOrder)
		self.sceneLayer:addChild(_sprite,zOrder)
	end,
	
	addBackGroundSpriteToScene = function(self,_sprite,zOrder)
		backGroundSprite = _sprite
		self:addSpriteToSceneLayer(backGroundSprite,zOrder)
	end,
	
	addBackGround = function(self)
		-- add background
		spritebg = cocos2d.CCSprite:spriteWithFile("level1_bg.png")
		spritebg:setPosition(cocos2d.CCPoint(0 , 0))
		spritebg:setAnchorPoint(cocos2d.CCPoint(0,0))
		self:addSpriteToSceneLayer(spritebg,-5)
	end,
	
	addActor = function(self)
		-- add Actor
		bearActor = GameActorType:init()
		bearActor:setSprite("bear0.png")
		bearActor:setPosition(cocos2d.CCPoint(200,100))
		self:addActorToScene(bearActor,-4)
		self.mainActor = bearActor
	end,
	
	addInfoLabel = function(self)
		--加入信息标签【生命】【金钱】【分数】【等级】【】【】
	
	end,
	
	gamePause = function(self)
		--print("pause")
		self:popControlMenu()
	end,
	
	gameResume = function(self)
		local scaleSmall = cocos2d.CCScaleTo:actionWithDuration(0.2,0.1)
		local func = cocos2d.CCCallFunc:actionWithScriptFuncName("sysPopMenufunc0")
		local _array = cocos2d.CCArray:arrayWithCapacity(2)
		_array:addObject(scaleSmall)
		_array:addObject(func)
		local seqAction = cocos2d.CCSequence:actionsWithArray(_array)
		self.popMenu:runAction(seqAction)
	end,
	
	gameExit = function(self)
		self:cleanUp()
		local mainMenu = MainMenuSceneType:init()
		local actionScene = cocos2d.CCTransitionSlideInL:transitionWithDuration(0.8,mainMenu.scene)
		cocos2d.CCDirector:sharedDirector():replaceScene(actionScene)
	end,
	
	addPauseButton = function(self)
		--一个暂定按钮，按下后暂停游戏弹出菜单
		local pauseButton = cocos2d.CCMenuItemImage:itemFromNormalImage("button7.png","button7_b.png")
		local _item0Size = pauseButton:getContentSize()
		local _label = cocos2d.CCLabelBMFont:labelWithString("暂停","testFont1.fnt")
		_label:setPosition(cocos2d.CCPoint(_item0Size.width/2,_item0Size.height/2))
		pauseButton:addChild(_label)
		pauseButton:registerScriptHandler("sysPauseCallBack")
		local menu = cocos2d.CCMenu:menuWithItem(pauseButton)
		menu:setPosition( cocos2d.CCPoint(self.winSize.width*9/10, self.winSize.height*9/10) )
		self.sceneLayer:addChild(menu)
		
	end,
	
	
	popControlMenu = function(self)
		--弹出控制菜单 ，【继续】【关卡选择】【返回主菜单】【查看排名】【】【】
		
			local resumeButton = cocos2d.CCMenuItemImage:itemFromNormalImage("button4.png","button4_b.png")
			resumeButton:setPosition(cocos2d.CCPoint(0,250))
			local _item0Size = resumeButton:getContentSize()
			local _label = cocos2d.CCLabelBMFont:labelWithString("继  续","testFont1.fnt")
			_label:setPosition(cocos2d.CCPoint(_item0Size.width/2,_item0Size.height/2))
			resumeButton:addChild(_label)
			resumeButton:registerScriptHandler("sysResumeCallBack")
			
			local levelShooseButton = cocos2d.CCMenuItemImage:itemFromNormalImage("button4.png","button4_b.png")
			local _item0Size = levelShooseButton:getContentSize()
			local _label = cocos2d.CCLabelBMFont:labelWithString("关卡选择","testFont1.fnt")
			_label:setPosition(cocos2d.CCPoint(_item0Size.width/2,_item0Size.height/2))
			levelShooseButton:addChild(_label)
			levelShooseButton:setPosition(cocos2d.CCPoint(0,200))
			
			local mainMenuButton = cocos2d.CCMenuItemImage:itemFromNormalImage("button4.png","button4_b.png")
			local _item0Size = mainMenuButton:getContentSize()
			local _label = cocos2d.CCLabelBMFont:labelWithString("主菜单","testFont1.fnt")
			_label:setPosition(cocos2d.CCPoint(_item0Size.width/2,_item0Size.height/2))
			mainMenuButton:addChild(_label)
			mainMenuButton:registerScriptHandler("sysMainMenuCallBack")
			mainMenuButton:setPosition(cocos2d.CCPoint(0,150))
			
			local lookRankButton = cocos2d.CCMenuItemImage:itemFromNormalImage("button4.png","button4_b.png")
			local _item0Size = lookRankButton:getContentSize()
			local _label = cocos2d.CCLabelBMFont:labelWithString("查看排名","testFont1.fnt")
			_label:setPosition(cocos2d.CCPoint(_item0Size.width/2,_item0Size.height/2))
			lookRankButton:addChild(_label)
			lookRankButton:setPosition(cocos2d.CCPoint(0,100))
			
			local _popMenu = cocos2d.CCMenu:menuWithItem(resumeButton)
			_popMenu:addChild(levelShooseButton)
			_popMenu:addChild(mainMenuButton)
			_popMenu:addChild(lookRankButton)
			
			_popMenu:setPosition(cocos2d.CCPoint(self.winSize.width*1/2, self.winSize.height*1/50))
			self.popMenu = _popMenu
			self.sceneLayer:addChild(self.popMenu)
			

	
		self.popMenu:setScale(0.2)
		local fadeIn = cocos2d.CCFadeIn:actionWithDuration(0.1)
		local scaleLarge = cocos2d.CCScaleTo:actionWithDuration(0.2,1.3)
		local scaleOrigin = cocos2d.CCScaleTo:actionWithDuration(0.5,1.0)
		local _array = cocos2d.CCArray:arrayWithCapacity(3)
		_array:addObject(fadeIn)
		_array:addObject(scaleLarge)
		_array:addObject(scaleOrigin)
		local seqAction = cocos2d.CCSequence:actionsWithArray(_array)
		self.popMenu:runAction(seqAction)

	end,
	
	addTouchCallBack = function(self)
		-- regiester touch handlers
		self.sceneLayer:setIsTouchEnabled(true)
		self.sceneLayer.__CCTouchDelegate__:registerScriptTouchHandler(cocos2d.CCTOUCHBEGAN, "sysTouchBegin")
		self.sceneLayer.__CCTouchDelegate__:registerScriptTouchHandler(cocos2d.CCTOUCHMOVED, "sysTouchMove")
		self.sceneLayer.__CCTouchDelegate__:registerScriptTouchHandler(cocos2d.CCTOUCHENDED, "sysTouchEnd")

	end,
	
	addTickCallBack = function(self)
		cocos2d.CCScheduler:sharedScheduler():scheduleScriptFunc("sysTick", 1/60.0, false)
	
	end,
	
	hahaTick = function(self)
		--print("testTick")
		self.mainActor:actorUpdate()
	end,
	
	hahaTouchBegin = function(self,e)
		--print("testTouch")
	    for k,v in ipairs(e) do
			pointBegin = v:locationInView(v:view())
			pointBegin = cocos2d.CCDirector:sharedDirector():convertToGL(pointBegin)

			if pointBegin.x > self.winSize.width/2 then
				self.mainActor:driveRight()
			else
				self.mainActor:driveLeft()
			end
		end
	end,
	
	hahaTouchMove = function(self,e)
		
	end,
	
	hahaTouchEnd = function(self,e)
		
		self.mainActor:driveStop()
	end,
	
	cleanUp = function(self)
		cocos2d.CCScheduler:sharedScheduler():unscheduleScriptFunc("sysTick")
	
	end
	
	
	

}




