class X2DownloadableContentInfo_MoreHotkeys2 extends X2DownloadableContentInfo config(MoreHotkeys);

var config array<name> HIDDEN_ABILITIES;

static event OnPostTemplatesCreated() {
	local X2AbilityTemplateManager	AbilityManager;
	local name						AbilityName;
	local X2AbilityTemplate			AbilityTemplate;
	
	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	foreach default.HIDDEN_ABILITIES(AbilityName) {
		AbilityTemplate = AbilityManager.FindAbilityTemplate(AbilityName);
		AbilityTemplate.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	}
}