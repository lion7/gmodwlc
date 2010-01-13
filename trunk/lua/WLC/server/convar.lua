local wlc_enabled = CreateConVar( "wlc_enabled", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )
local wlc_admingroups = CreateConVar( "wlc_admingroups", "superadmin,admin", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )

--- Returns a boolean.
function convarEnabled()
	return wlc_enabled:GetBool()
end

--- Returns a string array.
function convarAdminGroups()
	return string.Explode(",", wlc_admingroups:GetString())
end