--[[
	Title: Utilities

	Holds helpful utility functions.
]]

--- Returns a boolean.
function utilEnabled()
	return GetConVar("wlc_enabled"):GetBool()
end

--- Returns a boolean.
function utilDefaultAction()
	return GetConVar("wlc_defaultaction"):GetBool()
end

--- Returns a string array.
function utilAdminGroups()
	return string.Explode(",", GetConVar("wlc_admingroups"):GetString())
end

--- Checks if the player has access to this script. Returns a boolean.
function utilAdminCheck( player )
	if player:IsValid() then
		-- playerTeam = team.GetName(player:Team())
		for key, value in pairs( utilAdminGroups() ) do
			-- if playerTeam == value then
			if player:IsUserGroup(value) then
				return true
			end
		end
		
		return false
	else
		return true
	end
end

--- Checks if the usergroup exists. Returns a boolean.
function utilUsergroupExists( usergroup )
	for key, value in pairs( team.GetAllTeams() ) do
		if table.HasValue(value, usergroup) then
			return true
		else
			return false
		end
	end
end


-- Copies all entries in table2 to table1. Returns a table.
function utilJoinTables(table1, table2)
	if table1 == nil then
		table1 = {}
	end
	
	if table2 != nil then
		for key, value in pairs(table2) do 
			table.insert(table1, value) 
		end
	end
	
	return table1
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
	table.insert(weaponsList, "gmod_tool")
	table.insert(weaponsList, "gmod_camera")
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


--- Returns a string array with a list of convars.
function utilConvarList()
	local convarList = {}
	table.insert(convarList, "sbox_maxeffects")
	table.insert(convarList, "sbox_maxnpcs")
	table.insert(convarList, "sbox_maxprops")
	table.insert(convarList, "sbox_maxragdolls")
	table.insert(convarList, "sbox_maxvehicles")
	
	return convarList
end


--- Returns help about all commands or a specific command. Returns a string array.
function utilHelp( command )
	local returnString = {}
		
	if command == nil then
		table.insert(returnString, "\n\rAvailable commands:\n\r")
		
		table.insert(returnString, "wlc help [[command]]")
		table.insert(returnString, "Example: wlc help check")
		table.insert(returnString, "Description: Shows a description and examples about the provided command, or all commands if none provided.\n\r")
		
		table.insert(returnString, "wlc check [group]")
		table.insert(returnString, "Example: wlc check superadmin")
		table.insert(returnString, "Description: Shows the restrictions and limits active on the group.\n\r")
		
		table.insert(returnString, "wlc blacklist [group] [weapons]")
		table.insert(returnString, "Example: wlc blacklist admin weapon_rpg,weapon_frag")
		table.insert(returnString, "Description: Prevents an group from spawning the provided weapons.\n\r")
		
		table.insert(returnString, "wlc whitelist [group] [weapons]")
		table.insert(returnString, "Example: wlc whitelist user weapon_psyscannon,gmod_camera") 
		table.insert(returnString, "Description: Allows an group to spawn only the provided weapons.\n\r")
		
		table.insert(returnString, "wlc unlist [group]")
		table.insert(returnString, "Example: wlc unlist moderator")
		table.insert(returnString, "Description: Removes all weapon restrictions.\n\r")
		
		table.insert(returnString, "wlc setlimit [group] [convar] [newlimit]")
		table.insert(returnString, "Example: wlc setlimit admin sbox_maxnpcs 10")
		table.insert(returnString, "Description: Sets an new limit for the provided convar. Use -1 for unlimited.\n\r")
		
		table.insert(returnString, "wlc removelimit [group] [[convar]]")
		table.insert(returnString, "Example: wlc removelimit admin sbox_maxnpcs")
		table.insert(returnString, "Description: Removes the limit set for the provided convar, or all limits if no convar specified.\n\r")
	else
		if command == "help" then
			table.insert(returnString, "No help available yet.")
		elseif command == "check" then
			table.insert(returnString, "No help available yet.")
		elseif command == "blacklist" then
			table.insert(returnString, "No help available yet.")
		elseif command == "whitelist" then
			table.insert(returnString, "No help available yet.")
		elseif command == "unlist" then
			table.insert(returnString, "No help available yet.")
		elseif command == "setlimit" then
			table.insert(returnString, "No help available yet.")
		elseif command == "removelimit" then
			table.insert(returnString, "No help available yet.")
		else
			table.insert(returnString, "Invalid command!")
			table.insert(returnString, "Type wlc help to see a list of all available commands.")
		end
	end
		
	return returnString
end