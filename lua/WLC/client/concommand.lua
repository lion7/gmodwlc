--[[
	Title: Concommand

	Holds console commands and their functions.
]]


--- Gets called if an admin typed 'wlcgui' in the console.
function concmdWlcGui( player, command, args )
	if utilEnabled() then
		if utilAdminCheck( player ) == true then
			local dermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself			
			local button = vgui.Create( "DButton", dermaPanel )
			local numSlider = vgui.Create( "DNumSlider", dermaPanel )
			local usergroupListView = vgui.Create( "DListView", dermaPanel )
			local dataListView = vgui.Create( "DListView", dermaPanel )
			local dataListView_Column = dataListView:AddColumn( "" )
			local limitCheckBox = vgui.Create( "DCheckBoxLabel", dermaPanel )
			local blacklistCheckBox = vgui.Create( "DCheckBoxLabel", dermaPanel )
			local whitelistCheckBox = vgui.Create( "DCheckBoxLabel", dermaPanel )
			
			dermaPanel:SetPos( 50,50 ) -- Position on the players screen
			dermaPanel:SetSize( 1000, 700 ) -- Size of the frame
			dermaPanel:SetTitle( "WLC - Weapon and Limit Control" ) -- Title of the frame
			dermaPanel:SetVisible( true )
			dermaPanel:SetDraggable( true ) -- Draggable by mouse?
			dermaPanel:ShowCloseButton( true ) -- Show the close button?
			dermaPanel:MakePopup() -- Show the frame
							
			numSlider:SetPos( 525, 610 )
			numSlider:SetSize( 400, 40 )
			numSlider:SetText( "Convar value" )
			numSlider:SetValue( 0 )
			numSlider:SetMin( -1 ) -- Minimum number of the slider
			numSlider:SetMax( 256 ) -- Maximum number of the slider
			numSlider:SetDecimals( 0 ) -- Sets a decimal. Zero means it's a whole number
			numSlider:SetVisible( false )
	
			button:SetPos( 575, 650 )
			button:SetSize( 300, 30 )
			button:SetText( "Apply" )
			button.DoClick = function( button )
				if true then
					RunConsoleCommand( "wlc", "setlimit", textEntry:GetValue(), "sbox_maxprops", numSlider:GetValue() )
				end
			end
			button:SetDisabled( true )
			
			usergroupListView:SetPos( 25, 100 )
			usergroupListView:SetSize( 475, 500 )
			usergroupListView:SetMultiSelect( false )
			usergroupListView:AddColumn( "Usergroup(s)" )
			for key, value in pairs( team.GetAllTeams() ) do
				usergroupListView:AddLine( value['Name'] )
			end
			usergroupListView:SetSortable( true )
			usergroupListView.OnRowSelected = function( panel, line )
				if blacklistCheckBox:GetValue() == 1 and usergroupListView:GetSelectedLine() > 0 and dataListView:GetSelectedLine() > 0 then
					button:SetDisabled( false )
				elseif usergroupListView:GetSelectedLine() > 0 and dataListView:GetSelectedLine() > 0 then
					button:SetDisabled( false )
				else
					button:SetDisabled( true )
				end
			end
			
			dataListView:SetPos( 525, 100 )
			dataListView:SetSize( 450, 500 )
			dataListView:SetMultiSelect( false )
			dataListView:SetSortable( true )
			dataListView.OnRowSelected = function( panel, line )
				if blacklistCheckBox:GetValue() == 1 and usergroupListView:GetSelectedLine() > 0 and dataListView:GetSelectedLine() > 0 then
					button:SetDisabled( false )
				elseif usergroupListView:GetSelectedLine() > 0 and dataListView:GetSelectedLine() > 0 then
					button:SetDisabled( false )
				else
					button:SetDisabled( true )
				end
			end
			
			limitCheckBox:SetPos( 25, 50 )
			limitCheckBox:SetSize( 175, 30 )
			limitCheckBox:SetText( "Set a limit" )
			limitCheckBox:SetValue( 0 )
			function limitCheckBox:OnChange()
				blacklistCheckBox:SetValue( 0 )
				whitelistCheckBox:SetValue( 0 )
				dataListView_Column:SetName("Convar(s)")
				dataListView:Clear()
				for key, value in pairs( utilConvarList() ) do
					dataListView:AddLine( value )
				end
				dataListView:SortByColumn( 1 )
			end
			
			blacklistCheckBox:SetPos( 225, 50 )
			blacklistCheckBox:SetSize( 175, 30 )
			blacklistCheckBox:SetText( "Blacklist weapon(s)" )
			blacklistCheckBox:SetValue( 0 )
			function blacklistCheckBox:OnChange()
				limitCheckBox:SetValue( 0 )
				whitelistCheckBox:SetValue( 0 )
				dataListView_Column:SetName("Weapon(s)")
				dataListView:Clear()
				for key, value in pairs( utilWeaponsList() ) do
					dataListView:AddLine( value )
				end
				dataListView:SortByColumn( 1 )
			end

			whitelistCheckBox:SetPos( 425, 50 )
			whitelistCheckBox:SetSize( 175, 30 )
			whitelistCheckBox:SetText( "Whitelist weapon(s)" )
			whitelistCheckBox:SetValue( 0 )
			function whitelistCheckBox:OnChange()
				limitCheckBox:SetValue( 0 )
				blacklistCheckBox:SetValue( 0 )
				dataListView_Column:SetName("Weapon(s)")
				dataListView:Clear()
				for key, value in pairs( utilWeaponsList() ) do
					dataListView:AddLine( value )
				end
				dataListView:SortByColumn( 1 )
			end
		else
			print("You are not allowed to access this command!")
		end
	else
		print("WLC is disabled!")
	end
end

concommand.Add( "wlcgui", concmdWlcGui )