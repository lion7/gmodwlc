-- ---------------------------------------------------------
--   Name: Boomer
--   Author: Lion
--   Description: Can only be spawned by Admin's. This SWEP creates an explosion where you're aiming. The explosion is powerful enough to kill most players/NPC's in 1 shot.
-- ---------------------------------------------------------

if ( SERVER ) then

	AddCSLuaFile ("shared.lua");
	
	SWEP.HoldType			= "pistol"
	
end

if ( CLIENT ) then
 
	SWEP.PrintName 			= "Boomer"
	SWEP.Author 			= "Lion"
	SWEP.Purpose 			= "Blow up stuff!"
	SWEP.Instructions 		= "Primary fire to make something go BOOM!"

	SWEP.Slot 				= 1
	SWEP.SlotPos 			= 4
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= true
	
end

local boomer_magnitude = CreateConVar( "boomer_magnitude", "300", { FCVAR_REPLICATED, FCVAR_NOTIFY } )

SWEP.Category = "Lion's SWEPS"
 
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
 
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.PrimarySound 			= Sound("weapon_AWP.Single")	--the sound when the weapon is fired
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 100
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize 		= 6
SWEP.Primary.Delay 			= 1 							--this sets the delay for the next primary fire.
SWEP.Primary.DefaultClip 	= 12
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "357"

SWEP.ExplosionMagnitude 	= boomer_magnitude:GetInt()		--the magnitude of the explosion
SWEP.ExplosionSound 		= Sound("")						--the sound for the explosion
SWEP.ExplosionSoundVolume 	= boomer_magnitude:GetInt()	* 3 --how hard it can be heard
SWEP.ExplosionSoundDistance = boomer_magnitude:GetInt()	* 2	-- how far away it can be heard

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"


--------------------------------------------
-- Called when it reloads 
--------------------------------------------
function SWEP:Reload()
	-- All reload code goes in here
	self.Weapon:DefaultReload( ACT_VM_RELOAD ) --animation for reloading
end
 
 
--------------------------------------------
-- Called each frame when the Swep is active
--------------------------------------------
function SWEP:Think()
 
end
 
 
--------------------------------------------
-- Called when its holstered
--------------------------------------------
function SWEP:Holster()
return true --Allow the weapon to be holstered
end
 
 
--------------------------------------------
-- Called when its deployed
--------------------------------------------
function SWEP:Deploy()
return true --Allow the weapon to be deployed
end

 
--------------------------------------------
-- Called when the player Shoots (Primary)
--------------------------------------------
function SWEP:PrimaryAttack()
	-- Any Code you want to be executed when the player uses primary attack goes in here
	
	-- Make sure we can shoot first
	if ( !self:CanPrimaryAttack() ) then return end
 
	local eyetrace = nil
	eyetrace = self.Owner:GetEyeTrace()
	-- this gets where you are looking. The SWEP is making an explosion where you are LOOKING, right?
 
	self.Weapon:EmitSound ( self.PrimarySound )
	-- this makes the sound, which I specified earlier in the code
 
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	--this makes the shooting animation for the 357
 
	local explode = nil
	explode = ents.Create("env_explosion") --creates the explosion
	explode:SetPos( eyetrace.HitPos ) --this creates the explosion where you were looking
	--explode:SetPhysicsAttacker( self.Owner ) -- this sets you as the person who made the explosion
	explode:Spawn() --this actually spawns the explosion
	explode:SetKeyValue( "iMagnitude", self.ExplosionMagnitude ) --the magnitude of the explosion
	explode:Fire( "Explode", "", 0 )
	explode:EmitSound( self.ExplosionSound, self.ExplosionSoundVolume, self.ExplosionSoundDistance ) --the sound for the explosion, and how far away it can be heard
 
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) --this sets the delay for the next primary fire.
 
	self:TakePrimaryAmmo(1) --removes 1 ammo from our primary clip
end


--------------------------------------------
-- Called when the player Shoots (Secondary)
--------------------------------------------
function SWEP:SecondaryAttack()
end