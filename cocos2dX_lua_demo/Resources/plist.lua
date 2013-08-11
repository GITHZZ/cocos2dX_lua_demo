--plist 负责的是加载 plist文件和处理
function plistLoaderWithFile(plistName)
	local plistPath=CCFileUtils:sharedFileUtils():fullPathFromRelativePath(plistName)
	local plistDir=CCDictionary:createWithContentsOfFile(plistPath)
	tolua.cast(plistDir, "CCDictionary")
	return plistDir
end

function getKeyFromPlist(plist,key,type)
	local keyString=plist:objectForKey(key)
	tolua.cast(keyString,type)
	return keyString
end

--传入时间参数读出相应的数据
function getTypeFromCurrentTime(time)
	local timeString=CCString:create(string.format("Time%d",time))
	--读取plsit文件方法
	local plist=plistLoaderWithFile("private.plist")
	--读取文件中Time的字典
	local timeDir=getKeyFromPlist(plist,timeString:getCString(),"CCDictionary")
	--读取timeDir字典中的信息
	local type=getKeyFromPlist(timeDir,"type","CCString")
	cclog(type:intValue())
	--获得坐标位置
	local posStrX=getKeyFromPlist(timeDir,"positionX","CCString")
	cclog(posStrX:intValue())
	local posStrY=getKeyFromPlist(timeDir,"positionY","CCString")
	cclog(posStrY:intValue())
	local position=CCPointMake(posStrX:intValue(),posStrY:intValue())
	--返回类型和坐标
	return type:intValue(),position
end	