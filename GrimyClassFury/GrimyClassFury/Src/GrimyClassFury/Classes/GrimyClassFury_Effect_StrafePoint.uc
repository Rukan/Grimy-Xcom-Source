class GrimyClassFury_Effect_StrafePoint extends X2Effect_Persistent;

function RegisterForEvents(XComGameState_Effect EffectGameState) {
	local X2EventManager EventMgr;
	local XComGameState_Unit UnitState;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;

	EffectObj = EffectGameState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	EventMgr.RegisterForEvent(EffectObj, 'RefundActionPoint', EffectGameState.TriggerAbilityFlyover, ELD_OnStateSubmitted, , UnitState);
}

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints) {
	local X2EventManager EventMgr;
	local XComGameState_Ability AbilityState;
	
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));

	if ( SourceUnit.ActionPoints.find('Strafe') == INDEX_NONE && kAbility.GetMyTemplateName() == 'StandardMove' ) {
		SourceUnit.ActionPoints.AddItem('Strafe');
		
		EventMgr = `XEVENTMGR;
		EventMgr.TriggerEvent('RefundActionPoint', AbilityState, SourceUnit, NewGameState);

		return true;
	}

	return false;
}