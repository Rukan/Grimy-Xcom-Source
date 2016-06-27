class GrimyClass_Effect_BonusAbilityDamage extends X2Effect_Persistent;

var float Bonus;
var name AbilityName;
var bool bExcludeRobotic;
var bool bExcludeOrganic;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (AbilityState.GetMyTemplateName() != AbilityName) { return 0; }
	if (bExcludeRobotic && XComGameState_Unit(TargetDamageable).GetMyTemplate().bIsRobotic) { return 0; }
	if (bExcludeOrganic && !XComGameState_Unit(TargetDamageable).GetMyTemplate().bIsRobotic) { return 0; }

	return CurrentDamage * Bonus;
}

defaultproperties
{
	Bonus = 0;
	bExcludeRobotic = false;
	bExcludeOrganic = false;
}