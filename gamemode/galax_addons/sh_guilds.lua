-- Using a modified premade guilds script from Meta Construct that I created
-- Still mostly WIP

module("galax", package.seeall)

Meta.Guild = {}
AccessorFunc(Meta.Guild, "m_name", "Name")
AccessorFunc(Meta.Guild, "m_classname", "ClassName")
AccessorFunc(Meta.Guild, "m_desc", "Description")
AccessorFunc(Meta.Guild, "m_owner", "GuildOwner")
AccessorFunc(Meta.Guild, "m_members", "Members")
AccessorFunc(Meta.Guild, "m_accesstype", "AccessType")
AccessorFunc(Meta.Guild, "m_enemies", "Enemies")
AccessorFunc(Meta.Guild, "m_truces", "Truces")

Guilds = {}
Guilds.Guilds = {}

function Guilds.GetPlayerGuild(Player)
	local SteamID
	if (isentity(Player)) then
		assert(not IsValid(Player), "bad argument #1 to GetPlayerGuild (entity/string expected, got NULL)")
		SteamID = Player:SteamID()
	else
		SteamID = Player
	end
	
	local GuildReturn
	table.foreachi(Guilds.Guilds, function(_, Guild)
		local MembersList = Guild:GetMembers()
		if (MembersList[SteamID]) or (Guild:GetGuildOwner() == SteamID) then
			GuildReturn = Guild
		end
	end)
	
	return GuildReturn
end

function Meta.Player:GetGuild()
	return Guilds.GetPlayerGuild(self)
end

function Meta.Player:IsInGuild(Guild)
	return (self:GetGuild() == Guild)
end

function Meta.Player:IsInSameGuild(OtherPlayer)
	if (self:GetGuild() == nil) or (OtherPlayer:GetGuild() == nil) then
		return false
	end
	return (self:GetGuild() == OtherPlayer:GetGuild())
end

if (SERVER) then
	function Guilds:NetworkGuilds()
		net.Start(HookTag .. ":NetworkGuilds")
		net.WriteTable(Guilds.Guilds)
		net.Broadcast()
	end
	
	
else
	local GuildCache = {}
	
	net.Receive(HookTag .. ":NetworkGuilds", function()
		local Table = net.ReadTable()
		Guilds.Guilds = Table -- TODO: Compress
	end)
end