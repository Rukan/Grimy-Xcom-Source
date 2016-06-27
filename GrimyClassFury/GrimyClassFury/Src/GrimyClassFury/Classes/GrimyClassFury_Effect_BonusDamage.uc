class GrimyClassFury_Effect_BonusDamage extends X2Effect_Persistent;

var float Bonus;
var name AbilityName;
var int BaseDamage, TierMult;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) {
	local X2WeaponTemplate WeaponTemplate;

	if (AbilityState.GetMyTemplateName() != AbilityName) { return 0; }

	if ( BaseDamage > 0 ) {
		if ( AbilityState.GetSourceWeapon() != none ) {
			WeaponTemplate = X2WeaponTemplate(AbilityState.GetSourceWeapon().GetMyTemplate());
			if (WeaponTemplate != none) {
				return BaseDamage + TierMult * WeaponTemplate.Tier;
			}
		}
	}

	return CurrentDamage * Bonus;
}

defaultproperties
{
	BaseDamage = 0
	TierMult = 0.0
}