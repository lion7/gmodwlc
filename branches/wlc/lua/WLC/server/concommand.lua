--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlc' in the console.
function concmdWlc( player, command, args )
	local argsCount = table.Count(args)
	local result = {}
	
	if utilAdminCheck(player) == false then
		table.insert(result, "You are not allowed to access this command!")
	elseif argsCount < 1 then	
		table.insert(result, "Please provide a subcommand!")
		table.insert(result, "For a list of commands, type 'wlc help'.")
	else		
		local subCommand = args[1]
		
		if utilEnabled() == false then	
			table.insert(result, "WLC is disabled!")
		elseif subCommand == "help" then
			if(argsCount == 1) then
				utilJoinTables(result, utilHelp(nil))
			elseif(argsCount > 2) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 2) then	
				utilJoinTables(result, utilHelp(args[2]))
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "check" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to check for weapon restrictions and limits!")
			elseif(argsCount > 2) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 2) then	
				if utilTeamExists(args[2]) then
					utilJoinTables(result, wcCheckWeapons(args[2]))
					utilJoinTables(result, lcCheckLimits(args[2]))
				else
					table.insert(result, "Usergroup " .. args[2] .. " doesn't exist!")
				end
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "weaponcheck" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to check for weapon restrictions!")
			elseif(argsCount > 2) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 2) then	
				if utilTeamExists(args[2]) then
					utilJoinTables(result, wcCheckWeapons(args[2]))
				else
					table.insert(result, "Usergroup " .. args[2] .. " doesn't exist!")
				end
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "limitcheck" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to check for limits!")
			elseif(argsCount > 2) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 2) then	
				if utilTeamExists(args[2]) then
					utilJoinTables(result, lcCheckLimits(args[2]))
				else
					table.insert(result, "Usergroup " .. args[2] .. " doesn't exist!")
				end
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "blacklist" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to blacklist the weapons!")
			elseif(argsCount == 2) then
				table.insert(result, "Please provide one or more weapons to blacklist!")
			elseif(argsCount > 3) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 3) then	
				utilJoinTables(result, wcBlacklistWeapons(args[2], args[3]))
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "whitelist" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to whitelist the weapons!")
			elseif(argsCount == 2) then
				table.insert(result, "Please provide one or more weapons to whitelist!")
			elseif(argsCount > 3) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 3) then	
				utilJoinTables(result, wcWhitelistWeapons(args[2], args[3]))
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "unlist" then					
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to remove any weapon restrictions!")
			elseif(argsCount > 2) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 2) then	
				utilJoinTables(result, wcUnlistUsergroup(args[2]))
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "setlimit" then			
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to change the gmod limit!")
			elseif(argsCount == 2) then
				table.insert(result, "Please provide an existing gmod limit to specify a different limit!")
			elseif(argsCount == 3) then
				table.insert(result, "Please provide a different limit for the gmod limit!")
			elseif(argsCount > 4) then
				table.insert(result, "Too much arguments!")
			elseif(argsCount == 4) then	
				utilJoinTables(result, lcSetLimit(args[2], args[3], args[4]))
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "removelimit" then
			if(argsCount == 1) then
				table.insert(result, "Please provide a group to remove all limits, or an group and existing gmod limit to remove that limit!")
			elseif(argsCount == 2) then
				utilJoinTables(result, lcRemoveLimit(args[2]))
			elseif(argsCount == 3) then
				utilJoinTables(result, lcRemoveLimit(args[2], args[3]))
			elseif(argsCount > 3) then
				table.insert(result, "Too much arguments!")
			else
				table.insert(result, "Unhandled error!")
			end
		elseif subCommand == "cleardb" then
			if(argsCount == 1) then
				utilJoinTables(result, sqlRemoveTables())
				utilJoinTables(result, sqlValidateTables())
			else
				table.insert(result, "Unhandled error!")
			end
		else
			table.insert(result, "Invalid subcommand!")
		end
	end
	
	if player:IsValid() then
		if result == nil then
			player:PrintMessage(HUD_PRINTCONSOLE, "No output returned.")
		else
			if subCommand != "help" then
				print("\nAction(s) by " .. player:Name() .. ":")
			end
			for key, value in pairs( result ) do
				player:PrintMessage(HUD_PRINTCONSOLE, value)
				if subCommand != "help" then
					print(value)
				end
			end
		end
	else
		if result == nil then
			print("No output returned.")
		else
			for key, value in pairs( result ) do
				print(value)
			end
		end
	end
end
concommand.Add( "wlc", concmdWlc )