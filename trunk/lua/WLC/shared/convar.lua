local wlc_enabled = CreateConVar( "wlc_enabled", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )
local wlc_admingroups = CreateConVar( "wlc_admingroups", "superadmin,admin", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )
local wlc_defaultaction = CreateConVar( "wlc_defaultaction", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE } )