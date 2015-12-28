
--游戏场景
--包含一个静态背景,生命值label,积分label,主角,各种敌人，

require "FWCGameActor"

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
		return object
	end,
	
	reInit = function(self)
		self.scene = cocos2d.CCScene:node()
		self.sceneLayer = cocos2d.CCLayer:node()
		self.winSize = cocos2d.CCDirector:sharedDirector():getWinSize()
		self.scene:addChild(self.sceneLayer)
		
		
	end,
	
	addActorToScene = function(self,_actor,zOrder)
		--加入演员到场景中
		mainActor = _actor
		self:addSpriteToSceneLayer(mainActor.sprite,zOrder)
	end,
	
	addSpriteToSceneLayer = function(self,_sprite,zOrder)
		self.sceneLayer:addChild(_sprite,zOrder)
	end,
	
	addBackGroundSpriteToScene = function(self,_sprite,zOrder)
		backGroundSprite = _sprite
		self:addSpriteToSceneLayer(backGroundSprite,zOrder)
	end
	

}




