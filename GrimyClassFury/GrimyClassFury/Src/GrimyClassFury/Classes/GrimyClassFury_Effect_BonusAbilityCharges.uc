class GrimyClassFury_Effect_BonusAbilityCharges extends X2Effect_Persistent;

var int ChargeCount;
var name AbilityName;

simulated function bool OnEffectTicked(const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication) {
	local XComGameState_Unit	UnitState;
	local StateObjectReference	AbilityRef;
	local XComGameState_Ability	AbilityState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	AbilityRef = UnitState.FindAbility(AbilityName);
	if ( AbilityRef.ObjectID > 0 ) {
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
		if ( AbilityState != none ) {
			if ( AbilityState.iCharges >= 0 ) {
				AbilityState.iCharges += ChargeCount;
			}
		}
	}

	return false;
}
