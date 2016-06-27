class GrimyLoot_Effect_BonusArmor extends X2Effect_BonusArmor;

var int BonusArmor, BonusArmorChance;

function int GetArmorChance(XComGameState_Effect EffectState, XComGameState_Unit UnitState) { return BonusArmorChance; }
function int GetArmorMitigation(XComGameState_Effect EffectState, XComGameState_Unit UnitState) { return BonusArmor; }

defaultproperties
{
	BonusArmor = 1;
	BonusArmorChance = 100;
}