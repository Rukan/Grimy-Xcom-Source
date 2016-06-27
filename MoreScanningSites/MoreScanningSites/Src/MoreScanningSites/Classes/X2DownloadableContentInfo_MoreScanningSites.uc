class X2DownloadableContentInfo_MoreScanningSites extends X2DownloadableContentInfo config(MoreScanningSites);

var config array<name> REWARD_NAMES;

static event OnPostTemplatesCreated()
{
	local X2ItemTemplateManager				ItemManager;
	local X2DataTemplate					ItemTemplate;
	local X2QuestItemTemplate				QuestItemTemplate;
	local name								RewardName;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	foreach ItemManager.IterateTemplates(ItemTemplate,none) {
		QuestItemTemplate = X2QuestItemTemplate(ItemTemplate);
		if ( QuestItemTemplate != none ) {
			foreach default.REWARD_NAMES(RewardName) {
				QuestItemTemplate.RewardType.RemoveItem(RewardName);
				QuestItemTemplate.RewardType.AddItem(RewardName);
			}
		}	
	}
}

function bool NotGrimyMission(XComGameState_MissionSite MissionState) {
	return MissionState.FlavorText != class'MoreScanningSites_DefaultOps'.default.FLAVOR_TEXT;
}