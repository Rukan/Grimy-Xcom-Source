class GrimyClassAN_Shredder extends X2Effect_Persistent;

var int BonusShred;
var int BonusAP;

function int GetExtraShredValue(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData) {
	if ( IsCorrectWeaponType(AbilityState.GetSourceWeapon()) ) {
		return BonusShred;
	}
	return 0;
}

function int GetExtraArmorPiercing(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData) {
	if ( IsCorrectWeaponType(AbilityState.GetSourceWeapon()) ) {
		return BonusAP;
	}
	return 0;
}

function bool IsCorrectWeaponType(XComGameState_Item SourceWeapon) {
	if ( SourceWeapon.GetMyTemplate().IsA('X2GrenadeLauncherTemplate') ) {
		return true;
	}
	return false;
}