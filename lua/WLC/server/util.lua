--[[
	Title: Utilities

	Holds helpful utility functions.
]]


-- local wlc_enabled = true


--- Checks if the player has access to this script. Returns a boolean.
function utilAdminCheck( player )
	if player:IsValid() then	
		for key, value in pairs( convarAdminGroups() ) do
			if player:IsUserGroup(value) then 
				return true
			end
		end
		
		return false
	else
		return true
	end
end

--- Returns help about all commands or a specific command. Returns a string.
function utilHelp( command )
	if command == nil then
		returnString = "Commands:\n"
		returnString = returnString .. "wlc help [command]\n"
		returnString = returnString .. "\tExample: wlc help check\n"
		returnString = returnString .. "\tDescription: Shows a description and examples about the provided command, or all commands if none provided.\n"
		returnString = returnString .. "\n"
		
		returnString = returnString .. "wlc check group\n"
		returnString = returnString .. "\tExample: wlc check superadmin\n" 
		returnString = returnString .. "\tDescription: Shows the restrictions and limits active on the group.\n"
		returnString = returnString .. "\n"
		
		returnString = returnString .. "wlc blacklist group weapons\n"
		returnString = returnString .. "\tExample: wlc blacklist admin weapon_rpg,weapon_frag\n" 
		returnString = returnString .. "\tDescription: Prevents an group from spawning the provided weapons.\n"
		returnString = returnString .. "\n"
		
		returnString = returnString .. "wlc whitelist group weapons\n"
		returnString = returnString .. "\tExample: wlc whitelist user weapon_psyscannon,gmod_camera\n" 
		returnString = returnString .. "\tDescription: Allows an group to spawn only the provided weapons.\n"
		returnString = returnString .. "\n"
		
		returnString = returnString .. "wlc unlist group\n"
		returnString = returnString .. "\tExample: wlc unlist moderator\n"
		returnString = returnString .. "\tDescription: Removes all weapon restrictions.\n"
		returnString = returnString .. "\n"
		
		returnString = returnString .. "wlc setlimit group convar newlimit\n"
		returnString = returnString .. "\tExample: wlc setlimit admin sbox_maxnpcs 10\n" 
		returnString = returnString .. "\tDescription: Sets an new limit for the provided convar. Use -1 for unlimited.\n"
		returnString = returnString .. "\n"
		
		returnString = returnString .. "wlc removelimit group [convar]\n"
		returnString = returnString .. "\tExample: wlc removelimit admin sbox_maxnpcs\n" 
		returnString = returnString .. "\tDescription: Removes the limit set for the provided convar, or all limits if no convar specified.\n"
	else
		if command == "help" then
			returnString = "No help available yet."
		elseif command == "check" then
			returnString = "No help available yet."
		elseif command == "blacklist" then
			returnString = "No help available yet."
		elseif command == "whitelist" then
			returnString = "No help available yet."
		elseif command == "unlist" then
			returnString = "No help available yet."
		elseif command == "setlimit" then
			returnString = "No help available yet."
		elseif command == "removelimit" then
			returnString = "No help available yet."
		else
			returnString = "Invalid command!\n"
			returnString = returnString .. "Type wlc help to see a list of all available commands.\n"
		end
	end
	
	return returnString
end


-- --- Checks if the script is enabled/disabled. Returns a boolean.
-- function utilIsEnabled() 
	-- return wlc_enabled
-- end


-- --- Enables/disables the script. Returns a string.
-- function utilSetEnabled( bool ) 
	-- if bool then
		-- if wlc_enabled == false then
			-- wlc_enabled = true
			-- return "WLC is now enabled."
		-- else		
			-- return "WLC is already enabled."
		-- end
	-- elseif bool == false then
		-- if wlc_enabled then
			-- wlc_enabled = false
			-- return "WLC is now disabled."
		-- else		
			-- return "WLC is already disabled."
		-- end
	-- end
-- end