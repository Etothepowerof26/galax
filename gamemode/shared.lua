GM.Name = "Galax"
GM.Author = ""
DeriveGamemode("sandbox")
function GM:Initialize()
	self.BaseClass:Initialize()
end

team.SetUp(100, "Player", Color(175, 238, 238))

module("galax", package.seeall)

--[[

   ▄██████▄     ▄████████  ▄█          ▄████████ ▀████    ▐████▀ 
  ███    ███   ███    ███ ███         ███    ███   ███▌   ████▀  
  ███    █▀    ███    ███ ███         ███    ███    ███  ▐███    
 ▄███          ███    ███ ███         ███    ███    ▀███▄███▀    
▀▀███ ████▄  ▀███████████ ███       ▀███████████    ████▀██▄     
  ███    ███   ███    ███ ███         ███    ███   ▐███  ▀███    
  ███    ███   ███    ███ ███▌    ▄   ███    ███  ▄███     ███▄  
  ████████▀    ███    █▀  █████▄▄██   ███    █▀  ████       ███▄ 
                          ▀                                      
]]

-- Logging system for Galax.
-- Basically a fancy way of printing.
Log = function(Head, Message)
	MsgC(Color(0, 127, 255), "[GALAX] ", string.upper(Head), " ", Color(255, 255, 255))
	print(Message)
end

-- ultimate hakr debug mode yes
DebugMode = false

-- File location variables.
AddonsFileLoc = "galax/gamemode/galax_addons"
FileLoc = "LUA"

-- File functions (basically bad code)
FileFuncs = {
	["cl_"] = function(FilePath, File)
		if (SERVER) then
			AddCSLuaFile(FilePath)
		else
			include(File)
		end
	end,
	["sh_"] = function(FilePath, File)
		if (SERVER) then
			AddCSLuaFile(FilePath)
			include(File)
		else
			include(File)
		end
	end,
	["sv_"] = function(FilePath, File)
		if (SERVER) then
			include(File)
		end
	end
}

-- Initializes Galax.
Init = function(NewFilePath)
	-- Loads the files based on name.
	-- If it cannot find any identifier, it runs it shared.
	-- Will also be recursive.
	local FPath
	local Files, Directories
	
	if (not NewFilePath) then
		FPath = AddonsFileLoc .. "/*"
	else
		FPath = NewFilePath .. "/*"
	end
	
	Files, Directories = file.Find(FPath, FileLoc)
	
	table.foreach(Files, function(k, v)
		local Prefix = v:sub(1, 3)
		if (FileFuncs[Prefix]) then
			FileFuncs[Prefix](AddonsFileLoc .. "/" .. v, v)
		else
			FileFuncs["sh_"](AddonsFileLoc .. "/" .. v, v)
		end
	end)
	
	if (not next(Directories) == nil) then
		table.foreach(Directories, function(k, v)
			Init(AddonsFileLoc .. "/" .. v)
		end)
	end
end

-- Hooks it to InitPostEntity.
hook.Add("InitPostEntity", "galax", function()
	Init()
	
	Log("init", SERVER and "Loaded on the server!" or "Loaded on the client!")
end)
