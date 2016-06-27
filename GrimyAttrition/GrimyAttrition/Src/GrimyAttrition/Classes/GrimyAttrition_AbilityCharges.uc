class GrimyAttrition_AbilityCharges extends X2AbilityCharges config(GrimyAttrition);

struct RESERVE_DATA
{
	var name WeaponCat;
	var int Ammo;
};

var config array<RESERVE_DATA> RESERVES;
var config int DEFAULT_RESERVE;

function int GetInitialCharges(XComGameState_Ability Ability, XComGameState_Unit Unit) { 
	local RESERVE_DATA	data;
	local name			WeaponCat;

	WeaponCat = Ability.GetSourceWeapon().GetWeaponCategory();
	foreach default.RESERVES(data) {
		if ( data.WeaponCat == WeaponCat ) {
			return data.Ammo + class'GrimyAttrition_TacticalListener'.static.GetBonusAmmo();
		}
	}
	return default.DEFAULT_RESERVE;
}