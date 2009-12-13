local wlc_enabled = CreateConVar( "wlc_enabled", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )
local wlc_admingroups = CreateConVar( "wlc_admingroups", "superadmin,admin", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )

function convarEnabled()
	return wlc_enabled:GetBool()
end

function convarAdminGroups()
	return string.Explode(",", wlc_admingroups:GetString())
end