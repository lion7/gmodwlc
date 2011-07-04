--[[
	Title: ConCommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlc' in the console.
function concmdWlc( ply, command, args )
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
concommand.Add( "wlc", concmdWlc )