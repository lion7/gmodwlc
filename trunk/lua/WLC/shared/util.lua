--[[
	Title: Utilities
 
	Holds helpful utility functions.
]]


--- Returns a string array with all known groups.
function utilGroupList()
	local groupList = {}
	
	if false then
		for key, value in pairs( team.GetAllTeams() ) do
			if key != 0 and key != 1001 and key != 1002 then
				table.insert(groupList, key, value['Name'])
			end
		end
	else
		table.insert(groupList, "superadmin")
		table.insert(groupList, "admin")
		table.insert(groupList, "user")
	end
	
	return groupList
end


--- Checks if the group exists. Returns a boolean.
function utilGroupExists( input )
	for key, value in pairs( utilGroupList() ) do
		if value == input then
			return true
		end
	end
	
	return false
end


--- Returns a string array with all known weapon classnames.
function utilWeaponList()
	local weaponList = {}
	table.insert(weaponList, "weapon_crowbar")
	table.insert(weaponList, "weapon_physcannon")
	table.insert(weaponList, "weapon_physgun")
	table.insert(weaponList, "weapon_pistol")
	table.insert(weaponList, "weapon_357")
	table.insert(weaponList, "weapon_smg1")
	table.insert(weaponList, "weapon_ar2")
	table.insert(weaponList, "weapon_shotgun")
	table.insert(weaponList, "weapon_crossbow")
	table.insert(weaponList, "weapon_frag")
	table.insert(weaponList, "weapon_rpg")
	table.insert(weaponList, "weapon_stunstick")
	table.insert(weaponList, "weapon_slam")
	table.insert(weaponList, "weapon_bugbait")
	table.insert(weaponList, "weapon_annabelle")
	table.insert(weaponList, "item_ml_grenade")
	table.insert(weaponList, "item_ar2_grenade")
	table.insert(weaponList, "item_ammo_ar2_altfire")
	table.insert(weaponList, "item_healthkit")
	table.insert(weaponList, "item_healthvial")
	table.insert(weaponList, "item_suit")
	table.insert(weaponList, "item_battery")
	for key, value in pairs(weapons.GetList()) do 
		table.insert(weaponList, value['ClassName']) 
	end

	return weaponList
end


--- Returns a string array with all supported weapon classnames.
function utilWeaponListSupported()
	local weaponList = {}
	table.insert(weaponList, "weapon_crowbar")
	table.insert(weaponList, "weapon_physcannon")
	table.insert(weaponList, "weapon_physgun")
	table.insert(weaponList, "weapon_pistol")
	table.insert(weaponList, "weapon_357")
	table.insert(weaponList, "weapon_smg1")
	table.insert(weaponList, "weapon_ar2")
	table.insert(weaponList, "weapon_shotgun")
	table.insert(weaponList, "weapon_crossbow")
	table.insert(weaponList, "weapon_frag")
	table.insert(weaponList, "weapon_rpg")
	table.insert(weaponList, "weapon_stunstick")
	
	return weaponList
end


--- Validates if a weapon exists. Returns a boolean.
function utilWeaponExists( weaponClass )
	for key, value in pairs( utilWeaponList() ) do
		if value == weaponClass then
			return true
		end
	end
	return false
end


--- Validates if a weapon is supported by WLC. Returns a boolean.
function utilWeaponSupported( weaponClass )
	if table.HasValue(utilWeaponListSupported(), weaponClass) then
		return true
	else
		return false
	end
end


--- Returns a string array with a list of convars.
function utilConvarListSupported()
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
	return table.HasValue(utilConvarListSupported(), convar)
end


--- Returns help about all commands or a specific command. Returns a string array.
function utilHelp( command )
	local returnString = {}
		
	if command != nil then
		if command == "help" then
			table.insert(returnString, "No help available yet.")
		elseif command == "check" then
			table.insert(returnString, "No help available yet.")
		elseif command == "addweapon" then
			table.insert(returnString, "No help available yet.")
		elseif command == "removeweapon" then
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
		table.insert(returnString, "Description: Shows the weapon(s) and limit(s) that the group has listed.\n\r")
		
		table.insert(returnString, "wlc addweapon [group] [weapon]")
		table.insert(returnString, "Example: wlc addweapon user weapon_psyscannon") 
		table.insert(returnString, "Description: Adds a new weaponentry.\n\r") -- TODO: Make this proper english :p.
		
		table.insert(returnString, "wlc removeweapon [group] [[weapon]]")
		table.insert(returnString, "Example: wlc removeweapon moderator weapon_crowbar")
		table.insert(returnString, "Description: Removes the weapon, or all weapons if no weapon is specified.\n\r") -- TODO: Make this proper english :p.
		
		table.insert(returnString, "wlc setlimit [group] [convar] [newlimit]")
		table.insert(returnString, "Example: wlc setlimit admin sbox_maxnpcs 10")
		table.insert(returnString, "Description: Sets a new limit for the provided convar. Use -1 for unlimited.\n\r")
		
		table.insert(returnString, "wlc removelimit [group] [[convar]]")
		table.insert(returnString, "Example: wlc removelimit admin sbox_maxnpcs")
		table.insert(returnString, "Description: Removes the limit set for the provided convar, or all limits if no convar is specified.\n\r")
		
		table.insert(returnString, "wlc gui")
		table.insert(returnString, "Example: wlc gui")
		table.insert(returnString, "Description: Shows the Graphical User Interface.\n\r")

		table.insert(returnString, "wlc cleardb")
		table.insert(returnString, "Example: wlc cleardb")
		table.insert(returnString, "Description: Removes all weapons/limits.\n\r") -- TODO: Make this proper english :p.
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