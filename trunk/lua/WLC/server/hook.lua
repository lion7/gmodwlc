--[[
	Title: Hook

	Holds some hooks and their functions.
]]


--- Sends a hint to the player for 10 seconds if WLC is enabled. Also calls lcSpamProt_AddPlayer.
function hookPlayerInitialSpawn( ply )
	if convarEnabled() then
		ply:SendHint("This server has weapon restrictions in effect.", 10)
	end
	scAddPlayer( ply )
end
hook.Add( "PlayerInitialSpawn", "wcPlayerInitialSpawn", hookPlayerInitialSpawn )


--- Calls lcSpamProt_RemovePlayer.
function hookPlayerDisconnected( ply )
	scRemovePlayer( ply )	
end
hook.Add( "PlayerDisconnected", "wcPlayerDisconnected", hookPlayerDisconnected )


--- Validate if the picked up weapon is allowed. Returns a boolean.
function hookPlayerCanPickupWeapon( ply, weapon )
	if convarEnabled() then
		return wcValidateWeapon(ply, weapon)
	else
		return true
	end
end
hook.Add( "PlayerCanPickupWeapon", "wcPlayerCanPickupWeapon", hookPlayerCanPickupWeapon )
hook.Add( "PlayerGiveSWEP", "wcPlayerGiveSWEP", hookPlayerCanPickupWeapon )


--- Add hooks so we can manage limits.
function hookInitialize()
	function GAMEMODE:PlayerSpawnRagdoll( ply, model )
		return lcValidateLimit( ply, "sbox_maxragdolls" )
	end

	function GAMEMODE:PlayerSpawnProp( ply, model )
		return lcValidateLimit( ply, "sbox_maxprops" )
	end

	function GAMEMODE:PlayerSpawnEffect( ply, model )
		return lcValidateLimit( ply, "sbox_maxeffects" )
	end

	function GAMEMODE:PlayerSpawnVehicle( ply )
		return lcValidateLimit( ply, "sbox_maxvehicles" )
	end

	-- function GAMEMODE:PlayerSpawnSENT( ply, name )
		-- return lcValidateLimit( ply, "sbox_maxsents" )
	-- end

	function GAMEMODE:PlayerSpawnNPC( ply, npc_type, equipment )
		return lcValidateLimit( ply, "sbox_maxnpcs" )
	end
end
hook.Add( "Initialize", "lcInitialize", hookInitialize )
