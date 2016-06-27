class Grimy_Effect_FalconRounds extends X2Effect_Persistent;

var int BonusDamage;
var int DodgePiercing;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ModInfo;
	local XComGameState_Item SourceWeapon;

	SourceWeapon = AbilityState.GetSourceWeapon();
	//  make sure the ammo that created this effect is loaded into the weapon
	if (SourceWeapon != none && SourceWeapon.LoadedAmmo.ObjectID == EffectState.ApplyEffectParameters.ItemStateObjectRef.ObjectID)
	{
		ModInfo.ModType = eHit_Graze;
		ModInfo.Reason = FriendlyName;
		ModInfo.Value = -DodgePiercing;
		ShotModifiers.AddItem(ModInfo);
	}	
}

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Item SourceWeapon;
	SourceWeapon = AbilityState.GetSourceWeapon();
	
	//Only apply the bonus damage on a success
	if (AppliedData.AbilityResultContext.HitResult != eHit_Miss)
	{
		//  make sure the ammo that created this effect is loaded into the weapon
		if (SourceWeapon != none && SourceWeapon.LoadedAmmo.ObjectID == EffectState.ApplyEffectParameters.ItemStateObjectRef.ObjectID)
		{
			return BonusDamage;
		}
	}
	return 0;
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
}
