--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlc' in the console.
function concmdWlc( ply, command, args )
	result = inputCheck(ply, command, args)
	
	if table.Count(result) > 0 then
		for key, value in pairs( result ) do
			print(value)
		end
	else
		streamSend( { ["command"]=command, ["args"]=args } )
	end
end
concommand.Add( "wlc", concmdWlc, utilWlcAutoCompleteList )