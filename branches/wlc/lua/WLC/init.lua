print( "-----------------------------------" )
print( "--   Weapon and Limits Control   --" )
print( "--         Made by Lion          --" )
print( "-----------------------------------" )
print( "-- Loading...                    --" )

-- Make sure clients download the initialize lua's.
AddCSLuaFile( "WLC/cl_init.lua" )
AddCSLuaFile( "autorun/wlc_init.lua" )

-- Execute the shared lua's
local files = file.FindInLua( "WLC/shared/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		include( "WLC/shared/" .. file )
		print("--  Executed: " .. "WLC/shared/" .. file )
	end
end

-- Execute the server lua's
local files = file.FindInLua( "WLC/server/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		include( "WLC/server/" .. file )
		print("--  Executed: " .. "WLC/server/" .. file )
	end
end

-- Add the shared lua's to the client
local files = file.FindInLua( "WLC/shared/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		AddCSLuaFile( "WLC/shared/" .. file )
		print("--  Added to client: " .. "WLC/shared/" .. file )
	end
end

-- Add the client lua's to the client
local files = file.FindInLua( "WLC/client/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		AddCSLuaFile( "WLC/client/" .. file )
		print("--  Added to client: " .. "WLC/client/" .. file )
	end
end

print( "-- Loading Complete!             --" )
print( "--                               --" )
print( "-- Validating tables...          --" )
tableValidation = sqlValidateTables()
for key, value in pairs( tableValidation ) do
	print( value )
end
print( "-- Validation Complete...        --" )
print( "-----------------------------------" )