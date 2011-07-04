--[[
	Title: ConVar

	Sets up the console variables.
]]


CreateConVar( "wlc_enabled", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )
CreateConVar( "wlc_admingroups", "superadmin,admin", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )
CreateConVar( "wlc_defaultaction", "1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )


--- Returns a boolean.
function convarEnabled()
	return GetConVar("wlc_enabled"):GetBool()
end


--- Returns a string array.
function convarAdminGroups()
	return string.Explode(",", GetConVar("wlc_admingroups"):GetString())
end


--- Returns a boolean.
function convarDefaultAction()
	return GetConVar("wlc_defaultaction"):GetBool()
end