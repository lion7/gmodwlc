--[[
	Title: Hook

	Holds some hooks and their functions.
]]


--- Sends a hint to the player for 10 seconds if WLC is enabled. Also calls (function for spamcontrol).
function hookPlayerInitialSpawn( ply )
	if convarEnabled() then
		ply:SendHint("This server has Weapon and Limit Control in effect.", 10)
	end
end
hook.Add( "PlayerInitialSpawn", "wlcPlayerInitialSpawn", hookPlayerInitialSpawn )


--- Calls (function for spamcontrol).
function hookPlayerDisconnected( ply )
end
hook.Add( "PlayerDisconnected", "wlcPlayerDisconnected", hookPlayerDisconnected )


--- Validate if the picked up weapon is allowed. Returns a boolean.
function hookPlayerCanPickupWeapon( ply, weapon )
	if convarEnabled() then
		return weaponValidate(ply, weapon)
	else
		return true
	end
end
hook.Add( "PlayerCanPickupWeapon", "wlcPlayerCanPickupWeapon", hookPlayerCanPickupWeapon )
-- hook.Add( "PlayerGiveSWEP", "wlcPlayerGiveSWEP", hookPlayerCanPickupWeapon )


--- Add hooks so we can manage limits.
function hookInitialize()
	function GAMEMODE:PlayerSpawnRagdoll( ply, model )
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxragdolls" )
		else
			return false
		end
	end

	function GAMEMODE:PlayerSpawnProp( ply, model )
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxprops" )
		else
			return false
		end
	end

	function GAMEMODE:PlayerSpawnEffect( ply, model )
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxeffects" )
		else
			return false
		end
	end

	function GAMEMODE:PlayerSpawnVehicle( ply )
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxvehicles" )
		else
			return false
		end
	end

	-- function GAMEMODE:PlayerSpawnSENT( ply, name )
		-- if spamValidate( ply ) then
			-- return limitValidate( ply, "sbox_maxsents" )
		-- else
			-- return false
		-- end
	-- end

	function GAMEMODE:PlayerSpawnNPC( ply, npc_type, equipment )
		if spamValidate( ply ) then
			return limitValidate( ply, "sbox_maxnpcs" )
		else
			return false
		end
	end
end
hook.Add( "Initialize", "wlcInitialize", hookInitialize )
