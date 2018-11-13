-- Something cool!

local Floor = math.floor
local Format = string.format
local Length = 35
local MOTDMessage = "Welcome to Galax!"
local function FormattedTime(Time)
	local days, hours, minutes, seconds = Floor(Time / 86400), Floor((Time % 86400) / 3600) , Floor((Time % 3600) / 60), Floor(Time % 60)
	return Format("%d days, %d hours, %d minutes and %d seconds", days, hours, minutes, seconds)
end

module("galax", package.seeall)

if (SERVER) then
	local ServerStartTime = os.time()
	
	MOTD = {
		{Color(0, 127, 255), string.rep("=", Length)},
		{Color(255, 255, 255), string.rep("   ", (Length / 2) - (MOTDMessage:len() / 2)), MOTDMessage},
		{Color(0, 127, 255), string.rep("=", Length)},
		{Color(255, 255, 255), "Server started on " .. os.date("%H:%M:%S - %d/%m/%Y", ServerStartTime)}
	}
	
	net.Receive(HookTag .. ":MOTD", function(Length, Player)
		if Player.SentMOTD then return end
		
		local LTable = table.Copy(MOTD)
		local NewTime = os.time()
		table.insert(LTable, {Color(255, 255, 255), ".. and has been running for " .. FormattedTime(NewTime - os.time())})
		net.Start(HookTag .. ":MOTD")
		net.WriteTable(LTable)
		net.Send(Player)
		
		Player.SentMOTD = true
		Log("motd", "Sent MOTD to " .. tostring(Player))
	end)
else
	timer.Simple(0, function()
		net.Start(HookTag .. ":MOTD")
		net.SendToServer()
	end)
	
	net.Receive(HookTag .. ":MOTD", function()
		local MOTDTable = net.ReadTable()
		table.foreachi(MOTDTable, function(Index, MOTDLines)
			chat.AddText(unpack(MOTDLines))
		end)
	end)
end