--[[
	Title: Utilities
 
	Holds helpful utility functions.
]]


--- Checks if the player has access to this script. Returns a boolean.
function utilAdminCheck( ply )
	if ply:IsValid() then
		-- playerTeam = team.GetName(ply:Team())
		for key, value in pairs( convarAdminGroups() ) do
			-- if playerTeam == value then
			if ply:IsUserGroup(value) then
				return true
			end
		end
		
		return false
	else
		return true
	end
end