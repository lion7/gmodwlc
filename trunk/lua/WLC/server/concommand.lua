--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlc' in the console.
function concmdWlc( ply, command, args )
	local argsCount = table.Count(args)
	local result = {}
	
	if utilAdminCheck(ply) == false then
		table.insert(result, "You are not allowed to access this command!")
	elseif argsCount < 1 then	
		table.insert(result, "Please provide a subcommand!")
		table.insert(result, "For a list of commands, type 'wlc help'.")
	else		
		local subCommand = args[1]
		
		if convarEnabled() == false then	
			table.insert(result, "WLC is disabled!")
		elseif subCommand == "help" then
			if(argsCount == 1) then
				table.Add(result, utilHelp(nil))
			elseif(argsCount > 2) then
				table.insert(result, "Error: Too much arguments!")
			elseif(argsCount == 2) then	
				table.Add(result, utilHelp(args[2]))
			else
				table.insert(result, "Error: Unhandled error!")
			end
		elseif subCommand == "check" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to check for weapon restrictions and limits!")
			elseif(argsCount > 2) then
				table.insert(result, "Error: Too much arguments!")
			elseif(argsCount == 2) then	
				if utilTeamExists(args[2]) then
					table.Add(result, wcCheckWeapons(args[2]))
					table.Add(result, lcCheckLimits(args[2]))
				else
					table.insert(result, "Error: Usergroup " .. args[2] .. " doesn't exist!")
				end
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "restrictweapon" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to restrict a weapon!")
			elseif(argsCount == 2) then
				table.insert(result, "Please provide a weapon to restrict!")
			elseif(argsCount > 3) then
				table.insert(result, "Error: Too much arguments!")
			elseif(argsCount == 3) then	
				table.Add(result, wcRestrictWeapon(args[2], args[3]))
			else
				table.insert(result, "Error: Unhandled error!")
			end
		elseif subCommand == "unrestrictweapon" then					
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to unrestrict all weapons, or an group and a weapon to unrestrict that weapon!")
			elseif(argsCount > 3) then
				table.insert(result, "Error: Too much arguments!")
			elseif(argsCount == 2) then	
				table.Add(result, wcUnrestrictWeapon(args[2], nil))
			elseif(argsCount == 3) then	
				table.Add(result, wcUnrestrictWeapon(args[2], args[3]))
			else
				table.insert(result, "Error: Unhandled error!")
			end
		elseif subCommand == "setlimit" then			
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to change the gmod limit!")
			elseif(argsCount == 2) then
				table.insert(result, "Please provide an existing gmod limit to specify a different limit!")
			elseif(argsCount == 3) then
				table.insert(result, "Please provide a different limit for the gmod limit!")
			elseif(argsCount > 4) then
				table.insert(result, "Error: Too much arguments!")
			elseif(argsCount == 4) then	
				table.Add(result, lcSetLimit(args[2], args[3], args[4]))
			else
				table.insert(result, "Error: Unhandled error!")
			end
		elseif subCommand == "removelimit" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to remove all limits, or an group and existing gmod limit to remove that limit!")
			elseif(argsCount > 3) then
				table.insert(result, "Error: Too much arguments!")
			elseif(argsCount == 2) then
				table.Add(result, lcRemoveLimit(args[2], nil))
			elseif(argsCount == 3) then
				table.Add(result, lcRemoveLimit(args[2], args[3]))
			else
				table.insert(result, "Error: Unhandled error!")
			end
		elseif subCommand == "cleardb" then
			if(argsCount == 1) then
				table.Add(result, sqlDeleteTables())
				table.Add(result, sqlCreateTables())
				table.Add(result, sqlValidateTables())
			else
				table.insert(result, "Error: Unhandled error!")
			end
		elseif subCommand == "gui" then
			if(argsCount == 1) then
				table.insert(result, "This command is available client-side only!")
			else
				table.insert(result, "Error: Unhandled error!")
			end
		else
			table.insert(result, "Error: Invalid subcommand!")
		end
	end
	
	if ply:IsValid() then
		if result != nil then
			if subCommand != "help" then
				print("\nAction(s) by " .. ply:Name() .. ":")
			end
			for key, value in pairs( result ) do
				ply:PrintMessage(HUD_PRINTCONSOLE, value)
				if subCommand != "help" then
					print(value)
				end
			end
		else
			ply:PrintMessage(HUD_PRINTCONSOLE, "Error: No output returned.")
		end
	else
		if result != nil then
			for key, value in pairs( result ) do
				print(value)
			end
		else
			print("Error: No output returned.")
		end
	end
end
concommand.Add( "wlc", concmdWlc )