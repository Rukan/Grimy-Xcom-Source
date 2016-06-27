class Grimy_Effect_StilettoRounds extends X2Effect_Persistent;

var int BonusDamagePerTier;
var int BonusDamageNoTier;

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
			//Attempt to scale damage to weapon tier
			if ( SourceWeapon.GetMyTemplate().Tier > 0 ) 
			{
				return ( SourceWeapon.GetMyTemplate().Tier / 2 ) * BonusDamagePerTier + BonusDamageNoTier;
			}
			// Zero tier weapons are rounded up to be at least tier 1.
			return BonusDamageNoTier;
		}
	}
	return 0;
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
}
