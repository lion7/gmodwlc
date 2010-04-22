--[[
	Title: SpamControl

	Holds functions to control spamming of props.
]]


local scTable = {}
local scToolExceptions = {}
table.insert(scToolExceptions, "ol_stacker")
table.insert(scToolExceptions, "adv_duplicator")


--- Validates if the supplied toolmode is allowed.
function scValidateTool( toolMode )
	return table.HasValue(scToolExceptions, toolMode)
end


--- Adds a player to the scTable.
function scAddPlayer( ply )
	scTable[ply] = MilliTime()
end


--- Removes a player from the scTable.
function scRemovePlayer( ply )
	scTable[ply] = nil
end


--- Validates if the player is allowed to spawn another object. Returns a boolean.
function scValidateTime( ply )
	milliTime = MilliTime()
	if (scTable[ply] + convarSpawnRate()) < milliTime then
		scTable[ply] = milliTime
		return true
	else
		return false
	end
end


function MilliTime()
	return math.floor( RealTime() * 1000 + 0.5)
end