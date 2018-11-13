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

-- ultimate hakr debug mode yes
DebugMode = true

-- Logging system for Galax.
-- Basically a fancy way of printing.
Log = function(Head, Message)
	MsgC(Color(0, 127, 255), "[GALAX] ", string.upper(Head), " ", Color(255, 255, 255))
	print(Message)
end

-- Function helper for creating hooks.
Hook = function(Type, Name, Callback)
	if (type(Type) == "table") then
		table.foreach(Type, function(k, v)
			Hook(v, Name, Callback)
		end)
	else
		if (DebugMode) then
			Log("hook", "Adding hook " .. Type)
		end
		hook.Add(Type, Name, Callback)
	end
end
HookTag = "Galax"

-- Metatable helpers.
Meta = {
	Player = FindMetaTable("Player"),
	Entity = FindMetaTable("Entity")
}

-- File location variables.
AddonsFileLoc = "galax/gamemode/galax_addons"
FileLoc = "LUA"

-- File functions (basically bad code)
FileFuncs = {
	["cl_"] = function(FilePath, File)
		if (SERVER) then
			AddCSLuaFile(FilePath)
		else
			include(FilePath)
		end
	end,
	["sh_"] = function(FilePath, File)
		if (SERVER) then
			AddCSLuaFile(FilePath)
			include(FilePath)
		else
			include(FilePath)
		end
	end,
	["sv_"] = function(FilePath, File)
		if (SERVER) then
			include(FilePath)
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
		if (DebugMode) then
			Log("init", "Loading file " .. AddonsFileLoc .. "/" .. v)
		end
	
		local Prefix = v:sub(1, 3)
		if (FileFuncs[Prefix]) then
			FileFuncs[Prefix](AddonsFileLoc .. "/" .. v)
		else
			FileFuncs["sh_"](AddonsFileLoc .. "/" .. v)
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
	if (SERVER) then
		-- This creates the 'galax' folder if it doesnt exist yet.
		if (not file.Exists("galax", "DATA")) then
			file.CreateDir("galax")
		end
	end
	
	Init()
	
	-- This is needed for any data related operations.
	hook.Run("Galax:PostInit", GAMEMODE)
	
	Log("init", "Galax has loaded!")
end)
