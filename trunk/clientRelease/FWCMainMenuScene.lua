
--
require "FWCLevelScene"

function loginCallBack()
	-- create scene 
	local levelScene = LevelSceneType:init()
	local actionScene = cocos2d.CCTransitionSlideInR:transitionWithDuration(0.8,levelScene.scene)
	cocos2d.CCDirector:sharedDirector():replaceScene(actionScene)
end


MainMenuSceneType = {
	scene = nil,
	winSize = nil,
	sceneLayer = nil,
	
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
		
		self:addMenu()
		
	end,
	
	addMenu = function(self)
		local loginItem = cocos2d.CCMenuItemImage:itemFromNormalImage("button0.png","button0_b.png")
		loginItem:setPosition( cocos2d.CCPoint(0, 0) )
		local _item0Size = loginItem:getContentSize()
		local _label = cocos2d.CCLabelBMFont:labelWithString("µÇ  Â¼","testFont1.fnt")
		_label:setScale(1.5)
		_label:setPosition(cocos2d.CCPoint(_item0Size.width/2,_item0Size.height/2))
		loginItem:addChild(_label)
		loginItem:registerScriptHandler("loginCallBack")
		local menu = cocos2d.CCMenu:menuWithItem(loginItem)
		menu:setPosition( cocos2d.CCPoint(self.winSize.width/2, self.winSize.height*2/3) )
		self.sceneLayer:addChild(menu)
	end,
	
	
	
}



