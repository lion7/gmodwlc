--[[
	Title: GUI

	Holds the GUI.
]]
 

--- Gets called by the server if someone typed 'rcon wlc gui' in the console.
function wlcGuiShow( )
	local dermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself			
	local button = vgui.Create( "DButton", dermaPanel )
	local numSlider = vgui.Create( "DNumSlider", dermaPanel )
	local groupListView = vgui.Create( "DListView", dermaPanel )
	local dataListView = vgui.Create( "DListView", dermaPanel )
	local dataListView_Column = dataListView:AddColumn( " " )
	local limitButton = vgui.Create( "DButton", dermaPanel )
	local addWeaponButton = vgui.Create( "DButton", dermaPanel )
	local removeWeaponButton = vgui.Create( "DButton", dermaPanel )
	
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
			for key1, value1 in pairs( groupListView:GetSelected() ) do
				for key2, value2 in pairs( dataListView:GetSelected() ) do
					RunConsoleCommand( "wlc", "setlimit", value1:GetValue(1), value2:GetValue(1), numSlider:GetValue() )
				end
			end
		elseif addWeaponButton:GetDisabled() == true then
			for key1, value1 in pairs( groupListView:GetSelected() ) do
				for key2, value2 in pairs( dataListView:GetSelected() ) do
					RunConsoleCommand( "wlc", "addweapon", value1:GetValue(1), value2:GetValue(1) )
				end
			end
		elseif removeWeaponButton:GetDisabled() == true then
			for key1, value1 in pairs( groupListView:GetSelected() ) do
				for key2, value2 in pairs( dataListView:GetSelected() ) do
					RunConsoleCommand( "wlc", "removeweapon", value1:GetValue(1), value2:GetValue(1) )
				end
			end
		end
	end
	button:SetDisabled( true )
	
	groupListView:SetPos( 25, 100 )
	groupListView:SetSize( 475, 500 )
	groupListView:SetMultiSelect( true )
	groupListView:AddColumn( "Group(s)" )
	for key, value in pairs( utilGroupList() ) do
		groupListView:AddLine( value )
	end
	groupListView:SetSortable( true )
	groupListView.OnRowSelected = function( panel, line )
		if limitButton:GetDisabled() == true and groupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
			numSlider:SetVisible( true )
			button:SetDisabled( false )
		elseif groupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
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
		if limitButton:GetDisabled() == true and groupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
			numSlider:SetVisible( true )
			button:SetDisabled( false )
		elseif groupListView:GetSelected() != nil and dataListView:GetSelected() != nil then
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
		addWeaponButton:SetDisabled( false )
		removeWeaponButton:SetDisabled( false )
		numSlider:SetVisible( false )
		button:SetDisabled( true )
		dataListView:Clear()
		dataListView_Column:SetName("Convar(s)")
		for key, value in pairs( utilConvarListSupported() ) do
			dataListView:AddLine( value )
		end
		dataListView:SortByColumn( 1 )
	end
	
	addWeaponButton:SetPos( 225, 50 )
	addWeaponButton:SetSize( 175, 30 )
	addWeaponButton:SetText( "Add weapon(s)" )
	addWeaponButton.DoClick = function( button )
		addWeaponButton:SetDisabled( true )
		limitButton:SetDisabled( false )
		removeWeaponButton:SetDisabled( false )
		numSlider:SetVisible( false )
		button:SetDisabled( true )
		dataListView:Clear()
		dataListView_Column:SetName("Weapon(s)")
		for key, value in pairs( utilWeaponListSupported() ) do
			dataListView:AddLine( value )
		end
		dataListView:SortByColumn( 1 )
	end

	removeWeaponButton:SetPos( 425, 50 )
	removeWeaponButton:SetSize( 175, 30 )
	removeWeaponButton:SetText( "Remove weapon(s)" )
	removeWeaponButton.DoClick = function( button )
		removeWeaponButton:SetDisabled( true )
		limitButton:SetDisabled( false )
		addWeaponButton:SetDisabled( false )
		numSlider:SetVisible( false )
		button:SetDisabled( true )
		dataListView:Clear()
		dataListView_Column:SetName("Weapon(s)")
		for key, value in pairs( utilWeaponListSupported() ) do
			dataListView:AddLine( value )
		end
		dataListView:SortByColumn( 1 )
	end
end