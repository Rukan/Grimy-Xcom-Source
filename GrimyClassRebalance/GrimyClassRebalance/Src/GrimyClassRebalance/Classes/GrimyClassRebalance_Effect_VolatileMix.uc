class GrimyClassRebalance_Effect_VolatileMix extends X2Effect_Persistent;

var int BonusDamage;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Item SourceWeapon;
	local X2GrenadeTemplate GrenadeTemplate;

	SourceWeapon = AbilityState.GetSourceWeapon();

	//`LOG("GRIMY LOG AK EFFECT NAME: " $ AppliedData.EffectRef.SourceTemplateName $ " " $ AppliedData.EffectRef.ApplyOnTickIndex);
	//`LOG("GRIMY LOG AK EFFECT NAME: " $ AppliedData.EffectRef.SourceTemplateName $ " " $ AppliedData.EffectRef.ApplyOnTickIndex);
	//`LOG("GRIMY LOG AK EFFECT NAME: " $ AppliedData.EffectRef.SourceTemplateName $ " " $ AppliedData.EffectRef.ApplyOnTickIndex);

	if ( AppliedData.EffectRef.ApplyOnTickIndex >= 0 ) {
		return 0;
	}

	if (SourceWeapon != none)
	{
		GrenadeTemplate = X2GrenadeTemplate(SourceWeapon.GetMyTemplate());

		if (GrenadeTemplate == none)
		{
			GrenadeTemplate = X2GrenadeTemplate(SourceWeapon.GetLoadedAmmoTemplate(AbilityState));
		}

		if (GrenadeTemplate != none && GrenadeTemplate.bAllowVolatileMix)
		{
			return BonusDamage;
		}
	}
	return 0;
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
}