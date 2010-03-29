-----------------------------------------------------------------------
--The fuction to restart the server------------------------------------
-----------------------------------------------------------------------
local function restart
RunConsoleCommand("map", game.GetMap())
end




-----------------------------------------------------------------------
--Warning & action of first restart at 2:35 pm ------------------------
-----------------------------------------------------------------------

local function shedule1
MsgAll("Hello, it's 2:30pm. This server will automaticly restart in 5  minutes (2:35pm) for a routine cleanup. 
Please save your work and rejoin when the server is back up, Thank you")
end


schedule.Add("Warning1", shedule1, 00, 30, 14, "nil", nil, nil, nil)

schedule.Add("Restart", restart, 00, 35, 14, "nil", nil, nil, nil)




-----------------------------------------------------------------------
--Warning & action of second restart at 4:35 am -----------------------
-----------------------------------------------------------------------

local function shedule2
 MsgAll("Hello, it's 4:30am. This server will automaticly restart in 5  minutes (4:35am) for a routine cleanup. 
Please save your work and rejoin when the server is back up, Thank you")
end
 

schedule.Add("Warning2", shedule2, 00, 30, 4, "nil", nil, nil, nil)
schedule.Add("Restart", restart, 00, 35, 4, "nil", nil, nil, nil)