class GrimyClassRebalance_Effect_EverVigilant extends X2Effect_Persistent;

simulated function bool OnEffectTicked(const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication) {
	local XComGameState_Unit UnitState;
	local StateObjectReference OverwatchRef;
	local XComGameState_Ability OverwatchState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	OverwatchRef = UnitState.FindAbility('Overwatch');
	if (OverwatchRef.ObjectID == 0)
		OverwatchRef = UnitState.FindAbility('PistolOverwatch');
	OverwatchState = XComGameState_Ability(History.GetGameStateForObjectID(OverwatchRef.ObjectID));
	if (OverwatchState != none)
	{
		UnitState = XComGameState_Unit(NewGameState.CreateStateObject(UnitState.Class, UnitState.ObjectID));

		if (UnitState.NumActionPoints() == 0)
		{
			//  give the unit an action point so they can activate overwatch										
			UnitState.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);					
		}
		UnitState.SetUnitFloatValue(class'X2Ability_SpecialistAbilitySet'.default.EverVigilantEffectName, 1, eCleanup_BeginTurn);
				
		NewGameState.AddStateObject(UnitState);
		`TACTICALRULES.SubmitGameState(NewGameState);
		OverwatchState.AbilityTriggerAgainstSingleTarget(OverwatchState.OwnerStateObject, false);
	}

	return true;
}