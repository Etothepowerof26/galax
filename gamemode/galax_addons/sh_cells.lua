module("galax", package.seeall)

function Meta.Player:IsInCell()
	-- Since theres nothing for right now, return false.
	return false
end

function Meta.Player:CanBuildInCell()
	if (self:IsInCell()) then
	-- Since theres nothing for right now, return false.
		return false
	end
	return false
end

-- Cell Metatable
Meta.Cell = {}
AccessorFunc(Meta.Cell, "m_cellmembers", "Members")

function Meta.Cell:GetCellOwner()
	return self["m_cellowner"]
end

function Meta.Cell:SetCellOwner(SteamID)
	self["m_cellowner"] = SteamID
	-- TODO: Saving and notifications
end

function Meta.Cell:AddMember(Member, AccessLevel)
	if (isentity(Member)) and (IsValid(Member)) then
		Member = Member:SteamID()
	end
	
	local OldMembers = self:GetMembers() or {}
	OldMembers[Member] = AccessLevel
	self:SetMembers(OldMembers)
end

function Meta.Cell:RemoveMember(Member, AccessLevel)
	if (isentity(Member)) and (IsValid(Member)) then
		Member = Member:SteamID()
	end
	
	local OldMembers = self:GetMembers() or {}
	OldMembers[Member] = nil
	self:SetMembers(OldMembers)
end