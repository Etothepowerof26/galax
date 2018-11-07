-- Helper Variables
local me = LocalPlayer()
local Space = " "
-- Helper function for inserting something to a table.
local function Insert(Table, Item)
	Table[#Table + 1] = Item
end

module("galax", package.seeall)

-- Maximum distance you can be to see someone's text.
MaxChatDist = 500

Hook("OnPlayerChat", HookTag, function(Player, Text, TeamOnly, IsDead)
	local ChatTable = {}
	
	-- Distance checking
	if (Player:GetPos():DistToSqr(me:GetPos()) > MaxChatDist ^ 2) then
		return true
	end
	
	-- IsDead
	if (IsDead) then
		Insert(ChatTable, Color(255, 0, 0))
		Insert(ChatTable, "*DEAD*")
		Insert(ChatTable, Color(255, 255, 255))
		Insert(ChatTable, Space)
	end
	
	-- Rank
	local RankTable = Player:GetRank()
	if (RankTable.ShowInChat) then
		Insert(ChatTable, Color(255, 255, 255))
		Insert(ChatTable, "[")
		Insert(ChatTable, RankTable.Color)
		Insert(ChatTable, RankTable.PrintName)
		Insert(ChatTable, Color(255, 255, 255))
		Insert(ChatTable, "]")
		Insert(ChatTable, Space)
		-- Keep this for name color.
		Insert(ChatTable, RankTable.Color)
	else
		Insert(ChatTable, RankTable.Color)
	end
	
	-- Player Name
	Insert(ChatTable, Player:Nick())
	
	-- Guild
	
	-- Semicolon Color
	Insert(ChatTable, Color(255, 255, 255))
	Insert(ChatTable, ":")
	
	-- Actual Text
	Insert(ChatTable, Space)
	Insert(ChatTable, Text)
	
	-- Adds text to chat
	chat.AddText(unpack(ChatTable))
	
	-- Hide Chat
	return true
end)