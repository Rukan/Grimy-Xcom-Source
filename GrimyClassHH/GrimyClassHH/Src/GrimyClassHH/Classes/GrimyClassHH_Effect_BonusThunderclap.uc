class GrimyClassHH_Effect_BonusThunderclap extends X2Effect_Persistent;

var float Bonus;
var name AbilityName;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (AbilityState.GetMyTemplateName() != AbilityName) { return 0; }
	if ( XComGameState_Unit(TargetDamageable).GetMyTemplate().bIsRobotic ) {
		return CurrentDamage * Bonus * 2;
	}
	else {
		return CurrentDamage * Bonus;
	}
}