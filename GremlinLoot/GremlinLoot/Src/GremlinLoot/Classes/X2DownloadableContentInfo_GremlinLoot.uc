class X2DownloadableContentInfo_GremlinLoot extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated() {
	local X2AbilityTemplate						EditTemplate;
	local X2AbilityTemplateManager				AbilityManager;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	EditTemplate = AbilityManager.FindAbilityTemplate('IntrusionProtocol');
	EditTemplate.AdditionalAbilities.AddItem('GremlinLootProtocol');
}