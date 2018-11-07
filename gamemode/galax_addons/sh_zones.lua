module("galax", package.seeall)

Meta.Zone = {}
AccessorFunc(Meta.Zone, "m_zonename", "ZoneName")
AccessorFunc(Meta.Zone, "m_zonedenymessage", "ZoneDenyMessage")
AccessorFunc(Meta.Zone, "m_point1", "StartPoint")
AccessorFunc(Meta.Zone, "m_point2", "EndPoint")

function Meta.Zone:CanPlayerEnter(Player)
	-- Like DenyPlayerEntry and OnPlayerEnter, can be changed as well.
	return true
end

function Meta.Zone:DenyPlayerEntry(Player, OldData)
	-- This function can be overwritten, to either damage the player or teleport them.
	Player:SetPos(OldData.Position)
	Player:SetAngles(OldData.Angles)
	Player:SetEyeAngles(OldData.EyeAngles)
	if (self:GetZoneDenyMessage()) then
		Player:ChatPrint("You cannot enter this zone! (" .. (self:GetZoneDenyMessage() or "no reason specified.") .. ")")
	end
end

function Meta.Zone:OnPlayerEnter(Player, OldData)
	local CanEnter = self:CanPlayerEnter(Player)
	if not CanEnter then
		self:DenyPlayerEntry(Player, OldData)
	end
end