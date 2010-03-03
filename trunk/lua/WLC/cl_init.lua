print( "This server is running WLC version 1.0" )

-- Execute the shared lua's
local files = file.FindInLua( "WLC/shared/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		include( "WLC/shared/" .. file )
	end
end

-- Execute the client lua's
local files = file.FindInLua( "WLC/client/*.lua" )
if #files > 0 then
	for key, file in ipairs( files ) do
		include( "WLC/client/" .. file )
	end
end