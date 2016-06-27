class ExplosionsDestroyCorpses_AmbientHook extends X2AmbientNarrativeCriteria config(ExplosionsDestroyCorpses);

var config array<name> CORPSE_LIST;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>					Templates;
	local X2ItemTemplateManager					ItemManager;
	local X2ItemTemplate						ItemTemplate;
	local name									ItemName;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	foreach default.CORPSE_LIST(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		ItemTemplate.LeavesExplosiveRemains = false;
	}

	Templates.length = 0;
	return Templates;
}