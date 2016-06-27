class Grimy_Effect_HuntersInstinctDamage extends X2Effect_HuntersInstinctDamage;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage)
{
	local XComGameState_Unit TargetUnit;
	local GameRulesCache_VisibilityInfo VisInfo;

	TargetUnit = XComGameState_Unit(TargetDamageable);
	// Start of Chanages
	// Note: The original check determines if the starting position is flanking the enemy.
	// We want melee to always benefit, not just when the ranger is flanking the enemy at the start of his charge.
	if ( AbilityState.IsMeleeAbility() && TargetUnit != None && class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) )
	{
		if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo))
		{
			if (Attacker.CanFlank() && TargetUnit.CanTakeCover())
			{
				return BonusDamage;
			}
		}
	}

	// Removed the AbilityState.IsMeleeAbility() check from the line below.
	// No more changes beyond the subsequent line of code.
	if (TargetUnit != None && class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
	{
		if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo))
		{
			if (Attacker.CanFlank() && TargetUnit.CanTakeCover() && VisInfo.TargetCover == CT_None)
			{
				return BonusDamage;
			}
		}
	}
	return 0;
}