--[[
	Title: ControlWeapons
	
	Holds functions to control the weapons.
]]


--- Checks the weapon(s) that a group has listed. Returns a string array.
function weaponCheck( usergroup )
	local returnString = {}
	weaponsEntry = sqlSelectWeaponEntry(usergroup, nil)
	
	if weaponsEntry == nil then
		table.insert(returnString, "Usergroup " .. usergroup .. " doesn't have any weapon(s) listed.")
		return returnString
	end
	
	table.insert(returnString, "Usergroup " .. usergroup .. " has the following weapon(s) listed:")
	for key, value in pairs( weaponsEntry ) do
		table.insert(returnString, value['weapon'])
	end
	
	return returnString
end


--- Adds a new weaponentry. Returns a string array. -- TODO: Make this proper english :p.
function weaponAdd( usergroup, weapon )
	local returnString = {}

	if sqlSelectWeaponEntry(usergroup, weapon) != nil then
		table.insert(returnString, "Error - Usergroup " .. usergroup .. " already has " .. weapon .. " listed!")
		return returnString
	end
	
	if sqlWriteWeaponsEntry(usergroup, weapon) then
		table.insert(returnString, "Added weapon " .. weapon .. " for group " .. usergroup .. ".") -- TODO: Make this proper english :p.
	else
		table.insert(returnString, "Error - Unhandled error while listing weapon!")
	end
	
	return returnString
end


--- Removes a weaponentry. Returns a string array.
function weaponRemove( usergroup, weapon )
	local returnString = {}
	
	if sqlSelectWeaponEntry(usergroup, weapon) == nil then
		if weapon != nil then
			table.insert(returnString, "Error - Usergroup " .. usergroup .. " doesn't have " .. weapon .. " listed!")
		else				
			table.insert(returnString, "Error - Usergroup " .. usergroup .. " doesn't have any weapon(s) listed!")
		end
	end
	
	if sqlDeleteWeaponEntry(usergroup, weapon) then
		if weapon != nil then			
			table.insert(returnString, "Removed " .. weapon .. " for group " .. usergroup .. ".") -- TODO: Make this proper english :p.
		else				
			table.insert(returnString, "Removed all weapons for group " .. usergroup .. ".")
		end
	else
		table.insert(returnString, "Error - Unhandled error while unlisting weapon(s)!")
	end
	
	return returnString
end


--- Validates if the specified weapon is allowed for the player's group. Returns a boolean.
function weaponValidate( ply, weapon )
	if ply:IsValid() then
		weaponClass = weapon:GetClass()
		
		if false then
			weaponsEntry = sqlSelectWeaponEntry(team.GetName(ply:Team()), weaponClass)
		else
			usergroups = sqlSelectWeaponUsergroups()		
			if usergroups != nil then
				for key, value in pairs( usergroups ) do
					if ply:IsUserGroup(value['usergroup']) then 
						weaponsEntry = sqlSelectWeaponEntry(value['usergroup'], weaponClass)
					end
				end
			end
		end
		
		if weaponsEntry != nil then
			return convarWeaponsAction()
		else
			return not convarWeaponsAction()
		end
	else
		return false
	end
end