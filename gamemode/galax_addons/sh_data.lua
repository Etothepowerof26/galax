module("galax", package.seeall)

Ranks = {
	[1] = {
		ShowInChat = false,
		ClassName = "peasant",
		PrintName = "Peasant",
		Color = Color(127, 127, 127)
	},
	
	[2^63-1] = {
		ShowInChat = true,
		ClassName = "test",
		PrintName = "Test",
		Color = Color(255, 0, 0)
	}
}

-- Net Data
function Meta.Player:GetNetData(Key)
	return netdata.GetData(self, Key)
end

function Meta.Player:GetRank()
	return Ranks[self:GetNetData("RankNumber") or 1]
end

function Meta.Player:GetMoney()
	return self:GetNetData("Money") or 0
end

if (SERVER) then
	-- Net Data on the server.
	function Meta.Player:SetNetData(Key, Value)
		return netdata.SetData(self, Key, Value)
	end
	
	function Meta.Player:SetRank(RankNumber)
		RankNumber = RankNumber or 1
		self:SetNetData("RankNumber", RankNumber)
		
		if (DebugMode) then
			Log("rank", self:Nick() .. "'s rank was set to '" .. Ranks[RankNumber].ClassName .. "'")
		end
		-- TODO: Save Data function
	end
	
	function Meta.Player:SetMoney(Amount, Reason, Silent)
		self:SetNetData("Money", Amount)
		
		if (not Silent) then
			Log("cash", self:Nick() .. "'s money was set to $" .. string.Comma(tostring(Amount)) .. (Reason and "(" .. Reason .. ")" or ""))
		end
		-- TODO: Save Data function
	end
	
	function Meta.Player:GiveMoney(Amount, Reason, Silent)
		local Money = self:GetMoney()
		
		self:SetMoney(Money + Amount)
		
		if (not Silent) then
			Log("cash", "Gave $" .. string.Comma(tostring(Amount)) .. " to " .. self:Nick() .. " " .. (Reason and "(" .. Reason .. ")" or ""))
		end
		-- TODO: Save Data function
	end
	
	function Meta.Player:TakeMoney(Amount, Reason, Silent)
		local Money = self:GetMoney()
		
		if (Money - Amount < 0) then
			-- TODO: Implement debt? (would be cool)
			ErrorNoHalt("Cannot take money from " .. self:Nick() .. ", would've been a negative balance.")
		end
		
		self:SetMoney(Money - Amount)
		
		if (not Silent) then
			Log("cash", "Took $" .. string.Comma(tostring(Amount)) .. " from " .. self:Nick() .. " " .. (Reason and "(" .. Reason .. ")" or ""))
		end
		-- TODO: Save Data function
	end
else

end