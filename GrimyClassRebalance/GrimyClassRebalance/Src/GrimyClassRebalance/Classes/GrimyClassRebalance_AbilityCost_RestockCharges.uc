class GrimyClassRebalance_AbilityCost_RestockCharges extends X2AbilityCost;

var int NumCharges;
var array<name> SharedAbilityCharges;       //  names of other abilities which should all have their charges deducted as well. not checked in CanAfford, only modified in ApplyCost.
var bool bOnlyOnHit;                        //  only expend charges when the ability hits the target

simulated function name CanAfford(XComGameState_Ability kAbility, XComGameState_Unit ActivatingUnit)
{
	return 'AA_Success';
}

simulated function ApplyCost(XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
	local name SharedAbilityName;
	local StateObjectReference SharedAbilityRef;
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;
	local XComGameState_Ability SharedAbilityState;

	if ( kAbility.iCharges > 0 ) {
		if (bOnlyOnHit && AbilityContext.IsResultContextMiss())
		{
			return;
		}
		kAbility.iCharges -= NumCharges;

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
						SharedAbilityState.iCharges -= NumCharges;
						NewGameState.AddStateObject(SharedAbilityState);
					}
				}
			}
		}
	}
}

DefaultProperties
{
	NumCharges = 1
}