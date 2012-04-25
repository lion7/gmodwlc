resource.AddFile( "sound/custom/lion_roar.mp3" )

function lsJoinAction( ply )
	if ply:IsSuperAdmin() then
   ply:ChatPrint("Welcome " .. ply:Name() .. ". Enjoy your ub3rl33t superadmin p0w4zzz.") 
   ply:EmitSound("custom/lion_roar.mp3", 500, 100)
	end
end
hook.Add( "PlayerInitialSpawn", "lsPlayerInitialSpawn", lsJoinAction )