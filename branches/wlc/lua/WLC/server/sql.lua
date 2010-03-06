--[[
	Title: SQL

	Holds helpful SQL functions.
]]

--- Returns a string array.
function sqlValidateTables()
	local returnString = {}

	if !sql.TableExists("wlc_weapons") then
		query = "CREATE TABLE wlc_weapons( usergroup VARCHAR(255) NOT NULL, weapons VARCHAR(255) NOT NULL, whitelist BOOLEAN NOT NULL, PRIMARY KEY(usergroup) );"
		createResult = sql.Query(query)
		if sql.TableExists("wlc_weapons") then
			table.insert(returnString, "--  Table wlc_weapons created    --")
		else
			table.insert(returnString, "Something went wrong with creating the wlc_weapons table!")
			table.insert(returnString, sql.LastError( createResult ))
		end	
	else
		table.insert(returnString, "--  Table wlc_weapons exists     --")
	end
	
	if !sql.TableExists("wlc_limits") then
		query = "CREATE TABLE wlc_limits( usergroup VARCHAR(255) NOT NULL, convar VARCHAR(255) NOT NULL, maxlimit INT NOT NULL, PRIMARY KEY(usergroup, convar) );"
		createResult = sql.Query(query)
		if sql.TableExists("wlc_limits") then
			table.insert(returnString, "--  Table wlc_limits created     --")
		else
			table.insert(returnString, "Something went wrong with creating the wlc_limits table!")
			table.insert(returnString, sql.LastError( createResult ))
		end	
	else
		table.insert(returnString, "--  Table wlc_limits exists      --")
	end
	
	return returnString
end

--- Returns a string array.
function sqlRemoveTables()
	local returnString = {}

	if sql.TableExists("wlc_weapons") then
		query = "DROP TABLE wlc_weapons;"
		deleteResult = sql.Query(query)
		if !sql.TableExists("wlc_weapons") then
			table.insert(returnString, "--  Table wlc_weapons deleted    --")
		else
			table.insert(returnString, "Something went wrong when deleting the wlc_weapons table!")
			table.insert(returnString, sql.LastError( deleteResult ))
		end	
	else
		table.insert(returnString, "--Table wlc_weapons doesn't exist--")
	end
	
	if sql.TableExists("wlc_limits") then
		query = "DROP TABLE wlc_limits;"
		deleteResult = sql.Query(query)
		if !sql.TableExists("wlc_limits") then
			table.insert(returnString, "--  Table wlc_limits deleted     --")
		else
			table.insert(returnString, "Something went wrong when deleting the wlc_limits table!")
			table.insert(returnString, sql.LastError( deleteResult ))
		end	
	else				    
		table.insert(returnString, "--Table wlc_limits doesn't exist --")
	end 
	
	return returnString
end



--- Returns a sql result.
function sqlSelectWeaponsUsergroups()		
	query = "SELECT usergroup FROM wlc_weapons ORDER BY usergroup DESC;"
	result = sql.Query(query)	
	return result
end

--- Returns a sql result.
function sqlSelectWeaponsEntry(usergroup)		
	query = "SELECT * FROM wlc_weapons WHERE usergroup = '" .. usergroup .. "';"
	result = sql.Query(query)	
	return result
end

--- Returns a boolean.
function sqlWriteWeaponsEntry(usergroup, weapons, whitelist)	
	if sqlSelectWeaponsEntry(usergroup) == nil then	
		query = "INSERT INTO wlc_weapons( usergroup, weapons, whitelist ) VALUES ( '" .. usergroup .. "', '" .. weapons .. "', '" .. tostring(whitelist) .. "' );"
		sql.Query(query)
		if sqlSelectWeaponsEntry(usergroup) == nil then
			return false
		else
			return true
		end
	else
		query = "UPDATE wlc_weapons SET weapons = '" .. weapons .. "', whitelist = '" .. tostring(whitelist) .. "' WHERE usergroup = '" .. usergroup .. "';"
		sql.Query(query)
		weaponEntry = sqlSelectWeaponsEntry(usergroup)
		if weaponEntry[1]['weapons'] == weapons or weaponEntry[1]['whitelist'] == tostring(whitelist) then
			return true
		else
			return false
		end
	end
end

--- Returns a boolean.
function sqlDeleteWeaponsEntry(usergroup)	
	query = "DELETE FROM wlc_weapons WHERE usergroup = '" .. usergroup .. "';"
	sql.Query(query)
	if sqlSelectWeaponsEntry(usergroup) == nil then
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