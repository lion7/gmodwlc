--[[
	Title: Utilities

	Holds helpful utility functions.
]]


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

--- Returns help about all commands or a specific command. Returns a string array.
function utilHelp( command )
	returnString = {}
		
	if command == nil then
		table.insert(returnString, "Available commands:")
		table.insert(returnString, "")
		table.insert(returnString, "wlc help [command]")
		table.insert(returnString, "\tExample: wlc help check")
		table.insert(returnString, "\tDescription: Shows a description and examples about the provided command, or all commands if none provided.")
		table.insert(returnString, "")
		
		table.insert(returnString, "wlc check group")
		table.insert(returnString, "\tExample: wlc check superadmin")
		table.insert(returnString, "\tDescription: Shows the restrictions and limits active on the group.")
		table.insert(returnString, "")
		
		table.insert(returnString, "wlc blacklist group weapons")
		table.insert(returnString, "\tExample: wlc blacklist admin weapon_rpg,weapon_frag")
		table.insert(returnString, "\tDescription: Prevents an group from spawning the provided weapons.")
		table.insert(returnString, "")
		
		table.insert(returnString, "wlc whitelist group weapons")
		table.insert(returnString, "\tExample: wlc whitelist user weapon_psyscannon,gmod_camera") 
		table.insert(returnString, "\tDescription: Allows an group to spawn only the provided weapons.")
		table.insert(returnString, "")
		
		table.insert(returnString, "wlc unlist group")
		table.insert(returnString, "\tExample: wlc unlist moderator")
		table.insert(returnString, "\tDescription: Removes all weapon restrictions.")
		table.insert(returnString, "")
		
		table.insert(returnString, "wlc setlimit group convar newlimit")
		table.insert(returnString, "\tExample: wlc setlimit admin sbox_maxnpcs 10")
		table.insert(returnString, "\tDescription: Sets an new limit for the provided convar. Use -1 for unlimited.")
		table.insert(returnString, "")
		
		table.insert(returnString, "wlc removelimit group [convar]")
		table.insert(returnString, "\tExample: wlc removelimit admin sbox_maxnpcs")
		table.insert(returnString, "\tDescription: Removes the limit set for the provided convar, or all limits if no convar specified.")
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

function utilJoinTables(t1, t2)  
    for k,v in ipairs(t2) do 
		table.insert(t1, v) 
	end 
	return t1  
end 