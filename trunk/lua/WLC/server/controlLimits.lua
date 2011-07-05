--[[
	Title: ControlLimits

	Holds functions to control the spawn limits and also functions to prevent props from being spammed.
]]


--- Checks all limits of a group. Returns a string array.
function limitCheck( usergroup )
	local returnString = {}
	limitEntry = sqlSelectLimitEntry(usergroup)
		
	if limitEntry == nil then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't have any limit(s).")
		return returnString
	end
	
	table.insert(returnString, "Usergroup " .. usergroup .. " has the following limit(s):")
	for key, value in pairs( limitEntry ) do
		table.insert(returnString, value['convar'] .. ": " .. value['maxlimit'])
	end
	
	return returnString
end


--- Gives a group a different limit to a specific gmod limit. Returns a string array.
function limitSet( usergroup, convar, limit )
	local returnString = {}
	limit = math.floor(limit + 0.5)
	
	if sqlWriteLimitEntry(usergroup, convar, limit) then
		table.insert(returnString, "Changed limit of gmod limit " .. convar .. " to " .. limit .. " on group " .. usergroup .. ".")
	else
		table.insert(returnString, "Error - Unhandled error while setting limit!")
	end
	
	return returnString
end


--- Removes a gmod limit from a group. Returns a string array.
function limitRemove( usergroup, convar )
	local returnString = {}
	
	if sqlSelectLimitEntry(usergroup, convar) == nil then
		if convar != nil then
			table.insert(returnString, "Error - Usergroup " .. usergroup .. " doesn't have limit " .. convar .. "!")
		else				
			table.insert(returnString, "Error - Usergroup " .. usergroup .. " doesn't have any limits!")
		end
		return returnString
	end
	
	if sqlDeleteLimitEntry(usergroup, convar) then
		if convar != nil then
			table.insert(returnString, "Removed limit " .. convar .. " from group " .. usergroup .. ".")
		else
			table.insert(returnString, "Removed limit all limits from group " .. usergroup .. ".")
		end
	else
		table.insert(returnString, "Error - Unhandled error while removing limit!")
	end
	
	return returnString
end


--- Validates if the specified prop is allowed to spawn by the player, using the global convar limit. Returns a boolean.
function limitDefault( ply, convar )
	entityType = string.sub(convar, 9)
	defaultlimit = server_settings.Int(convar, 0)
	if ply:GetCount(entityType) < defaultlimit or defaultlimit < 0 then 
		return true
	else
		ply:LimitHit(entityType)
		return false
	end
end


--- Validates if the specified prop is allowed to spawn by the player, using WLC's limits. Returns a boolean.
function limitValidate( ply, convar )	
	entityType = string.sub(convar, 9)
	usergroups = sqlSelectLimitUsergroups()
	
	if usergroups != nil then
		for key, value in pairs( usergroups ) do
			if team.GetName(ply:Team()) == value['usergroup'] then 
				limitEntry = sqlSelectLimitEntry(value['usergroup'], convar)
				
				if limitEntry != nil then
					limit = tonumber(limitEntry[1]['maxlimit'])

					if ply:GetCount(entityType) < limit or limit < 0 then 
						return true
					else
						ply:LimitHit(entityType)
						return false
					end
				end
			end
		end
	end
	
	return limitDefault( ply, convar )
end




-- List with all players and their next spawntime.
local spamPlayerList = {}
-- List with the tools that are allowed to spam entities.
local spamToolExceptions = {}  
table.insert(spamToolExceptions, "ol_stacker")  
table.insert(spamToolExceptions, "adv_duplicator") 


-- The time in milliseconds (1s = 1000ms) between spawning an entity.
CreateConVar( "wlc_spawnrate", "50000", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
--- Returns an integer.  
function spamSpawnRate()  
	return GetConVar("wlc_spawnrate"):GetInt()  
end 


--- Adds a player to the list.
function spamPlayerAdd( ply )
	table.insert(spamPlayerList, ply:UserID(), spamTimeInMilliseconds())
end
-- Calls spamPlayerAdd.
hook.Add( "PlayerInitialSpawn", "wlcSpamPlayerInitialSpawn", spamPlayerAdd )


--- Removes a player from the list.
function spamPlayerRemove( ply )
	table.remove(spamPlayerList, ply:UserID())
end
-- Calls spamPlayerRemove.
hook.Add( "PlayerDisconnected", "wlcSpamPlayerDisconnected", spamPlayerRemove )


--- Returns the current time in milliseconds.
function spamTimeInMilliseconds()
	return math.floor(RealTime() * 1000 + 0.5)
end


--- Validates if the specified player is allowed to spawn something. Returns a boolean.
function spamValidate( ply )
	PrintTable(spamPlayerList)
	if (spamPlayerList[ply:UserID()] + spamSpawnRate()) < spamTimeInMilliseconds() then
		spamPlayerList[ply:UserID()] = spamTimeInMilliseconds()
		return true
	else
		return false
	end
end




--- Add hooks so we can manage limits.
function hookInitialize()
	function GAMEMODE:PlayerSpawnRagdoll( ply, model )
		if !utilEnabled() then
			return limitDefault( ply, convar )
		end
	
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxragdolls" )
		else
			return false
		end
	end

	function GAMEMODE:PlayerSpawnProp( ply, model )
		if !utilEnabled() then
			return limitDefault( ply, convar )
		end
	
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxprops" )
		else
			return false
		end
	end

	function GAMEMODE:PlayerSpawnEffect( ply, model )
		if !utilEnabled() then
			return limitDefault( ply, convar )
		end
	
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxeffects" )
		else
			return false
		end
	end

	function GAMEMODE:PlayerSpawnVehicle( ply )
		if !utilEnabled() then
			return limitDefault( ply, convar )
		end
	
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxvehicles" )
		else
			return false
		end
	end

	-- function GAMEMODE:PlayerSpawnSENT( ply, name )
		-- if !utilEnabled() then
			-- return limitDefault( ply, convar )
		-- end
	
		-- if spamValidate( ply ) then
			-- return limitValidate( ply, "sbox_maxsents" )
		-- else
			-- return false
		-- end
	-- end

	function GAMEMODE:PlayerSpawnNPC( ply, npc_type, equipment )
		if !utilEnabled() then
			return limitDefault( ply, convar )
		end
	
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxnpcs" )
		else
			return false
		end
	end
end
hook.Add( "Initialize", "wlcHookInitialize", hookInitialize )