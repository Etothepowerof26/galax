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