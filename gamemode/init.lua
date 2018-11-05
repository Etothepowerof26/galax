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
end