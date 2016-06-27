class GrimyAttrition_BonusReserves extends X2Effect_Persistent;

var int AmmoCount;
var bool ForPrimary;

simulated function bool OnEffectTicked(const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication) {
	local XComGameState_Unit UnitState;
	local XComGameState_Item WeaponState;
	local XComGameState_Ability NewAbilityState;
	local StateObjectReference	AbilityRef;
			
	// Acquire new ability
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	WeaponState = GetWeaponState(UnitState);
	AbilityRef = UnitState.FindAbility('Reload', WeaponState.GetReference());

	if ( AbilityRef.ObjectID > 0 ) {
		// update ability
		NewAbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', AbilityRef.ObjectID));
		NewAbilityState.iCharges += AmmoCount;
	
		// Submit updated ability state
		NewGameState.AddStateObject(NewAbilityState);
	}

	return false;
}

function XComGameState_Item GetWeaponState(XComGameState_Unit UnitState) {
	if ( ForPrimary ) {
		return UnitState.GetPrimaryWeapon();
	}
	else {
		return UnitState.GetSecondaryWeapon();
	}
}