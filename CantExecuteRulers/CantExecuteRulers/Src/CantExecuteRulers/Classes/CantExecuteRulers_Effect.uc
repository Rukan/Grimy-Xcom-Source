class CantExecuteRulers_Effect extends X2Effect_Persistent;

var int Bonus;
var EInventorySlot Slot;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if ( AbilityState.GetSourceWeapon().InventorySlot == Slot || class'X2DownloadableContentInfo_CantExecuteRulers'.default.bEverythingImmune ) {
		if ( class'X2DownloadableContentInfo_CantExecuteRulers'.default.IMMUNE_UNITS.find(XComGameState_Unit(TargetDamageable).GetMyTemplateName()) != INDEX_NONE ) {
			return Bonus;
		}		
	}
	else return 0;
}