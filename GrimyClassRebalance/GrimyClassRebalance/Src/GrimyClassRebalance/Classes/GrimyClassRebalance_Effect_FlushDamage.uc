class GrimyClassRebalance_Effect_FlushDamage extends X2Effect_Persistent;

var float DamageMultiplier;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (AbilityState.GetMyTemplateName() == 'GrimyFlush')
	{
		return int( CurrentDamage * DamageMultiplier );
	}
	return 0;
}