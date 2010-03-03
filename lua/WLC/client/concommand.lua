--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlcgui' in the console.
function concmdWlcGui( player, command, args )
	if utilEnabled() then
		if utilAdminCheck( player ) == true then
			local dermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
			dermaPanel:SetPos( 50,50 ) -- Position on the players screen
			dermaPanel:SetSize( 1000, 900 ) -- Size of the frame
			dermaPanel:SetTitle( "Testing Derma Stuff" ) -- Title of the frame
			dermaPanel:SetVisible( true )
			dermaPanel:SetDraggable( true ) -- Draggable by mouse?
			dermaPanel:ShowCloseButton( true ) -- Show the close button?
			dermaPanel:MakePopup() -- Show the frame
			
			local numSlider = vgui.Create( "DNumSlider", dermaPanel )
			numSlider:SetPos( 25,50 )
			numSlider:SetWide( 150 )
			numSlider:SetText( "Max Props" )
			numSlider:SetValue( GetConVar("sbox_maxprops"):GetInt() )
			numSlider:SetMin( 0 ) -- Minimum number of the slider
			numSlider:SetMax( 256 ) -- Maximum number of the slider
			numSlider:SetDecimals( 0 ) -- Sets a decimal. Zero means it's a whole number

			local textEntry = vgui.Create( "DTextEntry", dermaPanel )
			textEntry:SetPos( 25,100 )
			textEntry:SetWide( 150 )
			textEntry:SetText( "Initial Value" )

			local button = vgui.Create( "DButton", dermaPanel )
			button:SetSize( 100, 30 )
			button:SetPos( 25, 150 )
			button:SetText( "Test Button" )
			button.DoClick = function( button )
				RunConsoleCommand("wlc", "setlimit", textEntry:GetValue(), "sbox_maxprops", numSlider:GetValue())
			end	
		else
			print("You are not allowed to access this command!")
		end
	else
		print("WLC is disabled!")
	end
end

concommand.Add( "wlcgui", concmdWlcGui )