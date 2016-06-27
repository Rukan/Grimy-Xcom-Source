class GrimyClassHH_Effect_BonusExecute extends X2Effect_Persistent;

var float Bonus;
var name MarkedName;
var name HoloTargetName;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if ( !AbilityState.IsMeleeAbility() ) { return 0; }
	if ( XComGameState_Unit(TargetDamageable).AffectedByEffectNames.find(MarkedName) == INDEX_NONE && XComGameState_Unit(TargetDamageable).AffectedByEffectNames.find(HoloTargetName) == INDEX_NONE ) { return 0; }
	
	return CurrentDamage * Bonus ;
}

defaultproperties
{
	MarkedName = MarkedTarget
	HoloTargetName = HoloTarget
}