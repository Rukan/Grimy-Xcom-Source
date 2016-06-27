class GrimyClassRebalance_Effect_Restock extends X2Effect;

var int AmmoCount;
var bool ForPrimary;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState) {
	local XComGameState_Unit UnitState;
	local XComGameState_Item WeaponState;
	local XComGameState_Ability NewAbilityState;
	local StateObjectReference	AbilityRef;
	
	UnitState = XComGameState_Unit(kNewTargetState);
	WeaponState = GetWeaponState(UnitState);
	AbilityRef = UnitState.FindAbility('Reload', WeaponState.GetReference());
	
	if ( AbilityRef.ObjectID > 0 ) {
		// update ability
		NewAbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', AbilityRef.ObjectID));
		NewAbilityState.iCharges += AmmoCount;
	
		// Submit updated ability state
		NewGameState.AddStateObject(NewAbilityState);
	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}

function XComGameState_Item GetWeaponState(XComGameState_Unit UnitState) {
	if ( ForPrimary ) {
		return UnitState.GetPrimaryWeapon();
	}
	else {
		return UnitState.GetSecondaryWeapon();
	}
}