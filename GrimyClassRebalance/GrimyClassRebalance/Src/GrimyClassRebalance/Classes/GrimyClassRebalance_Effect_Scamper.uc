class GrimyClassRebalance_Effect_Scamper extends X2Effect_ModifyStats;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit UnitState;
	local Name PanicBehaviorTree;
	local bool bCivilian;
	local int Point;

	// Add one action point for scamper
	UnitState = XComGameState_Unit(kNewTargetState);
	bCivilian = UnitState.GetTeam() == eTeam_Neutral;
	if( !bCivilian )
	{
		for( Point = 0; Point < 1; ++Point )
		{
			if( Point < UnitState.ActionPoints.Length )
			{
				if( UnitState.ActionPoints[Point] != class'X2CharacterTemplateManager'.default.StandardActionPoint )
				{
					UnitState.ActionPoints[Point] = class'X2CharacterTemplateManager'.default.StandardActionPoint;
				}
			}
			else
			{
				UnitState.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
			}
		}
	}
	else
	{
		// Force civilians into red alert.
		if( UnitState.GetCurrentStat(eStat_AlertLevel) != `ALERT_LEVEL_RED )
		{
			UnitState.SetCurrentStat(eStat_AlertLevel, `ALERT_LEVEL_RED);
		}
	}
	//UnitState.bPanicked = true;

	if( !bCivilian )
	{
		// Kick off panic behavior tree.
		PanicBehaviorTree = Name(UnitState.GetMyTemplate().strScamperBT); // "ScamperRoot_NoCover"; //

		// Delayed behavior tree kick-off.  Points must be added and game state submitted before the behavior tree can 
		// update, since it requires the ability cache to be refreshed with the new action points.
		UnitState.AutoRunBehaviorTree(PanicBehaviorTree, 1, `XCOMHISTORY.GetCurrentHistoryIndex() + 1, true);
	}
}