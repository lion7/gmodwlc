--[[
	Title: SQL

	Holds helpful SQL functions.
]]


--- Returns a string array.
function sqlValidateTables()
	local returnString = {}

	if sqlValidateWeaponsTable() then
		table.insert(returnString, "--  Table wlc_weapons is valid   --")
	else		
		table.insert(returnString, "--  Table wlc_weapons is invalid --")
	end
	
	if sqlValidateLimitsTable() then
		table.insert(returnString, "--  Table wlc_limits is valid    --")
	else		
		table.insert(returnString, "--  Table wlc_limits is invalid  --")
	end
	
	return returnString
end


--- Returns a string array.
function sqlCreateTables()
	local returnString = {}
	
	if sqlCreateWeaponsTable() then
		table.insert(returnString, "--  Table wlc_weapons created    --")
	else		
		table.insert(returnString, "--  Table wlc_weapons not created--")
	end
	
	if sqlCreateLimitsTable() then
		table.insert(returnString, "--  Table wlc_limits created     --")
	else		
		table.insert(returnString, "--  Table wlc_limits not created --")
	end
	
	return returnString
end


--- Returns a string array.
function sqlDeleteTables()
	local returnString = {}
	
	if sqlDeleteWeaponsTable() then
		table.insert(returnString, "--  Table wlc_weapons deleted    --")
	else		
		table.insert(returnString, "--  Table wlc_weapons not deleted--")
	end
	
	if sqlDeleteLimitsTable() then
		table.insert(returnString, "--  Table wlc_limits deleted     --")
	else		
		table.insert(returnString, "--  Table wlc_limits not deleted --")
	end
	
	return returnString
end


--- Returns a boolean.
function sqlValidateWeaponsTable()
	if !sql.TableExists("wlc_weapons") then
		return false
	end
	
	query = "PRAGMA table_info(wlc_weapons);"
	pragmaResult = sql.Query(query)
	for column in pairs( pragmaResult ) do
		if column['name'] != "usergroup" and column['name'] != "weapon" then
			return false
		end
	end
	
	return true
end


--- Returns a boolean.
function sqlValidateLimitsTable()
	if !sql.TableExists("wlc_limits") then
		return false
	end
	
	query = "PRAGMA table_info(wlc_limits);"
	pragmaResult = sql.Query(query)
	for column in pairs( pragmaResult ) do
		if column['name'] != "usergroup" and column['name'] != "convar" and column['name'] != "maxlimit" then
			return false
		end
	end
	
	return true
end


--- Returns a boolean.
function sqlCreateWeaponsTable()
	if sql.TableExists("wlc_weapons") then
		return false
	end
	
	query = "CREATE TABLE wlc_weapons( usergroup VARCHAR(255) NOT NULL, weapon VARCHAR(255) NOT NULL, PRIMARY KEY(usergroup, weapon) );"
	createResult = sql.Query(query)
	if sql.TableExists("wlc_weapons") then
		return true
	else
		return false
	end	
end


--- Returns a boolean.
function sqlCreateLimitsTable()
	if sql.TableExists("wlc_limits") then
		return false
	end
	
	query = "CREATE TABLE wlc_limits( usergroup VARCHAR(255) NOT NULL, convar VARCHAR(255) NOT NULL, maxlimit INT NOT NULL, PRIMARY KEY(usergroup, convar) );"
	createResult = sql.Query(query)
	if sql.TableExists("wlc_limits") then
		return true
	else
		return false
	end	
end


--- Returns a boolean.
function sqlDeleteWeaponsTable()
	if !sql.TableExists("wlc_weapons") then
		return false
	end
	
	query = "DROP TABLE wlc_weapons;"
	createResult = sql.Query(query)
	if !sql.TableExists("wlc_weapons") then
		return true
	else
		return false
	end	
end


