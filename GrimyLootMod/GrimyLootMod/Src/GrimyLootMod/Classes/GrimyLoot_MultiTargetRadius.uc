class GrimyLoot_MultiTargetRadius extends X2AbilityMultiTarget_SoldierBonusRadius;

simulated function GetUpdateRadius(const XComGameState_Ability Ability) {
	local XComGameState_Unit OwnerState;

	OwnerState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Ability.OwnerStateObject.ObjectID));

	BonusRadius = 0.0;
	SoldierAbilityName = 'LaunchGrenade';
	if ( OwnerState.FindAbility('GrimyAirBurst').ObjectID > 0 ) {
		BonusRadius += 2.0;
	}
	if ( OwnerState.FindAbility('GrimyReduceRadius25').ObjectID > 0 ) {
		BonusRadius += -2.5;
	}
	if ( OwnerState.FindAbility('GrimyBonusRadius20').ObjectID > 0 ) {
		BonusRadius += 2.0;
	}
	else if ( OwnerState.FindAbility('GrimyBonusRadius10').ObjectID > 0 ) {
		BonusRadius += 1.0;
	}
	else if ( OwnerState.FindAbility('GrimyBonusRadius07').ObjectID > 0 ) {
		BonusRadius += 0.75;
	}
	else if ( OwnerState.FindAbility('GrimyBonusRadius05').ObjectID > 0 ) {
		BonusRadius += 0.5;
	}
}

simulated function float GetTargetRadius(const XComGameState_Ability Ability) {
	GetUpdateRadius(Ability);
	return super.GetTargetRadius(Ability);
}

simulated function float GetActiveTargetRadiusScalar(const XComGameState_Ability Ability) {
	GetUpdateRadius(Ability);
	return super.GetActiveTargetRadiusScalar(Ability);
}

simulated function float GetTargetCoverage(const XComGameState_Ability Ability) {
	local XComGameState_Unit OwnerState;
	local float ReturnCoverage;

	OwnerState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Ability.OwnerStateObject.ObjectID));
	if ( OwnerState.FindAbility('GrimyDeadlyHaze').ObjectID > 0 ) { return 100.0; }

	GetUpdateRadius(Ability);
	ReturnCoverage = super.GetTargetCoverage(Ability);

	return ReturnCoverage;
}

simulated function GetMultiTargetOptions(const XComGameState_Ability Ability, out array<AvailableTarget> Targets) {
	GetUpdateRadius(Ability);
	super.GetMultiTargetOptions(Ability, Targets);
}

simulated function GetMultiTargetsForLocation(const XComGameState_Ability Ability, const vector Location, out AvailableTarget Target) {
	GetUpdateRadius(Ability);
	super.GetMultiTargetsForLocation(Ability, Location, Target);
}

simulated function GetValidTilesForLocation(const XComGameState_Ability Ability, const vector Location, out array<TTile> ValidTiles) {
	GetUpdateRadius(Ability);
	super.GetValidTilesForLocation(Ability, Location, ValidTiles);
}