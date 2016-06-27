class GrimyLoot_Effect_ShieldGate extends X2Effect_BonusArmor;

function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect)
{
	if ( XComGameState_Unit(TargetDamageable).GetCurrentStat(eStat_ShieldHP) < CurrentDamage )
	{
		return -int(float(CurrentDamage) - XComGameState_Unit(TargetDamageable).GetCurrentStat(eStat_ShieldHP) );
	}
	else
	{
		return 0;
	}
}