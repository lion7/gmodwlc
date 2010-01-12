--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlc' in the console.
function concmdWlc( player, command, args )
	argsCount = table.Count(args)
	
	if utilAdminCheck(player) == false then
		result = "You are not allowed to access this command!"
	elseif argsCount < 1 then	
		result = "Please provide a subcommand!"
	else		
		subCommand = args[1]
		
		-- if subCommand == "enable" then
			-- if(argsCount > 1) then
				-- result = "Too much arguments!"
			-- elseif(argsCount == 1) then
				-- result = utilSetEnabled(true)			
			-- else
				-- result = "Unhandled error!"
			-- end
		-- elseif subCommand == "disable" then
			-- if(argsCount > 1) then
				-- result = "Too much arguments!"
			-- elseif(argsCount == 1) then
				-- result = utilSetEnabled(false)			
			-- else
				-- result = "Unhandled error!"
			-- end
		-- elseif convarEnabled() == false then	
		if convarEnabled() == false then	
			result = "WLC is disabled!"
		elseif subCommand == "check" then
			if(argsCount == 1) then
				result = "Please provide a group to check for weapon restrictions and limits!"
			elseif(argsCount > 2) then
				result = "Too much arguments!"
			elseif(argsCount == 2) then	
				result = wcCheckWeapons(args[2])
				result = result .. "\n" .. lcCheckLimit(args[2])
			else
				result = "Unhandled error!"
			end
		elseif subCommand == "whitelist" then
			if(argsCount == 1) then
				result = "Please provide one or more weapons to whitelist!"
			elseif(argsCount == 2) then
				result = "Please provide a group to whitelist the weapons!"
			elseif(argsCount > 3) then
				result = "Too much arguments!"
			elseif(argsCount == 3) then	
				result = wcWhitelistWeapons(args[2], args[3])
			else
				result = "Unhandled error!"
			end
		elseif subCommand == "blacklist" then
			if(argsCount == 1) then
				result = "Please provide one or more weapons to blacklist!"
			elseif(argsCount == 2) then
				result = "Please provide a group to blacklist the weapons!"
			elseif(argsCount > 3) then
				result = "Too much arguments!"
			elseif(argsCount == 3) then	
				result = wcBlacklistWeapons(args[2], args[3])
			else
				result = "Unhandled error!"
			end
		elseif subCommand == "unlist" then		
			argsCount = table.Count(args)
			
			if(argsCount == 1) then
				result = "Please provide a group to remove any weapon restrictions!"
			elseif(argsCount > 2) then
				result = "Too much arguments!"
			elseif(argsCount == 2) then	
				result = wcUnlistUsergroup(args[2])
			else
				result = "Unhandled error!"
			end
		elseif subCommand == "setlimit" then		
			argsCount = table.Count(args)
			
			if(argsCount == 1) then
				result = "Please provide an existing gmod limit to specify a different limit!"
			elseif(argsCount == 2) then
				result = "Please provide a different limit for the gmod limit!"
			elseif(argsCount == 3) then
				result = "Please provide a group to change the gmod limit!"
			elseif(argsCount > 4) then
				result = "Too much arguments!"
			elseif(argsCount == 4) then	
				result = lcSetLimit(args[2], args[3], args[4])
			else
				result = "Unhandled error!"
			end
		elseif subCommand == "removelimit" then		
			argsCount = table.Count(args)
			
			if(argsCount == 1) then
				result = "Please provide a group to remove all limits, or an group and existing gmod limit to remove that limit!"
			elseif(argsCount == 2) then
				result = lcRemoveLimit(args[2])
			elseif(argsCount == 3) then
				result = lcRemoveLimit(args[2], args[3])
			elseif(argsCount > 3) then
				result = "Too much arguments!"
			else
				result = "Unhandled error!"
			end
		else
			result = "Invalid subcommand!"
		end
	end
	
	if player:IsValid() then	
		player:PrintMessage(HUD_PRINTCONSOLE, result)
	else
		print(result)
	end
end
concommand.Add( "wlc", concmdWlc )