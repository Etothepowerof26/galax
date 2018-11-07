module("galax", package.seeall)

ChatCommands = {}
ChatCommands.ChatCommands = {}

function ChatCommands.NewChatCommand(Command, Level, Callback)
	-- Level as in rank.
	
	if (istable(Command)) then
		table.foreach(Command, function(_, TableCommand)
			ChatCommands.NewChatCommand(TableCommand, Level, Callback)
		end)
	else
		ChatCommands.ChatCommands[Command] = {
			Level = Level,
			Callback = Callback
		}
	end
end

if (SERVER) then
	ChatCommands.Prefix = "[%.%!%/]"
	Hook("PlayerSay", HookTag, function(Player, Text)
		if (string.sub(Text, 1, 1):find(ChatCommands.Prefix)) then
			local Found = false
			table.foreach(ChatCommands.ChatCommands, function(CommandString, CommandTable)
				if (Found) then return end
				if (string.sub(Text, 2, string.len(CommandString) + 1) == CommandString) then
					if ((Player:GetNetData("RankNumber") or 1) >= CommandTable.Level) then
						CommandTable.Callback(Player, string.sub(Text, string.len(CommandString) + 3))
					else
						Player:ChatPrint("You cannot use this command!")
					end
					Found = true
				end
			end)
		end
	end)
	
	ChatCommands.NewChatCommand({"test1", "test2", "test3", "testadsadas"}, 1, function(Player, TextString)
		Player:ChatPrint("test")
	end)
end