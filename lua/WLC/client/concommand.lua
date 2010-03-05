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
			local dataListView_Column = dataListView:AddColumn( " " )
			local limitButton = vgui.Create( "DButton", dermaPanel )
			local blacklistButton = vgui.Create( "DButton", dermaPanel )
			local whitelistButton = vgui.Create( "DButton", dermaPanel )
			
			dermaPanel:SetPos( 50,50 ) -- Position on the players screen
			dermaPanel:SetSize( 1000, 700 ) -- Size of the frame
			dermaPanel:SetTitle( "WLC - Weapon and Limit Control" ) -- Title of the frame
			dermaPanel:SetVisible( true )
			dermaPanel:SetDraggable( true ) -- Draggable by mouse?
			dermaPanel:ShowCloseButton( true ) -- Show the close button?
			dermaPanel:MakePopup() -- Show the frame
							
			numSlider:SetPos( 525, 610 )
			numSlider:SetSize( 400, 40 )
			numSlider:SetText( "Limit value (-1 for unlimited)" )
			numSlider:SetValue( 0 )
			numSlider:SetMin( -1 ) -- Minimum number of the slider
			numSlider:SetMax( 256 ) -- Maximum number of the slider
			numSlider:SetDecimals( 0 ) -- Sets a decimal. Zero means it's a whole number
			numSlider:SetVisible( false )
	
			button:SetPos( 575, 650 )
			button:SetSize( 300, 30 )
			button:SetText( "Apply" )
			button.DoClick = function( button )
				if limitButton:GetDisabled() == true then
					for key1, value1 in pairs( usergroupListView:GetSelected() ) do
						for key2, value2 in pairs( dataListView:GetSelected() ) do
							RunConsoleCommand( "wlc", "setlimit", value1:GetValue(1), value2:GetValue(1), numSlider:GetValue() )
						end
					end
				elseif blacklistButton:GetDisabled() == true then
					local weaponsSelected = dataListView:GetSelected()
					local weaponsString = ""
					for key, value in pairs( weaponsSelected ) do
						weaponsString = weaponsString .. value:GetValue(1) .. ","
					end
					weaponsString = string.sub(weaponsString, 0, -2)
					
					for key, value in pairs( usergroupListView:GetSelected() ) do
						RunConsoleCommand( "wlc", "blacklist", value:GetValue(1), weaponsString )
					end
				elseif whitelistButton:GetDisabled() == true then
					local weaponsSelected = dataListView:GetSelected()
					local weaponsString = ""
					for key, value in pairs( weaponsSelected ) do
						weaponsString = weaponsString .. value:GetValue(1) .. ","
					end
					weaponsString = string.sub(weaponsString, 0, -2)
					
					for key, value in pairs( usergroupListView:GetSelected() ) do
						RunConsoleCommand( "wlc", "whitelist", value:GetValue(1), weaponsString )
					end
				end
			end
			button:SetDisabled( true )
			
			usergroupListView:SetPos( 25, 100 )
			usergroupListView:SetSize( 475, 500 )
			usergroupListView:SetMultiSelect( true )
			usergroupListView:AddColumn( "Usergroup(s)" )
			for key, value in pairs( team.GetAllTeams() ) do
				usergroupListView:AddLine( value['Name'] )
			end
			usergroupListView:SetSortable( true )
			usergroupListView.OnRowSelected = function( panel, line )
				if limitButton:GetDisabled() == true and usergroupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
					numSlider:SetVisible( true )
					button:SetDisabled( false )
				elseif usergroupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
					numSlider:SetVisible( false )
					button:SetDisabled( false )
				else
					numSlider:SetVisible( false )
					button:SetDisabled( true )
				end
			end
			
			dataListView:SetPos( 525, 100 )
			dataListView:SetSize( 450, 500 )
			dataListView:SetMultiSelect( true )
			dataListView:SetSortable( true )
			dataListView.OnRowSelected = function( panel, line )
				if limitButton:GetDisabled() == true and usergroupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
					numSlider:SetVisible( true )
					button:SetDisabled( false )
				elseif usergroupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
					numSlider:SetVisible( false )
					button:SetDisabled( false )
				else
					numSlider:SetVisible( false )
					button:SetDisabled( true )
				end
			end
			
			limitButton:SetPos( 25, 50 )
			limitButton:SetSize( 175, 30 )
			limitButton:SetText( "Change limit(s)" )
			limitButton.DoClick = function( button )
				limitButton:SetDisabled( true )
				blacklistButton:SetDisabled( false )
				whitelistButton:SetDisabled( false )
				numSlider:SetVisible( false )
				button:SetDisabled( true )
				dataListView:Clear()
				dataListView_Column:SetName("Convar(s)")
				for key, value in pairs( utilConvarList() ) do
					dataListView:AddLine( value )
				end
				dataListView:SortByColumn( 1 )
			end
			
			blacklistButton:SetPos( 225, 50 )
			blacklistButton:SetSize( 175, 30 )
			blacklistButton:SetText( "Blacklist weapon(s)" )
			blacklistButton.DoClick = function( button )
				blacklistButton:SetDisabled( true )
				limitButton:SetDisabled( false )
				whitelistButton:SetDisabled( false )
				numSlider:SetVisible( false )
				button:SetDisabled( true )
				dataListView:Clear()
				dataListView_Column:SetName("Weapon(s)")
				for key, value in pairs( utilWeaponsList() ) do
					dataListView:AddLine( value )
				end
				dataListView:SortByColumn( 1 )
			end

			whitelistButton:SetPos( 425, 50 )
			whitelistButton:SetSize( 175, 30 )
			whitelistButton:SetText( "Whitelist weapon(s)" )
			whitelistButton.DoClick = function( button )
				whitelistButton:SetDisabled( true )
				limitButton:SetDisabled( false )
				blacklistButton:SetDisabled( false )
				numSlider:SetVisible( false )
				button:SetDisabled( true )
				dataListView:Clear()
				dataListView_Column:SetName("Weapon(s)")
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