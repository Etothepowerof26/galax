module("galax", package.seeall)

-- This hook will determine if a player can drive props. 
Hook("CanDrive", HookTag, function(Player, Entity)
	return Player:IsAdmin()
end)

-- This hook will determine if a player can modify a prop with the property menu.
-- In this case, they cant unless if they are an admin.
Hook("CanProperty", HookTag, function(Player, Property, Entity)
	return Player:IsAdmin()
end)

-- This hook will determine if a player can use a certain tool.
--
-- Table of disallowed tools, basically ones that spawn things with physics.
-- On this server, we want to restrict the amount of physics movement, to prevent
-- the server from lagging too much.
--
-- Honestly, this is way too many tools, and is probably better to get rid of them in
-- the core gamemode.
DisallowedTools = {
	"axis",
	"balloon",
	"ballsocket",
	"button",
	"camera",
	"creator",
	"duplicator",
	"dynamite",
	"editentity",
	"elastic",
	"emitter",
	"eyeposer",
	"faceposer",
	"finger",
	"hoverball",
	"hydraulic",
	"inflator",
	"lamp",
	"leafblower",
	"light",
	"motor",
	"muscle",
	"paint",
	"pulley",
	"rope",
	"slider",
	"thruster",
	"trails",
	"wheel",
	"winch"
}

Hook("CanTool", HookTag, function(Player, EyeTrace, Tool)
	if (table.HasValue(DisallowedTools, Tool)) and (not Player:IsAdmin()) then
		return false
	end
end)

if (SERVER) then -- Server Modifications
	
	
	
else -- Client Modifications
	Hook("SpawnMenuOpen", HookTag, function()
		-- If not in own cell, return false.
		-- Since function doesnt exist, replace with placeholder.
		if (false) then
			return false
		end
	end)
end