--- Returns a boolean.
function sqlDeleteLimitsTable()
	if !sql.TableExists("wlc_limits") then
		return false
	end
	
	query = "DROP TABLE wlc_limits;"
	deleteResult = sql.Query(query)
	if !sql.TableExists("wlc_limits") then
		return true
	else
		return false
	end	
end



--- Returns a sql result.
function sqlSelectWeaponsUsergroups()		
	query = "SELECT usergroup FROM wlc_weapons ORDER BY usergroup DESC;"
	result = sql.Query(query)	
	
	return result
end


--- Returns a sql result.
function sqlSelectWeaponsEntry(usergroup, weapon)	
	if convar == nil then
		query = "SELECT * FROM wlc_weapons WHERE usergroup = '" .. usergroup .. "';"
	else
		query = "SELECT * FROM wlc_weapons WHERE usergroup = '" .. usergroup .. "' AND weapon = '" .. weapon .. "';"
	end
	result = sql.Query(query)
	
	return result
end


--- Returns a boolean.
function sqlWriteWeaponsEntry(usergroup, weapon)	
	if sqlSelectWeaponsEntry(usergroup, weapon) == nil then	
		query = "INSERT INTO wlc_weapons( usergroup, weapon ) VALUES ( '" .. usergroup .. "', '" .. weapon .. "' );"
		sql.Query(query)
		
		if sqlSelectWeaponsEntry(usergroup, weapon) == nil then
			return false
		else
			return true
		end
	else
		return false
	end
end


--- Returns a boolean.
function sqlDeleteWeaponsEntry(usergroup, weapon)	
	if weapon == nil then
		query = "DELETE FROM wlc_weapons WHERE usergroup = '" .. usergroup .. "';"
	else
		query = "DELETE FROM wlc_weapons WHERE usergroup = '" .. usergroup .. "' AND weapon = '" .. weapon .. "';"
	end
	sql.Query(query)
	
	if sqlSelectWeaponsEntry(usergroup, weapon) == nil then
		return true
	else
		return false
	end
end


--- Returns a sql result.
function sqlSelectLimitUsergroups()		
	query = "SELECT usergroup FROM wlc_limits ORDER BY usergroup DESC;"
	result = sql.Query(query)	
	return result
end


--- Returns a sql result.
function sqlSelectLimitEntry(usergroup, convar)
	if convar == nil then
		query = "SELECT * FROM wlc_limits WHERE usergroup = '" .. usergroup .. "';"
	else
		query = "SELECT * FROM wlc_limits WHERE usergroup = '" .. usergroup .. "' AND convar = '" .. convar .. "';"
	end
	result = sql.Query(query)
	return result
end


--- Returns a boolean.
function sqlWriteLimitEntry(usergroup, convar, maxlimit)
	if sqlSelectLimitEntry(usergroup, convar) == nil then
		query = "INSERT INTO wlc_limits( usergroup, convar, maxlimit ) VALUES ( '" .. usergroup .. "', '" .. convar .. "', '" .. tostring(maxlimit) .. "' );"
		sql.Query(query)
		if sqlSelectLimitEntry(usergroup, convar) == nil then
			return false
		else
			return true
		end
	else
		query = "UPDATE wlc_limits SET maxlimit = '" .. tostring(maxlimit) .. "' WHERE usergroup = '" .. usergroup .. "' AND convar = '" .. convar .. "';"
		sql.Query(query)
		limitEntry = sqlSelectLimitEntry(usergroup, convar)
		
		if tonumber(limitEntry[1]['maxlimit']) == maxlimit then
			return true
		else
			return false
		end
	end
end


--- Returns a boolean.
function sqlDeleteLimitEntry(usergroup, convar)
	if convar == nil then
		query = "DELETE FROM wlc_limits WHERE usergroup = '" .. usergroup .. "';"
	else
		query = "DELETE FROM wlc_limits WHERE usergroup = '" .. usergroup .. "' AND convar = '" .. convar .. "';"
	end
	sql.Query(query)
	if sqlSelectLimitEntry(usergroup, convar) == nil then
		return true
	else
		return false
	end
end