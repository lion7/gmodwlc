--[[
	Title: Hook

	Holds some hooks and their functions.
]]


function hookPlayerInitialSpawn( player )
	if convarEnabled() then		
		player:SendHint("This server has weapon restrictions in effect.", 10)
	end
end
hook.Add( "PlayerInitialSpawn", "wcPlayerInitialSpawn", hookPlayerInitialSpawn )


function hookPlayerCanPickupWeapon( player, weapon )
	if convarEnabled() then		
		if wcValidateWeapon(player, weapon) == false then
			weapon:Remove()
			return false
		end
	end
end
hook.Add( "PlayerCanPickupWeapon", "wcPlayerCanPickupWeapon", hookPlayerCanPickupWeapon )

function hookInitialize()
	if convarEnabled() then
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
		-- Commented out since Garry's now just always returns true. This may change some day...year...etc
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

		-- local meta = FindMetaTable( "Player" )
		-- -- Return if there's nothing to add on to
		-- if (!meta) then return end

		-- function meta:CheckLimit( str )
			-- -- No limits in single player
			-- if (SinglePlayer()) then return true end

			-- local c = server_settings.Int( "sbox_max"..str, 0 )

			-- if self:IsAdmin() or self:IsSuperAdmin() then
				-- return true
			-- end

			-- if ( c < 0 ) then return true end
			-- if ( self:GetCount( str ) > c-1 ) then self:LimitHit( str ) return false end

			-- return true
		-- end
	end
end

hook.Add( "Initialize", "lcInitialize", hookInitialize )
