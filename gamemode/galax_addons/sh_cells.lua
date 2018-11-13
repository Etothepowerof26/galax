module("galax", package.seeall)

--[[
	Cells Access Levels:
	1. Member
	2. Trusted (you can now build)
	3. Owner (you can invite people to the cell)
]]

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
AccessorFunc(Meta.Cell, "m_cellowner", "CellOwner")

Cells = {}
if (SERVER) then
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

	Cells.DataFile = "galax/cells.dat"
	Cells.Cells = {}
	--Galax:PostInit
	function Cells:SaveCells()
		local SaveTable = Cells.Cells
		if (file.Exists(Cells.DataFile, "DATA")) then
			-- Merges the already existing cells data with the save table, so it can
			-- be overwritten / saved again.
			local MergeTo = file.Read(Cells.DataFile)
			MergeTo = util.KeyValuesToTable(MergeTo)
			MergeTo = table.DeSanitise(MergeTo)
			
			table.Merge(SaveTable, MergeTo)
		end
		
		-- Converts the table to be able to write to a data folder.
		SaveTable = table.Sanitise(SaveTable)
		SaveTable = util.TableToKeyValues(SaveTable)
		
		-- Now, write the file.
		file.Write(Cells.DataFile, SaveTable)
	end

	function Cells:LoadCells()
		-- If a cells file doesnt exist, then just save and then do the loading procedure.
		if (not file.Exists(Cells.DataFile, "DATA")) then
			self:SaveCells()
		end
		
		-- Reads the folder and does correct procedures.
		local SaveTable = file.Read(Cells.DataFile)
		SaveTable = util.KeyValuesToTable(SaveTable)
		SaveTable = table.DeSanitise(SaveTable)
		
		-- Merges current cell data.
		table.Merge(Cells.Cells, SaveTable)
	end
	
	Hook("Galax:PostInit", HookTag, function(GM)
		Cells:LoadCells()
	end)
else
	
end