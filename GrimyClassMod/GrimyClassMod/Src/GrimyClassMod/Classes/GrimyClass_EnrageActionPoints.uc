class GrimyClass_EnrageActionPoints extends X2Effect_Persistent;

var name ActionPointType;
var int NumActionPoints;

function ModifyTurnStartActionPoints(XComGameState_Unit UnitState, out array<name> ActionPoints, XComGameState_Effect EffectState) {
	local int i;
	
	if ( UnitState.GetCurrentStat(eStat_HP) < UnitState.GetMaxStat(eStat_HP) ) {
		for (i = 0; i < NumActionPoints; ++i) {
			ActionPoints.AddItem(ActionPointType);
		}
	}
}

function EffectAddedCallback(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState) {
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(kNewTargetState);
	if (UnitState != none) {
		ModifyTurnStartActionPoints(UnitState, UnitState.ActionPoints, none);
	}
}

DefaultProperties
{
	EffectAddedFn=EffectAddedCallback
}