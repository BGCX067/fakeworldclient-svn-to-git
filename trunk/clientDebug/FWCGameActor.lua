--сно╥╫ги╚
require "FWCAnimation"

DRIVE_LEFT_STATE = 0
DRIVE_RIGHT_STATE = 1
DRIVE_STOP_STATE = 2

GameActorType = {
	sprite = nil,
	rightAction = nil,
	leftAction = nil,
	driveState = nil,
	winSize = nil,
	init = function(self,object)
		object = object or {}
		setmetatable(object,self)
		self.__index = self
		self:reInit()
		return object
	end,
	
	reInit = function(self)
		driveState = DRIVE_STOP_STATE
		self.winSize = cocos2d.CCDirector:sharedDirector():getWinSize()
	end,
	
	setSprite = function(self,spriteName)
		self.sprite = cocos2d.CCSprite:spriteWithFile(spriteName)
		
	end,
	
	setPosition = function(self,point)
		self.sprite:setPosition(point)
	end,
	
	getPosition = function(self)
		return self.sprite:getPosition()
	end,
	
	driveLeft = function(self)
		driveState = DRIVE_LEFT_STATE
		self.sprite:stopAction(leftAction)
		self.sprite:stopAction(rightAction)
		self.sprite:stopAction(leftAction)
		leftAction = getAnimationActionByName("bearWalkLeft0",7)
		leftAction = cocos2d.CCRepeatForever:actionWithAction(leftAction)
		self.sprite:runAction(leftAction)
	end,
	
	driveRight = function(self)
		driveState = DRIVE_RIGHT_STATE
		self.sprite:stopAction(leftAction)
		self.sprite:stopAction(rightAction)
		rightAction = getAnimationActionByName("bearWalkRight0",7)
		rightAction = cocos2d.CCRepeatForever:actionWithAction(rightAction)
		self.sprite:runAction(rightAction)
	
	end,
	
	driveStop = function(self)
		driveState = DRIVE_STOP_STATE
		self.sprite:stopAction(leftAction)
		self.sprite:stopAction(rightAction)
	end,
	
	actorUpdate = function(self)
		local point = self:getPosition();
		if driveState == DRIVE_LEFT_STATE then
			point.x = point.x - 1
			self:setPosition(point)
		end
		
		if driveState == DRIVE_RIGHT_STATE then 
			point.x = point.x + 1
			self:setPosition(point)		
		end
		
		if point.x < 10 then 
			point.x = 10
		end
		
		if point.x > self.winSize.width - 10 then 
			point.x = self.winSize.width - 10
		end
	end
	

}




