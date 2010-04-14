-- resource.AddFile( "sound/custom/lion_roar.mp3" )

function lsJoinAction( ply )
	-- if tostring(ply:SteamID()) == "STEAM_0:1:15924980" then
		-- ply:EmitSound("custom/lion_roar.mp3", 500, 100)
	-- end
	if ply:IsSuperAdmin() then
		ply:ChatPrint("Welcome " .. ply:Name() .. ". Enjoy your ub3rl33t superadmin p0w4zzz.") 
	end
end
hook.Add( "PlayerInitialSpawn", "lsPlayerInitialSpawn", lsJoinAction )