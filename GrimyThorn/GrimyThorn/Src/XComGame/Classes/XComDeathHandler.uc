//---------------------------------------------------------------------------------------
//  FILE:    XComDeathHandler.uc
//  AUTHOR:  Ryan McFall  --  03/10/2010
//  PURPOSE: This object owns settings specific to character deaths, and is responsible
//           for controlling the character's death
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class XComDeathHandler extends Object;

struct DeathElement
{
	var() class<DamageType> DamageTypeClass<ToolTip="The type of damage for this death sequence">; 	
	var() bool bCreateBloodPool<ToolTip="Determine whether death by this type of damage will leave a blood pool">;	
	
	var() bool bUseProjectileAlignedEffect<ToolTip="Choose whether to attach an effect from ProjectileAlignedEffect to the character, aligned to projectile direction.">;
	var() editinline EffectCue ProjectileAlignedEffect<ToolTip="Sets the projectile-aligned effect to attach.">;
	var() array<Name> ProjectileAlignedAttachSockets<ToolTip="If specified, the projectile-aligned effect will be added to these sockets. Otherwise, it will attach to the nearest socket to the weapon hit.">;

	var() bool bUseWoundAttachEffect<ToolTip="Choose whether to attach an effect from WoundAttachEffect to the character">;
	var() editinline EffectCue WoundAttachEffect<ToolTip="Sets the effect to attach.">;
	var() array<Name> WoundAttachSockets<ToolTip="If specified, the wound attach effect will be added to these sockets. Otherwise, it will attach to the nearest socket to the weapon hit.">;

	structdefaultproperties
	{		
		bCreateBloodPool = true;
		bUseProjectileAlignedEffect = false;
		bUseWoundAttachEffect = true;
	}
};

var() array<DeathElement> DeathsList<ToolTip="Add elements to customize handling of deaths per damage type.">;

var(BloodPool) MaterialInterface BloodPoolDecalMaterial<ToolTip="Select the material for the decal that will be created under the dead unit's ragdoll when it comes to rest.">;
var(BloodPool) DecalProperties BloodPoolDecalProperties<ToolTip="Values to control the formation / appearence of the blood pool">;

var(MindMerge) editinline EffectCue MindMergeWhiplashEffect<ToolTip="If this character was a source of the mind merge ability, play this effect when they die.">;

var(ExplodeDeath) ParticleSystem ExplodeDeathEffect<ToolTip="This effect is created and played when the death calls for the character to explode ( ie. tank, gibs, etc. )">;
var(ExplodeDeath) SoundCue ExplodeDeathSound<ToolTip="Sound to play, in addition to SoundCollection death sound.">;

var const float kDefaultDecalScale;
var const float kDefaultDecalBackfaceAngle;

var DeathElement m_selectedDeath;
var XComUnitPawn m_pawn;
var SkeletalMeshSocket m_pawnHitSocket;
var bool m_bCreatedBloodPool;

// MHU - Tracks all particle system components generated by this death handler for cleanup.
var array<ParticleSystemComponent> m_arrCreatedParticleSystemComponents;

simulated function SpawnDeathEffectHelper(EffectCue EffectToUse, XComUnitPawn DyingPawn, SkeletalMeshSocket SocketToUse, optional bool ShotAligned, optional Vector ShotDir)
{
	local ParticleSystemComponent kPSC;

	local vector HitBonePosition;
	local Rotator HitBoneRotation;
	local Quat HitBoneQuat;

	local Quat ShotQuat;

	//Spawn a particle effect on the selected socket
	kPSC = EffectToUse.PlayOnActor(DyingPawn, DyingPawn.Mesh, SocketToUse);
	kPSC.SetTickGroup(TG_EffectsUpdateWork);	// so that when we ragdoll the fx get the correct physics location for particle spawning

	if (ShotAligned)
	{
		//Get the orientation of the socket as we hit it
		DyingPawn.Mesh.GetSocketWorldLocationAndRotation(SocketToUse.SocketName, HitBonePosition, HitBoneRotation);
		HitBoneQuat = QuatFromRotator(HitBoneRotation);

		ShotQuat = QuatFromRotator(Rotator(-ShotDir));

		//Set the local rotation of the particle effect so it faces the incoming shot.
		kPSC.SetRotation(QuatToRotator(QuatProduct(QuatInvert(HitBoneQuat), ShotQuat)));
	}

	m_arrCreatedParticleSystemComponents.AddItem(kPSC);
}

