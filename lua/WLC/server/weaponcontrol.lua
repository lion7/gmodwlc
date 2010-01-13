--[[
	Title: WeaponControl
	
	Holds functions to control the weapons.
]]


--- Checks the weapon restrictions of a group. Returns a string.
function wcCheckWeapons( usergroup )
	weaponsEntry = sqlSelectWeaponsEntry(usergroup)
	if weaponsEntry != nil then
		weaponsWhitelist = weaponsEntry[1]['whitelist']
		if weaponsWhitelist then
			listtype = "whitelisted"
		else
			listtype = "blacklisted"
		end
		returnString = "Usergroup " .. usergroup .. " has the following weapons " .. listtype .. ":\n"
		weaponsList = string.Explode( ",", weaponsEntry[1]['weapons'] )
		for key, value in pairs( weaponsList ) do
			returnString = returnString .. value .. "\n"
		end
		return returnString
	else
		return "Usergroup doesn't have any weapon restrictions!\n"
	end
end

--- Allows a group to have access to a set of weapons. Returns a string.
function wcWhitelistWeapons( usergroup, weapons )
	weaponsList = string.Explode( ",", weapons )
	for key, value in pairs( weaponsList ) do
		if wcWeaponExists(value) == false then
			return "Weapon " .. value .. " doesn't exist!"
		end
	end
	if sqlWriteWeaponsEntry(usergroup, weapons, true) then
		return "Whitelisted weapon(s) " .. weapons .. " for group " .. usergroup .. "."
	else
		return "Unhandled error while whitelisting weapon(s)!"
	end
end

--- Denies a group to have access to a set of weapons. Returns a string.
function wcBlacklistWeapons( usergroup, weapons ) 
	if sqlWriteWeaponsEntry(usergroup, weapons, false) then
		return "Blacklisted weapon(s) " .. weapons .. " for group " .. usergroup .. "."
	else
		return "Unhandled error while blacklisting weapon(s)!"
	end
end

--- Removes all weapon restrictions of a group. Returns a string.
function wcUnlistUsergroup( usergroup )
	if sqlSelectWeaponsEntry(usergroup) != nil then
		if sqlDeleteWeaponsEntry(usergroup) then
			return "Removed weapon restrictions for group " .. usergroup .. "."
		else
			return "Unhandled error while unlisting usergroup!"
		end
	else
		return false
	end
end

--- Validates if a weapon exists. Returns a boolean.
function wcWeaponExists( weapon )
	if table.HasValue(weapons.GetList(), weapon) then
		return true
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
						if weaponsWhitelist == true then
							return true
						else
							return false
						end
					else
						if weaponsWhitelist == true then
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