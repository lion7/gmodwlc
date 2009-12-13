--[[
	Title: WeaponControl
	
	Holds functions to control the weapons.
]]


--- Allows a group to have access to a set of weapons. Returns a string.
function wcWhitelistWeapons( weapons, usergroup )
	if sqlWriteWeaponsEntry(usergroup, weapons, true) then
		return "Whitelisted weapon(s) " .. weapons .. " for group " .. usergroup .. "."
	else
		return "Unhandled error while whitelisting weapon(s)!"
	end
end

--- Denies a group to have access to a set of weapons. Returns a string.
function wcBlacklistWeapons( weapons, usergroup ) 
	if sqlWriteWeaponsEntry(usergroup, weapons, false) then
		return "Blacklisted weapon(s) " .. weapons .. " for group " .. usergroup .. "."
	else
		return "Unhandled error while blacklisting weapon(s)!"
	end
end

function wcUnlistUsergroup( usergroup )
	if sqlSelectWeaponsEntry(usergroup) != nil then
		if sqlDeleteWeaponsEntry(usergroup) then
			return true
		else
			return false
		end
	else
		return false
	end
end

--- Validates if the specified weapon is allowed for the player's usergroup.
function wcValidateWeapon( player, weapon )
	if player:IsValid() then	
		usergroups = sqlSelectWeaponsUsergroups()
		if usergroups != nil then
			for key, value in pairs( usergroups ) do
				if player:IsUserGroup(value['usergroup']) then 
					weaponsEntry = sqlSelectWeaponsEntry(value['usergroup'])
					weaponsList = string.Explode( ",", weaponsEntry[1]['weapons'] )
					weaponsWhitelist = weaponsEntry[1]['whitelist']
					
					if table.HasValue(weaponsList, weapon:GetClass()) then
						if weaponsWhitelist then
							return true
						else
							return false
						end
					else
						if weaponsWhitelist then
							return false
						else
							return true
						end
					end
				end
			end
		end
		
		return true
	else
		return false
	end
end