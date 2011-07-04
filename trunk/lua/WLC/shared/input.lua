--[[
	Title: Input

	Holds input functions.
]]


--- Checks if the input has the correct format. Returns a table with error messages or nil if the input is correct.
function inputCheck( ply, command, args )
	local result = {}
	local argsCount = table.Count(args)
	
	if command != "wlc" then
		table.insert(result, "Error - Invalid command!")
	elseif argsCount < 1 then	
		table.insert(result, "Please provide a subcommand!")
		table.insert(result, "For a list of commands, type 'wlc help'.")
	else
		local subCommand = args[1]

		if subCommand == "help" then
			if argsCount > 2 then
				table.insert(result, "Error - Too much arguments!")
			elseif argsCount == 1 then	
				table.Add(result, utilHelp(nil))
			elseif argsCount == 2 then	
				table.Add(result, utilHelp(args[2]))
			else
				table.insert(result, "Error - Unhandled error!")
			end
		elseif subCommand == "check" then
			if argsCount == 1 then
				table.insert(result, "Please provide a group to check the weapon(s) and limit(s) listed!")
			elseif argsCount == 2 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				end
			elseif argsCount > 2 then
				table.insert(result, "Error - Too much arguments!")
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "addweapon" then
			if argsCount == 1 then
				table.insert(result, "Please provide a group!")
			elseif argsCount == 2 then
				table.insert(result, "Please provide a weapon to add!")
			elseif argsCount == 3 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				elseif utilWeaponExists(args[3]) == false then
					table.insert(result, "Error - Weapon " .. args[3] .. " doesn't exist!")
				elseif utilWeaponSupported(args[3]) == false then
					table.insert(result, "Error - Weapon " .. args[3] .. " isn't supported (yet)!")
					table.insert(result, "Currently the following weapons are supported:")
					table.Add(result, utilWeaponListSupported())
				end
			elseif argsCount > 3 then
				table.insert(result, "Error - Too much arguments!")
			else
				table.insert(result, "Error - Unhandled error!")
			end
		elseif subCommand == "removeweapon" then					
			if argsCount == 1 then
				table.insert(result, "Please provide a group to remove all weapons, or an group and a weapon to remove that weapon!")
			elseif argsCount > 3 then
				table.insert(result, "Error - Too much arguments!")
			elseif argsCount == 2 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				end
			elseif argsCount == 3 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				elseif utilWeaponExists(args[3]) == false then
					table.insert(result, "Error - Weapon " .. args[3] .. " doesn't exist!")
				elseif utilWeaponSupported(args[3]) == false then
					table.insert(result, "Error - Weapon " .. args[3] .. " isn't supported (yet)!")
					table.insert(result, "Currently the following weapons are supported:")
					table.Add(result, utilWeaponListSupported())
				end
			else
				table.insert(result, "Error - Unhandled error!")
			end
		elseif subCommand == "setlimit" then			
			if argsCount == 1 then
				table.insert(result, "Please provide a group to change the gmod limit!")
			elseif argsCount == 2 then
				table.insert(result, "Please provide an existing gmod limit to specify a different limit!")
			elseif argsCount == 3 then
				table.insert(result, "Please provide a different limit for the gmod limit!")
			elseif argsCount == 4 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				elseif utilLimitExists(args[3]) == false then
					table.insert(result, "Error - Gmod limit " .. args[3] .. " doesn't exist!")
				elseif utilLimitSupported(args[3]) == false then
					table.insert(result, "Error - Gmod limit " .. args[3] .. " isn't supported (yet)!")
					table.insert(result, "Currently the following limits are supported:")
					table.Add(result, utilConvarListSupported())
				end
			elseif argsCount > 4 then
				table.insert(result, "Error - Too much arguments!")
			else
				table.insert(result, "Error - Unhandled error!")
			end
		elseif subCommand == "removelimit" then
			if argsCount == 1 then
				table.insert(result, "Please provide a group to remove all limits, or an group and existing gmod limit to remove that limit!")
			elseif argsCount == 2 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				end
			elseif argsCount == 3 then
				if not utilGroupExists(args[2]) then
					table.insert(result, "Error - Usergroup " .. args[2] .. " doesn't exist!")
				elseif utilLimitExists(args[3]) == false then
					table.insert(result, "Error - Gmod limit " .. args[3] .. " doesn't exist!")
				elseif utilLimitSupported(args[3]) == false then
					table.insert(result, "Error - Gmod limit " .. args[3] .. " isn't supported (yet)!")
					table.insert(result, "Currently the following limits are supported:")
					table.Add(result, utilConvarListSupported())
				end
			elseif argsCount > 3 then
				table.insert(result, "Error - Too much arguments!")
			else
				table.insert(result, "Error - Unhandled error!")
			end

		elseif subCommand == "cleardb" then
			if argsCount == 1 then
				if ply:IsValid() then
					table.insert(result, "This command is only available in the server console!")
					table.insert(result, "Note: If you have rcon access you can use 'rcon wlc cleardb'.")
				end
			else
				table.insert(result, "Error - Unhandled error!")
			end
		elseif subCommand == "gui" then
			if argsCount == 1 then
				if not ply:IsValid() then
					table.insert(result, "This command is only available in the client console!")
				end
			else
				table.insert(result, "Error - Unhandled error!")
			end
		else
			table.insert(result, "Error - Invalid subcommand!")
			table.insert(result, "Type 'wlc help' to see a list of all available commands.")
		end
	end
	
	return result
end