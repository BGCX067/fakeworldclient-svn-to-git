--客户端脚本入口
print("wellCome FWCPortal --------------------------------------")


require "FWCMainMenuScene"


local mainMenu = MainMenuSceneType:init()
cocos2d.CCDirector:sharedDirector():runWithScene(mainMenu.scene)




--luaSocket Test----------------------------------
local host,port = "localhost" , 5599
local socket = require "socket"
local ip = assert(socket.dns.toip(host))
local udp = assert(socket.udp())
print("the server ip is :"..ip)
udp:sendto("hello I'm client",ip,port)












