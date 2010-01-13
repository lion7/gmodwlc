--[[
	Title: LimitControl

	Holds functions to control the spawn limits.
]]


--- Checks all limits of a group. Returns a string.
function lcCheckLimit( usergroup )
	limitEntry = sqlSelectLimitEntry(usergroup)
	if limitEntry != nil then
		returnString = "Usergroup " .. usergroup .. " has the following limits:\n"
		for key, value in pairs( limitEntry ) do
			returnString = returnString .. value['convar'] .. ": " .. value['maxlimit'] .. "\n"
		end
		return returnString
	else
		return "Usergroup " .. usergroup .. " doesn't have any limits.\n"
	end
end

--- Gives a group a different limit to a specific gmod limit. Returns a string.
function lcSetLimit( usergroup, convar, limit )
	if lcGmodLimitExists(convar) then
		if sqlWriteLimitEntry(usergroup, convar, limit) then
			return "Changed limit of gmod limit " .. convar .. " to " .. limit .. " on group " .. usergroup .. "."
		else		
			return "Unhandled error while setting limit!"
		end
	else
		return "Gmod limit " .. convar .. " doesn't exist!"
	end
end

--- Removes a gmod limit from a group. Returns a string.
function lcRemoveLimit( usergroup, convar )
	if sqlSelectLimitEntry(usergroup, convar) != nil then
		if sqlDeleteLimitEntry(usergroup, convar) then
			if convar == nil then
				return "Removed limit all limits from group " .. usergroup .. "."
			else
				return "Removed limit " .. convar .. " from group " .. usergroup .. "."
			end
		else
			if convar == nil then
				return "Usergroup " .. usergroup .. " does not have any limits."
			else				
				return "Usergroup " .. usergroup .. " does not have limit " .. convar .. "."
			end
		end
	else
		return false
	end
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

--- Validates if the specified prop is allowed to spawn by the player.
function lcValidateLimit( player, convar )
	if player:IsValid() then		
		entityType = string.sub(convar, 9)
		usergroups = sqlSelectLimitUsergroups()
		if usergroups != nil then
			for key, value in pairs( usergroups ) do
				if player:IsUserGroup(value['usergroup']) then 
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
		
		return true
	else
		return false
	end
end
