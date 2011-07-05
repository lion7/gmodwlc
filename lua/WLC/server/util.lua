--[[
	Title: Utilities
 
	Holds helpful utility functions.
]]


-- Determines if WLC is enabled/disabled.
CreateConVar( "wlc_enabled", "1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
--- Returns a boolean.
function utilEnabled()
	return GetConVar("wlc_enabled"):GetBool()
end


--- Sends a hint to the player for 10 seconds if WLC is enabled.
function utilPlayerInitialSpawn( ply )
	if utilEnabled() then
		ply:SendHint("This server has Weapon and Limit Control in effect.", 10)
	end
end
hook.Add( "PlayerInitialSpawn", "wlcUtilPlayerInitialSpawn", utilPlayerInitialSpawn )


-- The usergroups that are allowed to configure WLC.
CreateConVar( "wlc_admingroups", "superadmin,admin", { FCVAR_ARCHIVE } )
--- Returns a string array.
function utilAdminGroups()
	return string.Explode(",", GetConVar("wlc_admingroups"):GetString())
end


--- Checks if the player has access to this script. Returns a boolean.
function utilAdminCheck( ply )
	if ply:IsValid() then
		-- playerTeam = team.GetName(ply:Team())
		for key, value in pairs( utilAdminGroups() ) do
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