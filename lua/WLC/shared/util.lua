--[[
	Title: Utilities
 
	Holds helpful utility functions.
]]


--- Returns a string array with all known groups.
function utilGroupsList()
	local groupsList = {}
	
	if false then
		for key, value in pairs( team.GetAllTeams() ) do
			if key != 0 and key != 1001 and key != 1002 then
				table.insert(groupsList, key, value['Name'])
			end
		end
	else
		table.insert(groupsList, "superadmin")
		table.insert(groupsList, "admin")
		table.insert(groupsList, "user")
	end
	
	return groupsList
end


--- Checks if the group exists. Returns a boolean.
function utilGroupExists( input )
	for key, value in pairs( utilGroupsList() ) do
		if value == input then
			return true
		end
	end
	
	return false
end


--- Returns a string array with all known weapon classnames.
function utilWeaponsList()
	local weaponsList = {}
	table.insert(weaponsList, "weapon_crowbar")
	table.insert(weaponsList, "weapon_physcannon")
	table.insert(weaponsList, "weapon_physgun")
	table.insert(weaponsList, "weapon_pistol")
	table.insert(weaponsList, "weapon_357")
	table.insert(weaponsList, "weapon_smg1")
	table.insert(weaponsList, "weapon_ar2")
	table.insert(weaponsList, "weapon_shotgun")
	table.insert(weaponsList, "weapon_crossbow")
	table.insert(weaponsList, "weapon_frag")
	table.insert(weaponsList, "weapon_rpg")
	table.insert(weaponsList, "weapon_stunstick")
	table.insert(weaponsList, "weapon_slam")
	table.insert(weaponsList, "weapon_bugbait")
	table.insert(weaponsList, "weapon_annabelle")
	table.insert(weaponsList, "item_ml_grenade")
	table.insert(weaponsList, "item_ar2_grenade")
	table.insert(weaponsList, "item_ammo_ar2_altfire")
	table.insert(weaponsList, "item_healthkit")
	table.insert(weaponsList, "item_healthvial")
	table.insert(weaponsList, "item_suit")
	table.insert(weaponsList, "item_battery")
	for key, value in pairs(weapons.GetList()) do 
		table.insert(weaponsList, value['ClassName']) 
	end

	return weaponsList
end


--- Returns a string array with all supported weapon classnames.
function utilWeaponsListSupported()
	local weaponsList = {}
	table.insert(weaponsList, "weapon_crowbar")
	table.insert(weaponsList, "weapon_physcannon")
	table.insert(weaponsList, "weapon_physgun")
	table.insert(weaponsList, "weapon_pistol")
	table.insert(weaponsList, "weapon_357")
	table.insert(weaponsList, "weapon_smg1")
	table.insert(weaponsList, "weapon_ar2")
	table.insert(weaponsList, "weapon_shotgun")
	table.insert(weaponsList, "weapon_crossbow")
	table.insert(weaponsList, "weapon_frag")
	table.insert(weaponsList, "weapon_rpg")
	table.insert(weaponsList, "weapon_stunstick")
	
	return weaponsList
end


--- Validates if a weapon exists. Returns a boolean.
function utilWeaponExists( weaponClass )
	for key, value in pairs( utilWeaponsList() ) do
		if value == weaponClass then
			return true
		end
	end
	return false
end


--- Validates if a weapon is supported by WLC. Returns a boolean.
function utilWeaponSupported( weaponClass )
	if table.HasValue(utilWeaponsListSupported(), weaponClass) then
		return true
	else
		return false
	end
end


--- Returns a string array with a list of convars.
function utilLimitsListSupported()
	local convarList = {}
	table.insert(convarList, "sbox_maxeffects")
	table.insert(convarList, "sbox_maxnpcs")
	-- table.insert(convarList, "sbox_maxsents")
	table.insert(convarList, "sbox_maxprops")
	table.insert(convarList, "sbox_maxragdolls")
	table.insert(convarList, "sbox_maxvehicles")

	return convarList
end


--- Validates if a gmod limit exists. Returns a boolean.
function utilLimitExists( convar )
	return GetConVar(convar) != nil
end


--- Validates if a gmod limit is supported by WLC. Returns a boolean.
function utilLimitSupported( convar )
	return table.HasValue(utilLimitsListSupported(), convar)
end


--- Returns help about all commands or a specific command. Returns a string array.
function utilHelp( ply, command )
	local returnString = {}
		
	if command != nil then
		if command == "help" then
			table.insert(returnString, "No help available yet.")
		elseif command == "check" then
			table.insert(returnString, "No help available yet.")
		elseif command == "restrictweapon" then
			table.insert(returnString, "No help available yet.")
		elseif command == "unrestrictweapon" then
			table.insert(returnString, "No help available yet.")
		elseif command == "setlimit" then
			table.insert(returnString, "No help available yet.")
		elseif command == "removelimit" then
			table.insert(returnString, "No help available yet.")
		elseif ply:IsValid() and command == "gui" then
			table.insert(returnString, "No help available yet.")
		elseif not ply:IsValid() and command == "cleardb" then
			table.insert(returnString, "No help available yet.")
		else
			table.insert(returnString, "Invalid command!")
			table.insert(returnString, "Type 'wlc help' to see a list of all available commands.")
		end
	else
		table.insert(returnString, "\n\rAvailable commands:\n\r")
		
		table.insert(returnString, "wlc help [[command]]")
		table.insert(returnString, "Example: wlc help check")
		table.insert(returnString, "Description: Shows a description and examples about the provided command, or all commands if none provided.\n\r")
		
		table.insert(returnString, "wlc check [group]")
		table.insert(returnString, "Example: wlc check superadmin")
		table.insert(returnString, "Description: Shows the restrictions and limits active on the group.\n\r")
		
		table.insert(returnString, "wlc restrictweapon [group] [weapon]")
		table.insert(returnString, "Example: wlc restrictweapon user weapon_psyscannon") 
		table.insert(returnString, "Description: Denies a group to spawn the provided weapon.\n\r")
		
		table.insert(returnString, "wlc unrestrictweapon [group] [[weapon]]")
		table.insert(returnString, "Example: wlc unrestrictweapon moderator weapon_crowbar")
		table.insert(returnString, "Description: Unrestricts the provided weapon, or all restricted weapons if no weapon is specified.\n\r")
		
		table.insert(returnString, "wlc setlimit [group] [convar] [newlimit]")
		table.insert(returnString, "Example: wlc setlimit admin sbox_maxnpcs 10")
		table.insert(returnString, "Description: Sets an new limit for the provided convar. Use -1 for unlimited.\n\r")
		
		table.insert(returnString, "wlc removelimit [group] [[convar]]")
		table.insert(returnString, "Example: wlc removelimit admin sbox_maxnpcs")
		table.insert(returnString, "Description: Removes the limit set for the provided convar, or all limits if no convar is specified.\n\r")
		
		if ply:IsValid() then
			table.insert(returnString, "wlc gui")
			table.insert(returnString, "Example: wlc gui")
			table.insert(returnString, "Description: Shows the Graphical User Interface.\n\r")
		else
			table.insert(returnString, "wlc cleardb")
			table.insert(returnString, "Example: wlc cleardb")
			table.insert(returnString, "Description: Removes all restrictions/limits.\n\r")
		end
	end
		
	return returnString
end


-- function math.round(num, idp)
  -- if idp and idp>0 then
    -- local mult = 10^idp
    -- return math.floor(num * mult + 0.5) / mult
  -- end
  -- return math.floor(num + 0.5)
-- end