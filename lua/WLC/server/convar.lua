--[[
	Title: ConVar

	Sets up the console variables.
]]


CreateConVar( "wlc_enabled", "1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
CreateConVar( "wlc_admingroups", "superadmin,admin", { FCVAR_ARCHIVE } )
-- 0 means a weapon gets restricted if its listed (blacklist).
-- 1 means a weapon is allowed to spawn if its listed (whitelist).
CreateConVar( "wlc_weaponsaction", "0", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )


--- Returns a boolean.
function convarEnabled()
	return GetConVar("wlc_enabled"):GetBool()
end


--- Returns a string array.
function convarAdminGroups()
	return string.Explode(",", GetConVar("wlc_admingroups"):GetString())
end


--- Returns a boolean.
function convarWeaponsAction()
	return GetConVar("wlc_weaponsaction"):GetBool()
end