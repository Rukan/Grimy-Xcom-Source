class GrimyClass_ConditionCover extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);

	if( TargetUnit == none ) {
		return 'AA_NotAUnit';
	}

	if( TargetUnit.IsBleedingOut() ) {
		return 'AA_UnitIsBleedingOut';
	}

	if( TargetUnit.IsUnconscious() ) {
		return 'AA_UnitIsUnconscious';
	}

	if( !TargetUnit.GetMyTemplate().bCanTakeCover ) {
		return 'AA_TargetCantTakeCover';
	}

	return 'AA_Success';
}