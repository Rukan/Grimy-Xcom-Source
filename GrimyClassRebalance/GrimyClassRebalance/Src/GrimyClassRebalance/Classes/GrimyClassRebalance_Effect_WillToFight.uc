class GrimyClassRebalance_Effect_WillToFight extends X2Effect_Persistent;

var float BonusMult;
var int BonusBase;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) 
{
	local int BonusDmg;

	BonusDmg = 0;
	
	if (AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef) {
		BonusDmg += BonusBase + int(BonusMult * Attacker.GetCurrentStat(eStat_Will));
	}
	
	if ( BonusDmg < 0 ) { BonusDmg = 0; }

	return BonusDmg;
}