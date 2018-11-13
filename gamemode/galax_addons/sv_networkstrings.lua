-- This is just a helper file for managing networking in Galax.

module("galax", package.seeall)

-- sh_guilds
util.AddNetworkString(HookTag .. ":NetworkGuilds")

-- sh_motd
util.AddNetworkString(HookTag .. ":MOTD")