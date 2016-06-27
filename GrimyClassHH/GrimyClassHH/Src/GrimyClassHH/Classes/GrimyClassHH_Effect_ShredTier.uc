class GrimyClassHH_Effect_ShredTier extends X2Effect_ApplyWeaponDamage;

function WeaponDamageValue GetBonusEffectDamageValue(XComGameState_Ability AbilityState, XComGameState_Item SourceWeapon, StateObjectReference TargetRef) {
	local WeaponDamageValue ShredValue;
	local X2WeaponTemplate WeaponTemplate;

	ShredValue = EffectDamageValue;             //  in case someone has set other fields in here, but not likely

	if ((SourceWeapon != none) ) {
		WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
		if (WeaponTemplate != none) {
			ShredValue.Shred += class'X2Effect_Shredder'.default.ConventionalShred;

			if (WeaponTemplate.WeaponTech == 'magnetic')
				ShredValue.Shred += class'X2Effect_Shredder'.default.MagneticShred;
			else if (WeaponTemplate.WeaponTech == 'beam')
				ShredValue.Shred += class'X2Effect_Shredder'.default.BeamShred;
		}
	}

	return ShredValue;
}

DefaultProperties
{
	bAllowFreeKill=true
	bIgnoreBaseDamage=false
}