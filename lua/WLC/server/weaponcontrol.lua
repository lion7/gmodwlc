--[[
	Title: WeaponControl
	
	Holds functions to control the weapons.
]]


--- Checks the weapon restrictions of a group. Returns a string array.
function wcCheckWeapons( usergroup )
	returnString = {}

	weaponsEntry = sqlSelectWeaponsEntry(usergroup)
	if weaponsEntry != nil then
		weaponsWhitelist = weaponsEntry[1]['whitelist']
		if weaponsWhitelist then
			listtype = "whitelisted"
		else
			listtype = "blacklisted"
		end
		table.insert(returnString, "Usergroup " .. usergroup .. " has the following weapons " .. listtype .. ":")
		weaponsList = string.Explode( ",", weaponsEntry[1]['weapons'] )
		for key, value in pairs( weaponsList ) do
			table.insert(returnString, value)
		end
	else
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't have any weapon restrictions!")
	end
	
	return returnString
end

--- Allows a group to have access to a set of weapons. Returns a string array.
function wcWhitelistWeapons( usergroup, weapons )
	returnString = {}
	
	if utilUsergroupExists(usergroup) == false then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	weaponsList = string.Explode( ",", weapons )
	for key, value in pairs( weaponsList ) do
		if wcWeaponExists(value) == false then
			table.insert(returnString, "Weapon " .. value .. " doesn't exist!")
			return returnString
		end
	end
	
	if sqlWriteWeaponsEntry(usergroup, weapons, true) then
		table.insert(returnString, "Whitelisted weapon(s) " .. weapons .. " for group " .. usergroup .. ".")
	else
		table.insert(returnString, "Unhandled error while whitelisting weapon(s)!")
	end
	
	return returnString
end

--- Denies a group to have access to a set of weapons. Returns a string array.
function wcBlacklistWeapons( usergroup, weapons )
	returnString = {}
	
	if utilUsergroupExists(usergroup) == false then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	weaponsList = string.Explode( ",", weapons )
	for key, value in pairs( weaponsList ) do
		if wcWeaponExists(value) == false then
			table.insert(returnString, "Weapon " .. value .. " doesn't exist!")
			return returnString
		end
	end
	
	if sqlWriteWeaponsEntry(usergroup, weapons, false) then
		table.insert(returnString, "Blacklisted weapon(s) " .. weapons .. " for group " .. usergroup .. ".")
	else
		table.insert(returnString, "Unhandled error while blacklisting weapon(s)!")
	end
	
	return returnString
end

--- Removes all weapon restrictions of a group. Returns a string array.
function wcUnlistUsergroup( usergroup )
	returnString = {}
	
	if sqlSelectWeaponsEntry(usergroup) != nil then
		if sqlDeleteWeaponsEntry(usergroup) then
			table.insert(returnString, "Removed weapon restrictions for group " .. usergroup .. ".")
		else
			table.insert(returnString, "Unhandled error while unlisting usergroup!")
		end
	else
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't have any weapon restrictions!")
	end
	
	return returnString
end

--- Validates if a weapon exists. Returns a boolean.
function wcWeaponExists( weaponclass )
	return true
	-- if table.HasValue(weapons.GetList(), weaponclass) then
		-- return true
	-- else
		-- return false
	-- end 
end

--- Validates if the specified weapon is allowed for the player's usergroup. Returns a boolean.
function wcValidateWeapon( player, weapon )
	if player:IsValid() then	
		usergroups = sqlSelectWeaponsUsergroups()
		if usergroups != nil then
			for key, value in pairs( usergroups ) do
				if team.GetName(player:Team()) == value['usergroup'] then 
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