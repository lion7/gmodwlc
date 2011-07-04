--[[
	Title: Hook

	Holds some hooks and their functions.
]]


--- Sends a hint to the player for 10 seconds if WLC is enabled. Also calls lcSpamProt_AddPlayer.
function hookPlayerInitialSpawn( ply )
	if convarEnabled() then
		ply:SendHint("This server has weapon restrictions in effect.", 10)
	end
end
hook.Add( "PlayerInitialSpawn", "wlcPlayerInitialSpawn", hookPlayerInitialSpawn )


--- Calls lcSpamProt_RemovePlayer.
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
			return false
		end
		
		return limitValidate( ply, "sbox_maxragdolls" )
	end

	function GAMEMODE:PlayerSpawnProp( ply, model )
		if spamValidate( ply ) then
			return false
		end
		
		if not utilAdminCheck(ply) and (model == "models/props_c17/oildrum001_explosive.mdl" or model == "models/props/de_train/biohazardtank.mdl") then
			ply:LimitHit("Explosive Barrel")
			return false
		end
		return limitValidate( ply, "sbox_maxprops" )
	end

	function GAMEMODE:PlayerSpawnEffect( ply, model )
		if spamValidate( ply ) then
			return false
		end
		
		return limitValidate( ply, "sbox_maxeffects" )
	end

	function GAMEMODE:PlayerSpawnVehicle( ply )
		if spamValidate( ply ) then
			return false
		end
		
		return limitValidate( ply, "sbox_maxvehicles" )
	end

	-- function GAMEMODE:PlayerSpawnSENT( ply, name )
		-- if spamValidate( ply ) then
			-- return false
		-- end
		
		-- return limitValidate( ply, "sbox_maxsents" )
	-- end

	function GAMEMODE:PlayerSpawnNPC( ply, npc_type, equipment )
		if spamValidate( ply ) then
			return false
		end
		
		return limitValidate( ply, "sbox_maxnpcs" )
	end
end
hook.Add( "Initialize", "wlcInitialize", hookInitialize )
