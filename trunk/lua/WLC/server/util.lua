--[[
	Title: Utilities

	Holds helpful utility functions.
]]


-- local wlc_enabled = true


--- Checks if the player has access to this script. Returns a boolean.
function utilAdminCheck( player )
	if player:IsValid() then	
		for key, value in pairs( convarAdminGroups() ) do
			if player:IsUserGroup(value) then 
				return true
			end
		end
	end
	
	return true
end


-- --- Checks if the script is enabled/disabled. Returns a boolean.
-- function utilIsEnabled() 
	-- return wlc_enabled
-- end


-- --- Enables/disables the script. Returns a string.
-- function utilSetEnabled( bool ) 
	-- if bool then
		-- if wlc_enabled == false then
			-- wlc_enabled = true
			-- return "WLC is now enabled."
		-- else		
			-- return "WLC is already enabled."
		-- end
	-- elseif bool == false then
		-- if wlc_enabled then
			-- wlc_enabled = false
			-- return "WLC is now disabled."
		-- else		
			-- return "WLC is already disabled."
		-- end
	-- end
-- end