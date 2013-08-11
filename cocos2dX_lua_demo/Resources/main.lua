--游戏的主场景
function mainScene()
	require "plist"
	require "queue"

	local shapesArr=CCArray:create()--负责存储形状的数组

	--main渲染部分
	--产生形状
	local function createShape(type,x,y)
		--图形动作
		function callBackFunc()  
			cclog("Missing!");  
		end  
		local function shapeAction(shape)
			local actions=CCArray:create()
			actions:addObject(CCFadeIn:create(2.0))
			actions:addObject(CCFadeOut:create(2.0))
			actions:addObject(CCCallFunc:create(callBackFunc))
			local sequenceAction=CCSequence:create(actions) 
			shape:runAction(sequenceAction)
		end
		--产生三角形
		local function createTriangle(positionX,positionY)
			local triangle=CCSprite:create("triangle.png")
			triangle:setScale(0.5)
			triangle:setOpacity(0)
			triangle:setPosition(positionX,positionY)
			shapeAction(triangle)
			return triangle
		end
		--产生矩形
		local function createRect(positionX,positionY)
		end
		--产生圆形
		local function createCircle(positionX,positionY)
		end
		
		--逻辑判断
		--三角形 0
		if type==0 then
			return createTriangle(x,y)
		--矩形
		elseif type==1 then
			return createRect(x,y)
		--圆形
		elseif type==2 then
			return createCircle(x,y)
		--为空(-1)
		else
			return NULL
		end
	end

	local function mainSceneRender()
		local c_time=0
		local a_id=0--记录动作的id号

		--建立游戏主层
		local mainLayer=CCLayer:create()
		--游戏循环
		local function update()
			--获取配置文件中的信息
			local type,pos=getTypeFromCurrentTime(c_time)
			--检测类型(-1代表结束)
			if type==-1 then
				CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(a_id)
				return
			end
			--加载相应的精灵
			local shape=createShape(type,pos.x,pos.y)
			--添加到数组中
			mainLayer:addChild(shape)
			--shapesArr:addObject(shape)
			c_time=c_time+1
		end
		--开启循环
		a_id=CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(update,1.0,false)

		--游戏触摸事件
		local function onTouchBegan(x,y)
			cclog("begin")
		end 
		local function onTouchMoved(x,y)
		end
		local function onTouchEnded(x,y)
			cclog("end")
		end 

		local function onTouch(eventType,x,y)
			if eventType == CCTOUCHBEGAN then
				return onTouchBegan(x,y)
			elseif eventType == CCTOUCHMOVED then
				return onTouchMoved(x,y)
			else 
				return onTouchEnded(x,y)
			end
		end

		mainLayer:registerScriptTouchHandler(onTouch)
		mainLayer:setTouchEnabled(true)

		return mainLayer
	end

	--场景
	local scene=CCScene:create()
	scene:addChild(mainSceneRender())
	return scene
end