class GrimyLootPCS_Effect_BonusDamageCorpse extends X2Effect_Persistent;

var name CorpseName;
var int Bonus;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) {
	local X2CharacterTemplate	CharTemplate;
	local array<LootReference>	LootReferences;
	local LootReference			LootReference;

	local X2LootTableManager	LootTableManager;
	local array<name>			Loots;
	local name					LootName;

	LootTableManager = class'X2LootTableManager'.static.GetLootTableManager();

	CharTemplate = XComGameState_Unit(TargetDamageable).GetMyTemplate();
	LootReferences = CharTemplate.Loot.LootReferences;
	foreach LootReferences(LootReference) {
		LootTableManager.RollForLootTable(LootReference.LootTableName, Loots);
		foreach Loots(LootName) {
			if ( LootName == CorpseName ) {
				return Bonus;
			}
		}
	}

	return 0;
}