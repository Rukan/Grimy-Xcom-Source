class GrimyClassHH_Effect_BonusHexHunter extends X2Effect_Persistent;

var float Bonus;
var name AbilityName;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local X2AbilityTemplateManager	AbilityManager;
	local X2AbilityTemplate			AbilityTemplate;
	local XComGameState_Unit		NewUnitState;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityManager.FindAbilityTemplate(AbilityName);
	NewUnitState = XComGameState_Unit(kNewTargetState);

	`TACTICALRULES.InitAbilityForUnit(AbilityTemplate, NewUnitState, NewGameState, NewUnitState.GetPrimaryWeapon().GetReference());
}

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (AbilityState.GetMyTemplateName() != AbilityName) { return 0; }
	return XComGameState_Unit(TargetDamageable).GetMaxStat(eStat_PsiOffense) / Bonus;
}