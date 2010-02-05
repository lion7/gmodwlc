print( "-----------------------------------" )
print( "--   Weapon and Limits Control   --" )
print( "--         Made by Lion          --" )
print( "-----------------------------------" )
print( "-- Loading...                    --" )
print( "--  shared/util.lua              --" )
	include( "WLC/shared/util.lua" )
print( "--  server/sql.lua               --" )
	include( "WLC/server/sql.lua" )
print( "--  server/convar.lua            --" )
	include( "WLC/server/convar.lua" )
print( "--  server/concommand.lua        --" )
	include( "WLC/server/concommand.lua" )
print( "--  server/hook.lua              --" )
	include( "WLC/server/hook.lua" )
print( "--  server/weaponcontrol.lua     --" )
	include( "WLC/server/weaponcontrol.lua" )
print( "--  server/limitcontrol.lua      --" )
	include( "WLC/server/limitcontrol.lua" )
print( "-- Loading Complete!             --" )
print( "-- Validating tables...          --" )
tableValidation = sqlValidateTables()
for key, value in pairs( tableValidation ) do
	print( value )
end
print( "-- Validation Complete...        --" )
print( "-- Adding client files...        --" )

-- Make sure clients download the initialize lua's.
AddCSLuaFile( "WLC/cl_init.lua" )
AddCSLuaFile( "autorun/wlc_init.lua" )
	
-- Make sure clients download the shared lua's
local files = file.FindInLua( "WLC/shared/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		AddCSLuaFile( "WLC/shared/" .. file .. " --" )
	end
end

-- Make sure clients download the client lua's
local files = file.FindInLua( "WLC/client/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		AddCSLuaFile( "WLC/client/" .. file )
		print("--  Added: " .. "WLC/client/" .. file .. " --" )
	end
end
print( "-----------------------------------" )