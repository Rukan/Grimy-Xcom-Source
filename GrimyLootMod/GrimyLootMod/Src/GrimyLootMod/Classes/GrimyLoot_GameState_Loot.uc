class GrimyLoot_GameState_Loot extends XComGameState_Item;

var int NumUpgrades;
var int TradingPostValue;

simulated function array<UISummary_ItemStat> GetUISummary_ItemBasicStats() {
	local array<UISummary_ItemStat>	Result;
	local UISummary_ItemStat		Item; 
	local X2WeaponUpgradeTemplate	UpgradeTemplate;

	local X2AbilityTemplateManager	AbilityManager;
	local X2AbilityTemplate			AbilityTemplate;
	local name						AbilityName;

	local UIAbilityStatMarkup		AbilityMarkup;
	local delegate<X2StrategyGameRulesetDataStructures.SpecialRequirementsDelegate> ShouldStatDisplayFn;

	// TODO: @gameplay: Other stat functions and types 
	if (m_ItemTemplate.IsA('X2WeaponTemplate')) {
		Result = GetUISummary_WeaponStats();
	}
	else {
		Result = GetUISummary_DefaultStats();
	}

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	foreach m_arrWeaponUpgradeTemplates(UpgradeTemplate) {
		`LOG("ITERATING UPGRADE TEMPLATE");
		foreach UpgradeTemplate.BonusAbilities(AbilityName) {
			`LOG("ITERATING BONUSABILITIES");
			AbilityTemplate = AbilityManager.FindAbilityTemplate(AbilityName);
			foreach AbilityTemplate.UIStatMarkups(AbilityMarkup) {
				`LOG("ITERATING MARKUPS");
				ShouldStatDisplayFn = AbilityMarkup.ShouldStatDisplayFn;
				if (ShouldStatDisplayFn != None && !ShouldStatDisplayFn()) {
					continue;
				}

				if( AbilityMarkup.StatModifier != 0 || AbilityMarkup.bForceShow ) {
					Item.Label = AbilityMarkup.StatLabel;
					Item.Value = string(AbilityMarkup.StatModifier);
					Result.AddItem(Item);
				}
			}
		}
	}
	
	return Result;
}

simulated function array<string> GetMyWeaponUpgradeTemplatesCategoryIcons()
{
	local array<X2WeaponUpgradeTemplate> Templates;
	local int TemplateIdx, LocalIdx;
	local array<string> LocalIcons, FinalIcons; 

	Templates = GetMyWeaponUpgradeTemplates();
	for( TemplateIdx = 0; TemplateIdx < Templates.length; TemplateIdx++ )
	{
		LocalIcons = Templates[TemplateIdx].GetAttachmentInventoryCategoryImages(self);
		
		if ( LocalIcons.length == 0 ) {
			LocalIcons.AddItem("img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		}

		for( LocalIdx = 0; LocalIdx < LocalIcons.length; LocalIdx++ )
			FinalIcons.AddItem(LocalIcons[LocalIdx]);
	}
	return FinalIcons; 
}

simulated function array<UISummary_TacaticalText> GetUISummary_TacticalTextUpgrades()
{
	local array<X2WeaponUpgradeTemplate> Upgrades; 
	local X2WeaponUpgradeTemplate UpgradeTemplate; 
	local UISummary_TacaticalText Data; 
	local array<UISummary_TacaticalText> Items;
	local int iUpgrade; 
	local array<string> UpgradeIcons; 

	Upgrades = GetMyWeaponUpgradeTemplates(); 

	for( iUpgrade = 0; iUpgrade < Upgrades.length; iUpgrade++ )
	{
		UpgradeTemplate = Upgrades[iUpgrade];
		
		Data.Name = UpgradeTemplate.GetItemFriendlyName(); 
		Data.Description = UpgradeTemplate.GetItemBriefSummary(); 

		UpgradeIcons = UpgradeTemplate.GetAttachmentInventoryCategoryImages(self);
		if( UpgradeIcons.length > 0 )
			Data.Icon = UpgradeIcons[0];
		else
			Data.Icon = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope";

		Items.AddItem(Data);
	}

	return Items; 
}

DefaultProperties
{
	NumUpgrades = 0;
	TradingPostValue = 0;
}