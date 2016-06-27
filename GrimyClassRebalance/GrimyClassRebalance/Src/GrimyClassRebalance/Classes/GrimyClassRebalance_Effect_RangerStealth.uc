class GrimyClassRebalance_Effect_RangerStealth extends X2Effect_RangerStealth;

simulated function bool OnEffectTicked(const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit UnitState;
	local X2EventManager EventManager;
	local bool bContinueTicking;

	bContinueTicking = super.OnEffectTicked(ApplyEffectParameters, kNewEffectState, NewGameState, FirstApplication);

	if ( !bContinueTicking ) {
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
		if (UnitState != none)
		{
			EventManager = `XEVENTMGR;
			EventManager.TriggerEvent('EffectBreakUnitConcealment', UnitState, UnitState, NewGameState);
		}
	}

	return bContinueTicking;
}