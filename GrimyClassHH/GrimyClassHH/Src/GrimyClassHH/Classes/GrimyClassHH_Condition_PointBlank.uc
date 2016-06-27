class GrimyClassHH_Condition_PointBlank extends X2Condition;

var int MaxDistance;

event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget) {
	local XComGameState_Unit UnitState, TargetUnitState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	TargetUnitState = XComGameState_Unit(kTarget);

	if ( UnitState == none || TargetUnitState == none ) {
		return 'AA_MissingUnits';
	}

	if ( UnitState.TileDistanceBetween(TargetUnitState) > MaxDistance) {
		return 'AA_TargetTooFar';
	}

	return 'AA_Success';
}