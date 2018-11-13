AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

module("galax", package.seeall)

function GM:PlayerSpawn(Player)
	player_manager.SetPlayerClass(Player, "player_default")
	player_manager.RunClass(Player, "SetModel")
	print(Player)
end

function GM:PlayerInitialSpawn(Player)
	Player:SetTeam(100)
	Player:SetRank(1)
end

function GM:GetFallDamage(Player, Speed)
	-- TODO: acknowledge gear
	-- Use CSS fall damage for right now.
	return math.max(0, math.ceil(0.2418*Speed - 141.75))
end

function GM:PlayerDeath(Player, Inflictor, Attacker)
	-- Respawn the player instantly.
	Player:Respawn()
	-- TODO: Custom death animation
end

Hook("ShutDown", HookTag, function()
	local ShutdownMessage = "Server is shutting down, or restarting!"
	local Length = 80
	
	MsgC(Color(255, 127, 0), string.rep("=", Length), "\n")
	MsgC(Color(255, 255, 255), string.rep(" ", (Length / 2) - ((ShutdownMessage):len() / 2)), ShutdownMessage, "\n")
	MsgC(Color(255, 127, 0), string.rep("=", Length), "\n")
	
	-- TODO: Add saving functions for basically anything.
end)