--[[
	Title: Hook

	Holds some hooks and their functions.
]]


--- Sends a hint to the player for 10 seconds if WLC is enabled.
function hookPlayerInitialSpawn( player )
	if utilEnabled() then		
		player:SendHint("This server has weapon restrictions in effect.", 10)
	end
end
hook.Add( "PlayerInitialSpawn", "wcPlayerInitialSpawn", hookPlayerInitialSpawn )


--- Validate if the picked up weapon is allowed. Returns a boolean.
function hookPlayerCanPickupWeapon( player, weapon )
	if utilEnabled() then
		if wcValidateWeapon(player, weapon) then
			return true
		else
			return false
		end
	end
end
hook.Add( "PlayerCanPickupWeapon", "wcPlayerCanPickupWeapon", hookPlayerCanPickupWeapon )


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

	function GAMEMODE:PlayerSpawnSENT( ply, name )
		return lcValidateLimit( ply, "sbox_maxsents" )
	end

	function GAMEMODE:PlayerSpawnNPC( ply, npc_type, equipment )
		return lcValidateLimit( ply, "sbox_maxnpcs" )
	end
end
hook.Add( "Initialize", "lcInitialize", hookInitialize )
