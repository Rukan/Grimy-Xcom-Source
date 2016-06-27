class GrimyMeleePreview extends XComUnitPawnNativeBase;

function UpdateMeleeDamagePreview(XComGameState_BaseObject NewTargetObject, XComGameState_BaseObject OldTargetObject, XComGameState_Ability AbilityState)
{
	local XComPresentationLayer Pres;
	local UIUnitFlag UnitFlag;

	Pres = `PRES;

	if(OldTargetObject != NewTargetObject)
	{
		Pres.m_kUnitFlagManager.ClearAbilityDamagePreview();
	}

	if(NewTargetObject != none && AbilityState != none)
	{
		UnitFlag = Pres.m_kUnitFlagManager.GetFlagForObjectID(NewTargetObject.ObjectID);
		if(UnitFlag != none)
		{
			if ( class'GrimyUITweaks'.default.PREVIEW_MINIMUM )
			{
				class'GrimyUITweaks'.static.SetAbilityMinDamagePreview(UnitFlag, AbilityState, NewTargetObject.GetReference());
			}
			else
			{
				Pres.m_kUnitFlagManager.SetAbilityDamagePreview(UnitFlag, AbilityState, NewTargetObject.GetReference());
			}
		}
	}
}