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
	realTime = RealTime()
	scTable[ply] = realTime
end


--- Removes a player from the scTable.
function scRemovePlayer( ply )
	scTable[ply] = nil
end


--- Validates if the player is allowed to spawn another object. Returns a boolean.
function scValidateTime( ply )
	realTime = RealTime()
	if (scTable[ply] + convarSpawnRate()) < realTime then
		scTable[ply] = realTime
		return true
	else
		return false
	end
end