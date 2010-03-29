-----------------------------------------------------------------------
--The fuction to restart the server------------------------------------
-----------------------------------------------------------------------
function lsRestart()
	RunConsoleCommand("map", game.GetMap())
end

function lsShedule()
	MsgAll("This server will automatically restart in 5 minutes for a routine cleanup. Please save your work and rejoin when the server is restarted. Thank you for your patience and have a nice time playing.")
	timer.Simple( 300, lsRestart )
end

-----------------------------------------------------------------------
-- Warning & action of first restart at 4:35 am -----------------------
-----------------------------------------------------------------------
schedule.Add("cleanup", lsShedule, 00, 30, 4, nil, nil, nil, nil)

-----------------------------------------------------------------------
-- Warning & action of second restart at 2:35 pm ----------------------
-----------------------------------------------------------------------
schedule.Add("cleanup", lsShedule, 00, 30, 14, nil, nil, nil, nil)

-- Test
schedule.Add("cleanup", lsShedule, 00, 30, 16, nil, nil, nil, nil)