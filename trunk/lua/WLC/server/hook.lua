--[[
	Title: Hook

	Holds some hooks and their functions.
]]


function hookPlayerInitialSpawn( player )
	if utilEnabled() then		
		player:SendHint("This server has weapon restrictions in effect.", 10)
	end
end
hook.Add( "PlayerInitialSpawn", "wcPlayerInitialSpawn", hookPlayerInitialSpawn )


--- Returns a boolean.
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

function hookInitialize()
	if utilEnabled() then
		-- ---------------------------------------------------------
		--   Name: gamemode:PlayerSpawnRagdoll( ply, model )
		--   Desc: Return true if it's allowed
		-- ---------------------------------------------------------
		function GAMEMODE:PlayerSpawnRagdoll( ply, model )
			return lcValidateLimit( ply, "sbox_maxragdolls" )
		end


		-- ---------------------------------------------------------
		--   Name: gamemode:PlayerSpawnProp( ply, model )
		--   Desc: Return true if it's allowed
		-- ---------------------------------------------------------
		function GAMEMODE:PlayerSpawnProp( ply, model )
			return lcValidateLimit( ply, "sbox_maxprops" )
		end


		-- ---------------------------------------------------------
		--   Name: gamemode:PlayerSpawnEffect( ply, model )
		--   Desc: Return true if it's allowed
		-- ---------------------------------------------------------
		function GAMEMODE:PlayerSpawnEffect( ply, model )
			return lcValidateLimit( ply, "sbox_maxeffects" )
		end

		-- ---------------------------------------------------------
		--   Name: gamemode:PlayerSpawnVehicle( ply )
		--   Desc: Return true if it's allowed
		-- ---------------------------------------------------------
		function GAMEMODE:PlayerSpawnVehicle( ply )
			return lcValidateLimit( ply, "sbox_maxvehicles" )
		end

		-- ---------------------------------------------------------
		--   Name: gamemode:PlayerSpawnSENT( ply, name )
		--   Desc: Return true if player is allowed to spawn the SENT
		-- ---------------------------------------------------------
		-- Commented out since it now just always returns true. This may change some day...year...etc
		-- function GAMEMODE:PlayerSpawnSENT( ply, name )
		--
		-- 	return lcValidateLimit( ply, "sbox_maxsents" )
		--
		-- end
		--

		-- ---------------------------------------------------------
		--   Name: gamemode:PlayerSpawnNPC( ply, npc_type )
		--   Desc: Return true if player is allowed to spawn the NPC
		-- ---------------------------------------------------------
		function GAMEMODE:PlayerSpawnNPC( ply, npc_type, equipment )
			return lcValidateLimit( ply, "sbox_maxnpcs" )
		end
	end
end

hook.Add( "Initialize", "lcInitialize", hookInitialize )
