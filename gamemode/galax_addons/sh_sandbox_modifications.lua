module("galax", package.seeall)

if (SERVER) then -- Server Modifications
	-- This will add hooks that dont need any other manipulation other than a 
	-- simple admin check.
	local DefaultGamemodeFunction = function(self, Player)
		return Player:IsAdmin()
	end
	
	GAMEMODE.CanDrive = DefaultGamemodeFunction
	GAMEMODE.CanProperty = DefaultGamemodeFunction
	GAMEMODE.PlayerNoClip = DefaultGamemodeFunction

	-- This hook will determine if a player can use a certain tool.
	--
	-- Table of disallowed tools, basically ones that spawn things with physics.
	-- On this server, we want to restrict the amount of physics movement, to prevent
	-- the server from lagging too much.
	--
	-- Honestly, this is way too many tools, and is probably better to get rid of them in
	-- the core gamemode.
	DisallowedTools = {"axis", "balloon", "ballsocket", "button", "camera", "creator", "duplicator", "dynamite", "editentity", "elastic", "emitter", "eyeposer", "faceposer", "finger", "hoverball", "hydraulic", "inflator", "lamp", "leafblower", "light", "motor", "muscle", "paint", "pulley", "rope", "slider", "thruster", "trails", "wheel", "winch"}

	Hook("CanTool", HookTag, function(Player, EyeTrace, Tool)
		if (table.HasValue(DisallowedTools, Tool)) and (not Player:IsAdmin()) then
			return false
		end
	end)
	
	-- This hook will prevent people from spawning props under certain situations.
	BlacklistedModels = {
		"models/props_buildings/project_destroyedbuildings01.mdl",
		"models/props_wasteland/bridge_side03-other.mdl",
		"models/props_wasteland/bridge_side03.mdl",
		"models/props_wasteland/rockgranite04c.mdl",
		"models/props_docks/prefab_piling01a.mdl",
		"models/props_c17/overpass_001b.mdl",
		"models/props_c17/overpass_001a.mdl",
		"models/props_c17/overhaingcluster_001a.mdl",
		"models/props_wasteland/tugtop001.mdl",
		"models/props_wasteland/tugtop002.mdl"
	}
	
	function GAMEMODE:PlayerSpawnedProp(Player, Model, Entity)
		if (table.HasValue(BlacklistedModels, Model)) and (not Player:IsAdmin()) then
			Entity:Remove()
			Player:ChatPrint("#galax_deny_prop")
		end
	end
else -- Client Modifications
	language.Add("galax_deny_prop", "You cannot spawn this prop!")
	
	Hook("SpawnMenuOpen", HookTag, function()
		-- If not in own cell, return false.
		-- Since function doesnt exist, replace with placeholder.
		if (false) then
			return false
		end
	end)
end