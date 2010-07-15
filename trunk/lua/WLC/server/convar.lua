CreateConVar( "wlc_defaultaction", "1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )

--- Returns a boolean.
function convarDefaultAction()
	return GetConVar("wlc_defaultaction"):GetBool()
end