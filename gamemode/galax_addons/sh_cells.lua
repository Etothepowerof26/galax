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
