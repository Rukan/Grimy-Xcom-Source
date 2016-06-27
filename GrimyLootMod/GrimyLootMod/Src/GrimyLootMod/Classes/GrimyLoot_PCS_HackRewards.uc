class GrimyLoot_PCS_HackRewards extends X2HackReward config(GrimyLootModPCS);

var config array<name> PCSRewards;
var config array<name> PCSUpgrades;
var config bool bEnablePCS;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;

	if ( default.bEnablePCS ) {
		Templates.AddItem(CreateCommonPCSReward('GrimyCommonPCSReward'));
		Templates.AddItem(CreateRarePCSReward('GrimyRarePCSReward'));
		Templates.AddItem(CreateEpicPCSReward('GrimyEpicPCSReward'));
		Templates.AddItem(CreateLegendaryPCSReward('GrimyLegendaryPCSReward'));
	}

	return Templates;
}

static function X2HackRewardTemplate CreateCommonPCSReward(Name TemplateName) {
	local X2HackRewardTemplate Template;
	`CREATE_X2TEMPLATE(class'X2HackRewardTemplate', Template, TemplateName);
	Template.ApplyHackRewardFn = GiveCommonPCS;
	return Template;
}

static function X2HackRewardTemplate CreateRarePCSReward(Name TemplateName) {
	local X2HackRewardTemplate Template;
	`CREATE_X2TEMPLATE(class'X2HackRewardTemplate', Template, TemplateName);
	Template.ApplyHackRewardFn = GiveRarePCS;
	return Template;
}

static function X2HackRewardTemplate CreateEpicPCSReward(Name TemplateName) {
	local X2HackRewardTemplate Template;
	`CREATE_X2TEMPLATE(class'X2HackRewardTemplate', Template, TemplateName);
	Template.ApplyHackRewardFn = GiveEpicPCS;
	return Template;
}

static function X2HackRewardTemplate CreateLegendaryPCSReward(Name TemplateName) {
	local X2HackRewardTemplate Template;
	`CREATE_X2TEMPLATE(class'X2HackRewardTemplate', Template, TemplateName);
	Template.ApplyHackRewardFn = GiveLegendaryPCS;
	return Template;
}

function GiveCommonPCS(XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState) {
	local X2ItemTemplateManager ItemTemplateManager;
	local XComGameState_Item ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PCSRewards[`SYNC_RAND_STATIC(default.PCSRewards.length)]);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item'));
	ItemState.OnCreation(ItemTemplate);

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	Hacker.AddLoot(ItemState.GetReference(), NewGameState);
}

function GiveRarePCS(XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState) {
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PCSRewards[`SYNC_RAND_STATIC(default.PCSRewards.length)]);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( class'GrimyLoot_Research'.default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = class'GrimyLoot_Research'.static.GenerateMissionNickname(0);
	}
	else {
		ItemState.Nickname = class'GrimyLoot_Research'.static.GetRarityPrefix(0) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = 1;
	ItemState.TradingPostValue = class'GrimyLoot_Research'.static.GetRareEquipmentPrice();
	class'GrimyLoot_Research'.static.ApplyNovelUpgrade(ItemState, default.PCSUpgrades);

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	Hacker.AddLoot(ItemState.GetReference(), NewGameState);
}

function GiveEpicPCS(XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState) {
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PCSRewards[`SYNC_RAND_STATIC(default.PCSRewards.length)]);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( class'GrimyLoot_Research'.default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = class'GrimyLoot_Research'.static.GenerateMissionNickname(1);
	}
	else {
		ItemState.Nickname = class'GrimyLoot_Research'.static.GetRarityPrefix(1) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = 2;
	ItemState.TradingPostValue = class'GrimyLoot_Research'.static.GetEpicEquipmentPrice();
	class'GrimyLoot_Research'.static.ApplyNovelUpgrade(ItemState, default.PCSUpgrades);
	class'GrimyLoot_Research'.static.ApplyNovelUpgrade(ItemState, default.PCSUpgrades);

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	Hacker.AddLoot(ItemState.GetReference(), NewGameState);
}

function GiveLegendaryPCS(XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState) {
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PCSRewards[`SYNC_RAND_STATIC(default.PCSRewards.length)]);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( class'GrimyLoot_Research'.default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = class'GrimyLoot_Research'.static.GenerateMissionNickname(2);
	}
	else {
		ItemState.Nickname = class'GrimyLoot_Research'.static.GetRarityPrefix(2) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = 3;
	ItemState.TradingPostValue = class'GrimyLoot_Research'.static.GetLegendaryEquipmentPrice();
	class'GrimyLoot_Research'.static.ApplyNovelUpgrade(ItemState, default.PCSUpgrades);
	class'GrimyLoot_Research'.static.ApplyNovelUpgrade(ItemState, default.PCSUpgrades);
	class'GrimyLoot_Research'.static.ApplyNovelUpgrade(ItemState, default.PCSUpgrades);

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	Hacker.AddLoot(ItemState.GetReference(), NewGameState);
}