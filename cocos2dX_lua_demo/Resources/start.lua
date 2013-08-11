--主程序入口
local function main()
	--控制台输出
	cclog = function(...)
		print(string.format(...))
	end
	--避免内存泄露
	collectgarbage("setpause",100)
	collectgarbage("setstepmul",5000)
	--链接其它lua文件
	require "main"

	-----------
	local winSize = CCDirector:sharedDirector():getWinSize()
	
	local function createBackground()
		local backgroundLayer = CCLayer:create()
		--添加背景
		local bg = CCSprite:create("background.png")
		bg:setPosition(winSize.width/2,winSize.height/2)
		backgroundLayer:addChild(bg)

		return backgroundLayer
	end

	local function createTitle()
		local titleLayer = CCLayer:create()
		local title = CCSprite:create("Icon.png")
		title:setPosition(winSize.width/2,winSize.height/2+100)
		titleLayer:addChild(title)

		return  titleLayer
	end 

	local function createStartBtn()
		local startBtnMenuLayer = CCLayer:create()
		
		local menuStart

		local function menuStartBtnCallBack()
		    CCDirector:sharedDirector():replaceScene(mainScene());
		end 
		
		local menuStartBtn = CCMenuItemImage:create("CloseNormal.png","CloseSelected.png")
		menuStartBtn:setPosition(0,0)
		menuStartBtn:registerScriptTapHandler(menuStartBtnCallBack)
		menuStart = CCMenu:createWithItem(menuStartBtn)
		menuStart:setPosition(winSize.width/2,100)

		startBtnMenuLayer:addChild(menuStart)

		return startBtnMenuLayer
	end

	--Scene
	local gameScene = CCScene:create()
	--add Layer to Screen
	gameScene:addChild(createBackground())
	gameScene:addChild(createTitle())
	gameScene:addChild(createStartBtn())
	CCDirector:sharedDirector():runWithScene(gameScene)
end

function __G__TRACKBACK__(msg)
	print("-------------------------")
	print("LUA ERROR:"..tostring(msg).."\n")
	print(debug.trackback());
	print("-------------------------")
end

xpcall(main,__G__TRACKBACK__);