-----------------------------------------------------------------------
--The fuction to restart the server------------------------------------
-----------------------------------------------------------------------
function lsWarningRestart()
	message = "This server will automatically restart in 5 minutes for a routine cleanup. Please save your work and rejoin when the server is restarted. Thank you for your patience and have a nice time playing."
	for key, value in pairs(player.GetAll()) do
		value:PrintMessage( HUD_PRINTTALK , message )
	end
	timer.Simple( 300, lsExecuteRestart )
end

function lsExecuteRestart()
	RunConsoleCommand("map", "gm_construct_flatgrass_v5")
	--RunConsoleCommand("map", game.GetMap())
end

function lsScheduleRestarts()
	-----------------------------------------------------------------------
	-- Warning & action of first restart at 4:35 am -----------------------
	-----------------------------------------------------------------------
	lsScheduleFunc(lsWarningRestart, 4,30,00)

	-----------------------------------------------------------------------
	-- Warning & action of second restart at 2:35 pm ----------------------
	-----------------------------------------------------------------------
	lsScheduleFunc(lsWarningRestart, 14,30,00)
	
	todaysTimestamp = (((tonumber(os.date("%H")) * 60) + tonumber(os.date("%M"))) * 60) + tonumber(os.date("%S"))
	timer.Simple( 86400 - todaysTimestamp + 60, lsScheduleRestarts )
end

function lsScheduleFunc( func, hour, minute, second )
	todaysTimestamp = (((tonumber(os.date("%H")) * 60) + tonumber(os.date("%M"))) * 60) + tonumber(os.date("%S"))
	targetTimestamp = (((hour * 60) + minute) * 60) + second
	difference = targetTimestamp - todaysTimestamp
	
	if difference > 0 then
		timer.Simple( difference, func )
		print(os.date("%H:%M:%S") .. " - Scheduler: Successfully scheduled " .. tostring(func) .. " at " .. hour .. ":" .. minute .. ":" .. second .. ".")
	else
		print(os.date("%H:%M:%S") .. " - Scheduler: Error while scheduling " .. tostring(func) .. " at " .. hour .. ":" .. minute .. ":" .. second .. ".")
	end
end