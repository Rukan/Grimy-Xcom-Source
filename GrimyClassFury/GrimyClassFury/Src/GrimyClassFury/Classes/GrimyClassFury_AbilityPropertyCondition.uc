class GrimyClassFury_AbilityPropertyCondition extends X2Condition;

var name ExcludeAbility;

function name AbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget) {
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));

	if ( UnitState == none ) {
		return 'AA_UnitMissing';
	}

	if ( UnitState.FindAbility(ExcludeAbility).ObjectID > 0 ) {
		return 'AA_UnitHasExcludeAbility';
	}

	return 'AA_Success';
}
