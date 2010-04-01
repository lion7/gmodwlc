--[[
	Title: LimitControl

	Holds functions to control the spawn limits.
]]


--- Checks all limits of a group. Returns a string array.
function lcCheckLimits( usergroup )
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
function lcSetLimit( usergroup, convar, limit )
	local returnString = {}
	limit = math.floor(limit + 0.5)
	
	if utilTeamExists(usergroup) == false then
		table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	if lcGmodLimitExists(convar) == false then
		table.insert(returnString, "Error: Gmod limit " .. convar .. " doesn't exist!")
		return returnString
	end
	
	if lcGmodLimitSupported(convar) == false then
		table.insert(returnString, "Error: Gmod limit " .. convar .. " isn't supported (yet)!")
		table.insert(returnString, "Currently the following limits are supported:")
		table.Add(returnString, utilConvarListSupported())
		return returnString
	end
	
	if sqlWriteLimitEntry(usergroup, convar, limit) then
		table.insert(returnString, "Changed limit of gmod limit " .. convar .. " to " .. limit .. " on group " .. usergroup .. ".")
	else
		table.insert(returnString, "Error: Unhandled error while setting limit!")
	end
	
	return returnString
end


--- Removes a gmod limit from a group. Returns a string array.
function lcRemoveLimit( usergroup, convar )
	local returnString = {}
	
	if utilTeamExists(usergroup) == false then
		table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	if sqlSelectLimitEntry(usergroup, convar) == nil then
		if convar != nil then
			table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't have limit " .. convar .. "!")
		else				
			table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't have any limits!")
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
		table.insert(returnString, "Error: Unhandled error while removing limit!")
	end
	
	return returnString
end


--- Validates if a gmod limit exists. Returns a boolean.
function lcGmodLimitExists( convar )
	return GetConVar(convar) != nil
end


--- Validates if a gmod limit is supported by WLC. Returns a boolean.
function lcGmodLimitSupported( convar )
	return table.HasValue(utilConvarListSupported(), convar)
end


--- Validates if the specified prop is allowed to spawn by the player. Returns a boolean.
function lcValidateLimit( ply, convar )
	if !convarEnabled() then
		return lcDefaultValidateLimit( ply, convar )
	end
	
	if ply:GetActiveWeapon()['ClassName'] == "gmod_tool" then		
		if scValidateTool(ply:GetTool()['Mode']) then
			return lcDefaultValidateLimit( ply, convar )
		end
	end
	
	if !scValidateTime( ply ) then
		ply:LimitHit("spawnrate")
		return false
	end
	
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
	
	if convarDefaultAction() then
		return lcDefaultValidateLimit( ply, convar )
	else
		ply:LimitHit(entityType)
		return false
	end
end


--- Validates if the specified prop is allowed to spawn by the player, using the global convar limit. Returns a boolean.
function lcDefaultValidateLimit( ply, convar )
	entityType = string.sub(convar, 9)
	defaultlimit = server_settings.Int(convar, 0)
	if ply:GetCount(entityType) < defaultlimit or defaultlimit < 0 then 
		return true
	else
		ply:LimitHit(entityType)
		return false
	end
end