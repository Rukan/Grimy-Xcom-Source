class GrimyClassRebalance_Condition_Stealth extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{ 
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(kTarget);

	if (UnitState == none)
		return 'AA_NotAUnit';

	if (UnitState.IsConcealed())
		return 'AA_UnitIsConcealed';

	if (class'X2TacticalVisibilityHelpers'.static.GetNumFlankingEnemiesOfTarget(kTarget.ObjectID) > 0)
		return 'AA_UnitIsFlanked';
		
	if (class'X2TacticalVisibilityHelpers'.static.GetNumOverwatchingEnemiesOfTarget(kTarget.ObjectID) > 0)
		return 'AA_UnitIsOverwatched';

	return 'AA_Success'; 
}