simulated function BeginDeath(class<DamageType> DamageTypeClass, XComUnitPawn DyingPawn, Vector HitLocation, Vector HitDirection )
{
	local int kFoundIndex;
	local int kNumElements;	
	local int kNumAttachSockets;
	
	local Name kSocketName;
	local SkeletalMeshSocket kSocket;

	m_pawn = DyingPawn;
	kNumElements = DeathsList.Length;
	if( kNumElements == 0 || m_pawn == none)
	{		
		//No possible deaths, just quit		
		return;
	}

	m_selectedDeath = DeathsList[0]; //Set a default
	for (kFoundIndex=0; kFoundIndex < kNumElements; kFoundIndex++)
	{
		if (DeathsList[kFoundIndex].DamageTypeClass == DamageTypeClass)
		{
			m_selectedDeath = DeathsList[kFoundIndex];
			break;
		}		
	}
		
	if( m_selectedDeath.bUseWoundAttachEffect && m_selectedDeath.WoundAttachEffect != none )
	{		
		kNumAttachSockets = m_selectedDeath.WoundAttachSockets.Length;
		if( kNumAttachSockets > 0 )
		{	
			foreach m_selectedDeath.WoundAttachSockets(kSocketName)
			{
				kSocket = DyingPawn.Mesh.GetSocketByName(kSocketName);
				if (kSocket == none)
					continue;
				
				if (m_pawnHitSocket == none)
					m_pawnHitSocket = kSocket;

				SpawnDeathEffectHelper(m_selectedDeath.WoundAttachEffect, DyingPawn, kSocket);
			}
		}
		else
		{
			m_pawnHitSocket = DyingPawn.Mesh.GetNearestSocket(HitLocation);
			SpawnDeathEffectHelper(m_selectedDeath.WoundAttachEffect, DyingPawn, m_pawnHitSocket);
		}		
	}

	if (m_selectedDeath.bUseProjectileAlignedEffect && m_selectedDeath.ProjectileAlignedEffect != none)
	{
		kNumAttachSockets = m_selectedDeath.ProjectileAlignedAttachSockets.Length;
		if (kNumAttachSockets > 0)
		{
			foreach m_selectedDeath.ProjectileAlignedAttachSockets(kSocketName)
			{
				kSocket = DyingPawn.Mesh.GetSocketByName(kSocketName);
				if (kSocket == None)
					continue;
			
				if (m_pawnHitSocket == none)
					m_pawnHitSocket = kSocket;

				SpawnDeathEffectHelper(m_selectedDeath.ProjectileAlignedEffect, DyingPawn, kSocket, true, HitDirection);
			}
		}
		else
		{
			m_pawnHitSocket = DyingPawn.Mesh.GetNearestSocket(HitLocation);
			SpawnDeathEffectHelper(m_selectedDeath.ProjectileAlignedEffect, DyingPawn, m_pawnHitSocket, true, HitDirection);
		}
	}

}

// jboswell: This is used both when re-animating a dude (which I dont think we do anymore) or just to
// stop death effects when the unit is done dying and has been dead for some time
simulated function EndDeath(XComUnitPawn UnitPawn )
{
	local ParticleSystemComponent kPSC; 

	// MHU - Shutdown and detach all particle systems created by this deathhandler.
	foreach m_arrCreatedParticleSystemComponents(kPSC)
	{
		kPSC.DeactivateSystem();
		UnitPawn.Mesh.DetachComponent(kPSC);
		UnitPawn.DetachComponent(kPSC);
	}

	// MHU - Removing references held by this object to PSCs so that they can be garbage collected.
	m_arrCreatedParticleSystemComponents.Remove(0,m_arrCreatedParticleSystemComponents.Length);
}

simulated function Update()
{
	if( m_pawn != None &&
		VSize(m_pawn.Velocity) < 0.1f &&
		!m_bCreatedBloodPool &&
		m_selectedDeath.bCreateBloodPool )
	{
		m_bCreatedBloodPool = true;
		CreateBloodPool();		
	}
}

function CreateBloodPool()
{	
	local Vector kProjectionDir;
	local Vector kLocation;
	local Rotator kRotation;

	if (BloodPoolDecalMaterial == none)
		return;
	
	if( m_pawnHitSocket != none )
	{		
		m_pawn.Mesh.GetSocketWorldLocationAndRotation( m_pawnHitSocket.SocketName, kLocation, kRotation );
	}
	else
	{
		kLocation = m_pawn.Location;
	}

	kProjectionDir = vect(0.0f, 0.0f, -1.0f);
	class'DecalCue'.static.SpawnDecal(m_pawn.WorldInfo.MyDecalManager, 
									  BloodPoolDecalMaterial, 
									  BloodPoolDecalProperties,
									  (FRand() + 1) * class'DecalComponent'.Default.DepthBias,
									  kLocation,
									  Rotator(kProjectionDir),
									  none,
									  false,
									  true);
}

DefaultProperties
{
	m_bCreatedBloodPool = false;
}
