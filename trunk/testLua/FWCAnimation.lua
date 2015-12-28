--�ͻ��˶���������

--__animationActions__ = {}



--param 1:������
--param 2:������Ӧ��֡��
--return ����action
function getAnimationActionByName(animationName,imgCount)
	--
	local animationAction = nil
	--animationAction = __animationActions__[animationName]
	
	
	--if animationAction == nil then
		local plistName = animationName..".plist"
		cocos2d.CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(plistName)
		local testFrames = cocos2d.CCMutableArray_CCSpriteFrame__:new()
		for i = 1,imgCount do
			local frameName = animationName.."_"..i..".Png"
			local spriteFrame = cocos2d.CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(frameName)
			testFrames:addObject(spriteFrame)
		end
		local animation = cocos2d.CCAnimation:animationWithFrames(testFrames,0.1)
		animationAction = cocos2d.CCAnimate:actionWithAnimation(animation,false)
		--__animationActions__[animationName] = animationAction	
	--end
	
	
	
	return animationAction
end

