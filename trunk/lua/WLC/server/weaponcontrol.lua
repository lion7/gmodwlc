--[[
	Title: WeaponControl
	
	Holds functions to control the weapons.
]]


--- Checks the weapon restrictions of a group. Returns a string array.
function wcCheckWeapons( usergroup )
	local returnString = {}
	weaponsEntry = sqlSelectWeaponsEntry(usergroup, nil)
	
	if weaponsEntry == nil then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't have any weapon(s) restricted.")
		return returnString
	end
	
	table.insert(returnString, "Usergroup " .. usergroup .. " has the following weapon(s) restricted:")
	for key, value in pairs( weaponsEntry ) do
		table.insert(returnString, value['weapon'])
	end
	
	return returnString
end


--- Denies a group to have access to a weapon. Returns a string array.
function wcRestrictWeapon( usergroup, weapon )
	local returnString = {}
	
	if utilTeamExists(usergroup) == false then
		table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't exist!")
		return returnString
	end
	
	if wcWeaponExists(weapon) == false then	
		table.insert(returnString, "Error: Weapon " .. weapon .. " doesn't exist!")
		return returnString
	end
	
	if wcWeaponSupported(weapon) == false then	
		table.insert(returnString, "Error: Weapon " .. weapon .. " isn't supported (yet)!")
		table.insert(returnString, "Currently the following weapons are supported:")
		table.Add(returnString, utilWeaponsList2())
		return returnString
	end
	
	if sqlSelectWeaponsEntry(usergroup, weapon) != nil then
		table.insert(returnString, "Error: Usergroup " .. usergroup .. " already has weapon " .. weapon .. " restricted!")
		return returnString
	end
	
	if sqlWriteWeaponsEntry(usergroup, weapon) then
		table.insert(returnString, "Restricted weapon " .. weapon .. " for group " .. usergroup .. ".")
	else
		table.insert(returnString, "Error: Unhandled error while restricting weapon!")
	end
	
	return returnString
end

--- Removes all weapon restrictions of a group. Returns a string array.
function wcUnrestrictWeapon( usergroup, weapon )
	local returnString = {}
	
	if sqlSelectWeaponsEntry(usergroup, weapon) == nil then
		if weapon != nil then
			table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't have weapon " .. weapon .. " restricted!")
		else				
			table.insert(returnString, "Error: Usergroup " .. usergroup .. " doesn't have any weapon(s) restricted!")
		end
	end
	
	if sqlDeleteWeaponsEntry(usergroup, weapon) then
		if weapon != nil then			
			table.insert(returnString, "Unrestricted weapon " .. weapon .. " for group " .. usergroup .. ".")
		else				
			table.insert(returnString, "Unrestricted all weapons for group " .. usergroup .. ".")
		end
	else
		table.insert(returnString, "Error: Unhandled error while unrestricting weapon(s)!")
	end
	
	return returnString
end


--- Validates if a weapon exists. Returns a boolean.
function wcWeaponExists( weaponClass )
	for key, value in pairs( utilWeaponsList() ) do
		if value == weaponClass then
			return true
		end
	end
	return false
end


--- Validates if a weapon is supported by WLC. Returns a boolean.
function wcWeaponSupported( weaponClass )
	if table.HasValue(utilWeaponsList2(), weaponClass) then
		return true
	else
		return false
	end
end


--- Validates if the specified weapon is allowed for the player's usergroup. Returns a boolean.
function wcValidateWeapon( ply, weapon )
	if ply:IsValid() then
		weaponClass = weapon:GetClass()
		usergroups = sqlSelectWeaponsUsergroups()
		
		if usergroups != nil then
			for key, value in pairs( usergroups ) do
				if team.GetName(ply:Team()) == value['usergroup'] then 
					weaponsEntry = sqlSelectWeaponsEntry(value['usergroup'], weaponClass)
					
					if weaponsEntry != nil then
						return false
					else
						return true
					end
				end
			end
		end
		
		return convarDefaultAction()
	else
		return false
	end
end