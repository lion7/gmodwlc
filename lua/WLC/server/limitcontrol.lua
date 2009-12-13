--[[
	Title: LimitControl

	Holds functions to control the spawn limits.
]]


--- Gives a group a different limit to a specific gmod limit. Returns a string.
function lcSetLimit( convar, limit, usergroup )
	-- if lcGmodLimitExists(convar) then
		if sqlWriteLimitEntry(usergroup, convar, limit) then
			return "Changed limit of gmod limit " .. convar .. " to " .. limit .. " on group " .. usergroup .. "."
		else		
			return "Unhandled error while setting limit!"
		end
	-- else
		-- return "Invalid gmod limit while setting limit!"
	-- end
end

function lcRemoveLimit( convar, usergroup )
	if sqlSelectLimitEntry(usergroup, convar) != nil then
		if sqlDeleteLimitEntry(usergroup, convar) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- --- Validates if a gmod limit exists. Returns a boolean.
-- function lcGmodLimitExists( convar )
	-- return true
-- end

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
