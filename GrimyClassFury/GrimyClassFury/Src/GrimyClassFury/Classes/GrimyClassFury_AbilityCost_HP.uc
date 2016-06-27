class GrimyClassFury_AbilityCost_HP extends X2AbilityCost;

var int Cost;
var name RequiredAbility;

simulated function name CanAfford(XComGameState_Ability kAbility, XComGameState_Unit ActivatingUnit) {
	if ( ActivatingUnit.FindAbility(RequiredAbility).ObjectID > 0 ) {
		if ( ActivatingUnit.GetCurrentStat(eStat_HP) > Cost ) {
			return 'AA_Success';
		}
		return 'AA_CannotAfford_HP';
	}
	return 'AA_Success';
}

simulated function ApplyCost(XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState) {
	local XComGameState_Unit ModifiedUnitState;

	ModifiedUnitState = XComGameState_Unit(AffectState);
	if ( ModifiedUnitState.FindAbility(RequiredAbility).ObjectID > 0 ) {
		ModifiedUnitState.SetCurrentStat(eStat_HP, ModifiedUnitState.GetCurrentStat(eStat_HP) - Cost);
	}
}