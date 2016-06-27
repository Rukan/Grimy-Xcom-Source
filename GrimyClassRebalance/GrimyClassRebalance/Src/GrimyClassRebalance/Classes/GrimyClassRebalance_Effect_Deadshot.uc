class GrimyClassRebalance_Effect_Deadshot extends X2Effect_Persistent;

var int PrimaryBonus, SecondaryBonus;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) {
	local XComGameState_Unit TargetUnit;
	local XComGameState_Item SourceWeapon;

	TargetUnit = XComGameState_Unit(TargetDamageable);

	if ( TargetUnit == None ) { return 0; }
	if ( TargetUnit.CanTakeCover() ) { return 0; }
	
	SourceWeapon = AbilityState.GetSourceWeapon();
	if ( SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon ) { return PrimaryBonus; }
	if ( SourceWeapon.InventorySlot == eInvSlot_SecondaryWeapon ) { return SecondaryBonus; }

	return 0;
}