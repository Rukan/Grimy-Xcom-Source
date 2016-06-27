class GrimyAttrition_AbilityCost extends X2AbilityCost;

var array<name> SharedAbilityCharges;       //  names of other abilities which should all have their charges deducted as well. not checked in CanAfford, only modified in ApplyCost.
var bool bOnlyOnHit;                        //  only expend charges when the ability hits the target

simulated function name CanAfford(XComGameState_Ability kAbility, XComGameState_Unit ActivatingUnit)
{
	if (kAbility.GetCharges() >= 1)
		return 'AA_Success';

	return 'AA_CannotAfford_Charges';
}

simulated function ApplyCost(XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
	local name SharedAbilityName;
	local StateObjectReference SharedAbilityRef;
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;
	local XComGameState_Ability SharedAbilityState;
	//local XComGameState_Item WeaponState;
	//local int NumCharges;

	if (bOnlyOnHit && AbilityContext.IsResultContextMiss())
	{
		return;
	}

	//WeaponState = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(kAbility.SourceWeapon.ObjectID));
	//NumCharges = WeaponState.GetClipSize() - WeaponState.Ammo;
	//kAbility.iCharges -= NumCharges;

	if (SharedAbilityCharges.Length > 0)
	{
		History = `XCOMHISTORY;
		UnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
		if (UnitState == None)
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));

		foreach SharedAbilityCharges(SharedAbilityName)
		{
			if (SharedAbilityName != kAbility.GetMyTemplateName())
			{
				SharedAbilityRef = UnitState.FindAbility(SharedAbilityName);
				if (SharedAbilityRef.ObjectID > 0)
				{
					SharedAbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', SharedAbilityRef.ObjectID));
					//SharedAbilityState.iCharges -= NumCharges;
					NewGameState.AddStateObject(SharedAbilityState);
				}
			}
		}
	}
}