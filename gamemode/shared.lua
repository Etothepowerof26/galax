GM.Name = "galax"
GM.Author = ""
DeriveGamemode("sandbox")
function GM:Initialize()
	self.BaseClass:Initialize()
end

module("galax", package.seeall)

FileLoc = "LUA"
Init = function(NewFilePath)
	-- Loads the files based on name.
	-- If it cannot find any identifier, it runs it shared.
	-- Will also be recursive.
	
	if not NewFilePath then
		
	else
	
	end
end

hook.Add("InitPostEntity", "galax", Init)