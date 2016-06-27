class X2DownloadableContentInfo_CantExecuteRulers extends X2DownloadableContentInfo config(CantExecuteRulers);

struct UPGRADE_DATA
{
	var name UpgradeName;
	var int BonusDamage;
	var EInventorySlot SlotType;
};

var config array<UPGRADE_DATA> UPGRADE_INFO;
var config array<name> IMMUNE_UNITS;
var config bool bEverythingImmune;

static event OnPostTemplatesCreated() {
	local X2ItemTemplateManager		ItemManager;
	local X2WeaponUpgradeTemplate	ItemTemplate;
	local UPGRADE_DATA				UpgradeData;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	foreach default.UPGRADE_INFO(UpgradeData) {
		ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate(UpgradeData.UpgradeName));
		ItemTemplate.BonusAbilities.AddItem(UpgradeData.UpgradeName);
		ItemTemplate.FreeKillFn = FreeKillChanceNoRulers;
	}
}

function bool FreeKillChanceNoRulers(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Unit TargetUnit)
{
	local int Chance;

	if ( bEverythingImmune ) { return false; }
	if ( default.IMMUNE_UNITS.find(TargetUnit.GetMyTemplateName()) != INDEX_NONE ) {
		return false;
	}

	Chance = `SYNC_RAND_STATIC(100);
	return Chance <= UpgradeTemplate.FreeKillChance;
}

static function array<X2DataTemplate> GetTemplates() {
	local array<X2DataTemplate>		Templates;
	local UPGRADE_DATA				UpgradeData;

	foreach default.UPGRADE_INFO(UpgradeData) {
		Templates.AddItem(class'CantExecuteRulers_AbilitySet'.static.GrimyRepeaterBonusDamage(UpgradeData.UpgradeName, UpgradeData.BonusDamage, UpgradeData.SlotType));
	}

	return Templates;
}