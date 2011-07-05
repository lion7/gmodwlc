--[[
	Title: Input

	Holds input commands and their functions.
]]


--- Returns a string array with all wlc subcommands.
function inputWlcAutoCompleteList()
	local autoCompleteList = {}
	
	table.insert(autoCompleteList, "wlc check")
	table.insert(autoCompleteList, "wlc addweapon")
	table.insert(autoCompleteList, "wlc removeweapon")
	table.insert(autoCompleteList, "wlc setlimit")
	table.insert(autoCompleteList, "wlc removelimit")
	table.insert(autoCompleteList, "wlc gui")
	table.insert(autoCompleteList, "wlc cleardb")
	
	return autoCompleteList
end


--- Gets called if an admin typed 'wlc' in the console.
function inputConCmdWlc( ply, command, args )
	result = inputCheck(ply, command, args)
	
	if table.Count(result) > 0 then
		for key, value in pairs( result ) do
			print(value)
		end
	else
		streamSend( { ["command"]=command, ["args"]=args } )
	end
end
concommand.Add( "wlc", inputConCmdWlc, inputWlcAutoCompleteList )