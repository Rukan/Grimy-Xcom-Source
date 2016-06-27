class GrimyClassRebalance_Condition_Restock extends X2Condition;

var int ChargeCost;

event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	if ( kAbility.iCharges >= ChargeCost ) {
		return 'AA_Success';
	}
	return 'AA_NotEnoughCharges';
}

defaultproperties
{
	ChargeCost = 1
}