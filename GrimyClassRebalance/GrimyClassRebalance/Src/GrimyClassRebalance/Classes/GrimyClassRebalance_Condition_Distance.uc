class GrimyClassRebalance_Condition_Distance extends X2Condition config(GrimyClassRebalance);

var config int CLOSE_COMBAT_DISTANCE;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit TargetState, SourceState;

	TargetState = XComGameState_Unit(kTarget);
	SourceState = XComGameState_Unit(kSource);
	
	if ( TargetState == none || SourceState == none ) {
		return 'AA_InvalidTarget';
	}
	if ( TargetState.TileDistanceBetween(SourceState) >= default.CLOSE_COMBAT_DISTANCE ) {
		return 'AA_TooFar';
	}
	
	return 'AA_Success';
}