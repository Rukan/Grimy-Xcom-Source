class GrimyClassRebalance_Effect_HuntersInstinct extends X2Effect_Persistent;

var int BonusDamage;
var bool bAllowMelee;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) {
	local XComGameState_Unit TargetUnit;
	local GameRulesCache_VisibilityInfo VisInfo;

	TargetUnit = XComGameState_Unit(TargetDamageable);

	if ( TargetUnit == None ) { return 0; }
	if ( !`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo) ) { return 0; }
	if ( !Attacker.CanFlank() ) { return 0; }
	if ( !TargetUnit.GetMyTemplate().bCanTakeCover ) { return 0; }

	if ( AbilityState.IsMeleeAbility() && bAllowMelee ) { return BonusDamage; }
	if ( VisInfo.TargetCover == CT_None ) { return BonusDamage; }

	return 0;
}