class GrimyClassHH_AbilityCost_HexHunter extends X2AbilityCost;

simulated function name CanAfford(XComGameState_Ability kAbility, XComGameState_Unit ActivatingUnit) {
	if ( ActivatingUnit.FindAbility('GrimyHexHunterBonus').ObjectID <= 0 ) {
		return 'AA_MissingPerk';
	}
	else {
		return 'AA_Success';
	}
}

defaultproperties
{
	bFreeCost = true;
}