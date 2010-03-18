CreateConVar( "wlc_defaultaction", "1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
CreateConVar( "wlc_spawnrate", "0.1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )


--- Returns a boolean.
function convarDefaultAction()
	return GetConVar("wlc_defaultaction"):GetBool()
end


--- Returns an integer.
function convarSpawnRate()
	return GetConVar("wlc_spawnrate"):GetFloat()
end