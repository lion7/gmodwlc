--[[
	Title: ControlWeapons
	
	Holds functions to control the weapons.
]]


--- Checks the weapon restrictions of a group. Returns a string array.
function weaponCheck( usergroup )
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
function weaponRestrict( usergroup, weapon )
	local returnString = {}

	if sqlSelectWeaponsEntry(usergroup, weapon) != nil then
		table.insert(returnString, "Error - Usergroup " .. usergroup .. " already has " .. weapon .. " restricted!")
		return returnString
	end
	
	if sqlWriteWeaponsEntry(usergroup, weapon) then
		table.insert(returnString, "Restricted weapon " .. weapon .. " for group " .. usergroup .. ".")
	else
		table.insert(returnString, "Error - Unhandled error while restricting weapon!")
	end
	
	return returnString
end


--- Removes the weapon restriction(s) of a group. Returns a string array.
function weaponUnrestrict( usergroup, weapon )
	local returnString = {}
	
	if sqlSelectWeaponsEntry(usergroup, weapon) == nil then
		if weapon != nil then
			table.insert(returnString, "Error - Usergroup " .. usergroup .. " doesn't have " .. weapon .. " restricted!")
		else				
			table.insert(returnString, "Error - Usergroup " .. usergroup .. " doesn't have any weapon(s) restricted!")
		end
	end
	
	if sqlDeleteWeaponsEntry(usergroup, weapon) then
		if weapon != nil then			
			table.insert(returnString, "Unrestricted " .. weapon .. " for group " .. usergroup .. ".")
		else				
			table.insert(returnString, "Unrestricted all weapons for group " .. usergroup .. ".")
		end
	else
		table.insert(returnString, "Error - Unhandled error while unrestricting weapon(s)!")
	end
	
	return returnString
end


--- Validates if the specified weapon is allowed for the player's group. Returns a boolean.
function weaponValidate( ply, weapon )
	if ply:IsValid() then
		weaponClass = weapon:GetClass()
		
		if false then
			weaponsEntry = sqlSelectWeaponsEntry(team.GetName(ply:Team()), weaponClass)
		else
			usergroups = sqlSelectWeaponsUsergroups()		
			if usergroups != nil then
				for key, value in pairs( usergroups ) do
					if ply:IsUserGroup(value['usergroup']) then 
						weaponsEntry = sqlSelectWeaponsEntry(value['usergroup'], weaponClass)
					end
				end
			end
		end
				
		if weaponsEntry != nil then
			return false
		else
			return convarDefaultAction()
		end
	else
		return false
	end
end