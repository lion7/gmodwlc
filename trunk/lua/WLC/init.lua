Msg( "-------------------------------\n" )
Msg( "-- Weapon and Limits Control --\n" )
Msg( "--       Made by Lion        --\n" )
Msg( "-------------------------------\n" )
Msg( "-- Loading...                --\n" )
Msg( "--  server/util.lua          --\n" )
	include( "WLC/server/util.lua" )
Msg( "--  server/sql.lua           --\n" )
	include( "WLC/server/sql.lua" )
Msg( "--  server/convar.lua    --\n" )
	include( "WLC/server/convar.lua" )
Msg( "--  server/concommand.lua    --\n" )
	include( "WLC/server/concommand.lua" )
Msg( "--  server/hook.lua          --\n" )
	include( "WLC/server/hook.lua" )
Msg( "--  server/weaponcontrol.lua --\n" )
	include( "WLC/server/weaponcontrol.lua" )
Msg( "--  server/limitcontrol.lua  --\n" )
	include( "WLC/server/limitcontrol.lua" )
Msg( "-- Loading Complete!         --\n" )
Msg( "-- Validating tables...      --\n" )
Msg( sqlValidateTables() )
Msg( "-- Validation Complete...    --\n" )
Msg( "-------------------------------\n" )

-- Make sure clients download the initialize lua's.
AddCSLuaFile( "WLC/cl_init.lua" )
AddCSLuaFile( "autorun/wlc_init.lua" )
	
-- -- Make sure clients download the shared lua's
-- local files = file.FindInLua( "WLC/shared/*.lua" )
-- if #files > 0 then
	-- for _, file in ipairs( files ) do
		-- AddCSLuaFile( "WLC/shared/" .. file )
	-- end
-- end

-- -- Make sure clients download the client lua's
-- local files = file.FindInLua( "WLC/client/*.lua" )
-- if #files > 0 then
	-- for _, file in ipairs( files ) do
		-- AddCSLuaFile( "WLC/client/" .. file )
	-- end
-- end