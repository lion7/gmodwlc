--[[
	Title: Input

	Holds input functions.
]]


--- Gets called if 'wlc' is typed in the server console.
function inputConCmdWlc( ply, command, args )
	-- Check the input locally.
	result = inputCheck(ply, command, args)
	
	-- Handle the command if the input was valid.
	if table.Count(result) == 0 then
		result = inputHandle(ply, command, args)
	end
	
	-- Print the check/handling output.
	if table.Count(result) > 0 then
		for key, value in pairs( result ) do
			print(value)
		end
	else
		print("Error - No output returned.")
	end
	Msg("\n")
end
concommand.Add( "wlc", inputConCmdWlc )


--- Checks if the player is allowed to use WLC and handles the subcommand. The input should've been already checked by using 'checkInput'.
function inputHandle( ply, command, args ) 
	local result = {}
	
	if command != "wlc" then
		table.insert(result, "Error - Invalid command!")
	elseif utilAdminCheck(ply) == false then
		table.insert(result, "Error - You are not allowed to access this command!")
	else
		local subCommand = args[1]
		
		if subCommand == "check" then
			table.Add(result, weaponCheck(args[2]))
			table.Add(result, limitCheck(args[2]))
		elseif subCommand == "addweapon" then
			table.Add(result, weaponAdd(args[2], args[3]))
		elseif subCommand == "removeweapon" then		
			local argsCount = table.Count(args)		
			
			if(argsCount == 2) then	
				table.Add(result, weaponRemove(args[2], nil))
			elseif(argsCount == 3) then	
				table.Add(result, weaponRemove(args[2], args[3]))
			end
		elseif subCommand == "setlimit" then			
			table.Add(result, limitSet(args[2], args[3], args[4]))
		elseif subCommand == "removelimit" then
			local argsCount = table.Count(args)
			
			if(argsCount == 2) then
				table.Add(result, limitRemove(args[2], nil))
			elseif(argsCount == 3) then
				table.Add(result, limitRemove(args[2], args[3]))
			end
		elseif subCommand == "cleardb" then
			if sqlDeleteWeaponsTable() then
				table.insert(result, "Table wlc_weapons deleted")
			else		
				table.insert(result, "Table wlc_weapons not deleted")
			end
			
			if sqlDeleteLimitsTable() then
				table.insert(result, "Table wlc_limits deleted")
			else		
				table.insert(result, "Table wlc_limits not deleted")
			end
			
			if sqlCreateWeaponsTable() then
				table.insert(result, "Table wlc_weapons created")
			else		
				table.insert(result, "Table wlc_weapons not created")
			end
			
			if sqlCreateLimitsTable() then
				table.insert(result, "Table wlc_limits created")
			else		
				table.insert(result, "Table wlc_limits not created")
			end
			
			table.Add(result, sqlValidateTables())
		elseif subCommand == "gui" then
			ply:SendLua("wlcGuiShow()")
		end
	end
	
	return result
end