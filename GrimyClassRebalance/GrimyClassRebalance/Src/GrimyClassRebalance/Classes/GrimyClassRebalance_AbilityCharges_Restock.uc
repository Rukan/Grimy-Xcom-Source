class GrimyClassRebalance_AbilityCharges_Restock extends X2AbilityCharges;

function int GetInitialCharges(XComGameState_Ability Ability, XComGameState_Unit Unit) {
	if ( Unit.HasSoldierAbility('GrimySupplyProtocol') ) {	
		return InitialCharges;
	}
	return 0;
}

defaultproperties
{
	InitialCharges = 1
}