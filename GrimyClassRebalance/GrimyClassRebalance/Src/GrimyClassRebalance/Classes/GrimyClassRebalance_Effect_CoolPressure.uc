class GrimyClassRebalance_Effect_CoolPressure extends X2Effect_Persistent;

var int BonusDamage;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) {
	local X2AbilityToHitCalc_StandardAim HitCalc;

	HitCalc = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);

	if ( HitCalc == none ) { return 0; }
	if ( HitCalc.bReactionFire ) { return BonusDamage; }

	return 0;
}