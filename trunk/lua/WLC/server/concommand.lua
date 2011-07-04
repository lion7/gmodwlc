--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlc' in the console.
function concmdWlc( ply, command, args )
	result = checkInput(ply, command, args)
	
	if table.Count(result) == 0 then
		result = handleInput(ply, command, args)
	end
	
	if table.Count(result) > 0 then
		for key, value in pairs( result ) do
			print(value)
		end
	else
		print("Error - No output returned.")
	end
end
concommand.Add( "wlc", concmdWlc )