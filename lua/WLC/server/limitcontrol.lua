--[[
	Title: LimitControl

	Holds functions to control the spawn limits.
]]


--- Checks all limits of a group. Returns a string array.
function lcCheckLimits( usergroup )
	local returnString = {}
	
	limitEntry = sqlSelectLimitEntry(usergroup)
	if limitEntry != nil then
		table.insert(returnString, "Usergroup " .. usergroup .. " has the following limits:")
		for key, value in pairs( limitEntry ) do
			table.insert(returnString, value['convar'] .. ": " .. value['maxlimit'])
		end
	else
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't have any limits.")
	end
	
	return returnString
end

--- Gives a group a different limit to a specific gmod limit. Returns a string array.
function lcSetLimit( usergroup, convar, limit )
	local returnString = {}
	limit = math.floor(limit + 0.5)
	
	if utilUsergroupExists(usergroup) == false then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	print("sqlWriteLimitEntry("..usergroup..", "..convar..", "..limit.."):"..tostring(sqlWriteLimitEntry(usergroup, convar, limit)))
	
	if lcGmodLimitExists(convar) then
		if sqlWriteLimitEntry(usergroup, convar, limit) then
			table.insert(returnString, "Changed limit of gmod limit " .. convar .. " to " .. limit .. " on group " .. usergroup .. ".")
		else
			table.insert(returnString, "Unhandled error while setting limit!")
		end
	else
		table.insert(returnString, "Gmod limit " .. convar .. " doesn't exist!")
	end
	
	return returnString
end

--- Removes a gmod limit from a group. Returns a string array.
function lcRemoveLimit( usergroup, convar )
	local returnString = {}
	
	if utilUsergroupExists(usergroup) == false then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	if sqlSelectLimitEntry(usergroup, convar) != nil then
		if sqlDeleteLimitEntry(usergroup, convar) then
			if convar == nil then
				table.insert(returnString, "Removed limit all limits from group " .. usergroup .. ".")
			else
				table.insert(returnString, "Removed limit " .. convar .. " from group " .. usergroup .. ".")
			end
		else
			table.insert(returnString, "Unhandled error while removing limit!")
		end
	else
		if convar == nil then
			table.insert(returnString, "Usergroup " .. usergroup .. " does not have any limits.")
		else				
			table.insert(returnString, "Usergroup " .. usergroup .. " does not have limit " .. convar .. ".")
		end
	end
	
	return returnString
end

--- Validates if a gmod limit exists. Returns a boolean.
function lcGmodLimitExists( convar )
	convarValue = GetConVar(convar)
	if convarValue == nil then
		return false
	else
		return true
	end
end

--- Validates if the specified prop is allowed to spawn by the player. Returns a boolean.
function lcValidateLimit( player, convar )
	if player:IsValid() then		
		entityType = string.sub(convar, 9)
		usergroups = sqlSelectLimitUsergroups()
		if usergroups != nil then
			for key, value in pairs( usergroups ) do
				if team.GetName(player:Team()) == value['usergroup'] then 
					limitEntry = sqlSelectLimitEntry(value['usergroup'], convar)
					limit = tonumber(limitEntry[1]['maxlimit'])

					if player:GetCount(entityType) < limit or limit < 0 then 
						return true
					else
						player:LimitHit(entityType)
						return false
					end
				end
			end
		end
						
		defaultlimit = server_settings.Int(convar, 0)
		if player:GetCount(entityType) < defaultlimit or defaultlimit < 0 then 
			return true
		else
			player:LimitHit(entityType)
			return false
		end
		
		return utilDefaultAction()
	else
		return false
	end
end
