--[[
	Title: Utilities
 
	Holds helpful utility functions.
]]


--- Checks if the player has access to this script. Returns a boolean.
function utilAdminCheck( ply )
	if ply:IsValid() then
		-- playerTeam = team.GetName(ply:Team())
		for key, value in pairs( convarAdminGroups() ) do
			-- if playerTeam == value then
			if ply:IsUserGroup(value) then
				return true
			end
		end
		
		return false
	else
		return true
	end
end


-- --- Checks if the usergroup exists. Returns a boolean.
-- function utilUsergroupExists( usergroup )
	-- for key, value in pairs( ??? ) do
		-- if value == usergroup then
			-- return true
		-- end
	-- end
	-- return false
-- end


--- Checks if the team exists. Returns a boolean.
function utilTeamExists( teamName )
	for key, value in pairs( utilTeamsList() ) do
		if value['Name'] == teamName then
			return true
		end
	end
	return false
end


--- Returns a string array with all known weapon classnames.
function utilTeamsList()
	local teamsList = {}
	for key, value in pairs( team.GetAllTeams() ) do
		if key != 0 and key != 1001 and key != 1002 then
			table.insert(teamsList, key, value)
		end
	end
	
	return teamsList
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


--- Returns help about all commands or a specific command. Returns a string array.
function utilHelp( command )
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
		else
			table.insert(returnString, "Invalid command!")
			table.insert(returnString, "Type wlc help to see a list of all available commands.")
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