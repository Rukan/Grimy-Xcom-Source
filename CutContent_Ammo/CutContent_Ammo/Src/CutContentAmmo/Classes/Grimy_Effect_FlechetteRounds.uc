class Grimy_Effect_FlechetteRounds extends X2Effect_Persistent;

var int BonusDamagePerTier;
var int BonusDamageNoTier;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Item SourceWeapon;
	local XComGameState_Unit TargetUnit;

	SourceWeapon = AbilityState.GetSourceWeapon();
	TargetUnit = XComGameState_Unit(TargetDamageable);


	//Only apply the bonus damage on a success
	if (AppliedData.AbilityResultContext.HitResult != eHit_Miss)
	{
		//  make sure the ammo that created this effect is loaded into the weapon
		if (SourceWeapon != none && SourceWeapon.LoadedAmmo.ObjectID == EffectState.ApplyEffectParameters.ItemStateObjectRef.ObjectID)
		{
			//Only apply bonus damage to organics
			if ( !TargetUnit.IsRobotic() )
			{
				//Attempt to scale damage to weapon tier
				if (SourceWeapon != none )
				{
					//Attempt to scale damage to weapon tier
					if ( SourceWeapon.GetMyTemplate().Tier > 0 ) 
					{
						return SourceWeapon.GetMyTemplate().Tier * BonusDamagePerTier + BonusDamageNoTier;
					}
					// Zero tier weapons are rounded up to be at least tier 1.
					return BonusDamageNoTier+1;
				}
			}
		}
	}
	return 0;
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
}
