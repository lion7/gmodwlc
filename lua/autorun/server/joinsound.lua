resource.AddFile( "sound/custom/lion_roar.mp3" )

function jsJoinSound( ply )
	if tostring(ply:SteamID()) == "STEAM_0:1:15924980" then
		ply:EmitSound("custom/lion_roar.mp3", 500, 100)
	end
end
hook.Add( "PlayerInitialSpawn", "jsPlayerInitialSpawn", jsJoinSound )