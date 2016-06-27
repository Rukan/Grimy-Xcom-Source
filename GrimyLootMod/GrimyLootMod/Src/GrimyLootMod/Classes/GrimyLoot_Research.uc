class GrimyLoot_Research extends X2StrategyElement config(GrimyLootMod);

var config int RARE_RESEARCH_COST, EPIC_RESEARCH_COST, LEGENDARY_RESEARCH_COST;
var config int RARE_RESEARCH_COST_INCREASE, EPIC_RESEARCH_COST_INCREASE, LEGENDARY_RESEARCH_COST_INCREASE;
var config int WEAPON_UNLOCK_CHANCE, ARMOR_UNLOCK_CHANCE;
var config int LIGHT_ARMOR_CHANCE, HEAVY_ARMOR_CHANCE;
var config int RARE_VALUE, EPIC_VALUE, LEGENDARY_VALUE;
var config bool RANDOMIZE_WEAPON_APPEARANCE, RANDOMIZE_NICKNAMES;
var config string RARE_COLOR, EPIC_COLOR, LEGENDARY_COLOR;

var config array<name> PrimaryAffixOne, PrimaryAffixTwo, PrimaryAffixThree, PrimaryAffixFour;
var config array<name> PistolAffixOne, PistolAffixTwo, PistolAffixThree;
var config array<name> SwordAffixOne, SwordAffixTwo, SwordAffixThree;
var config array<name> GremlinAffixOne, GremlinAffixTwo, GremlinAffixThree;
var config array<name> PsiAmpAffixOne, PsiAmpAffixTwo, PsiAmpAffixThree;
var config array<name> GrenadeLauncherAffixOne, GrenadeLauncherAffixTwo, GrenadeLauncherAffixThree;
var config array<name> ArmorAffixOne, ArmorAffixTwo, ArmorAffixThree;

var config array<name> AR_T1, AR_T2, AR_T3;
var config array<name> SG_T1, SG_T2, SG_T3;
var config array<name> LMG_T1, LMG_T2, LMG_T3;
var config array<name> SR_T1, SR_T2, SR_T3;
var config array<name> SMG_T1, SMG_T2, SMG_T3;

var config array<name> Pistol_T1, Pistol_T2, Pistol_T3;
var config array<name> Sword_T1, Sword_T2, Sword_T3;
var config array<name> Gremlin_T1, Gremlin_T2, Gremlin_T3;
var config array<name> PA_T1, PA_T2, PA_T3;
var config array<name> GL_T1, GL_T2;

var config array<name> MA_T1;
var config array<name> LA_T2, MA_T2, HA_T2;
var config array<name> LA_T3, MA_T3, HA_T3;

var config bool bEnableAlienRulers;
var config int iAlienRulerMult;

var localized String m_strRareName, m_strEpicName, m_strLegendaryName;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;
	
	Techs.AddItem(IdentifyRareLockboxTemplate());
	Techs.AddItem(IdentifyEpicLockboxTemplate());
	Techs.AddItem(IdentifyLegendaryLockboxTemplate());
	
	Techs.AddItem(IdentifyEpicLockboxInstantTemplate());
	Techs.AddItem(IdentifyLegendaryLockboxInstantTemplate());

	return Techs;
}

static function X2DataTemplate IdentifyRareLockboxTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_IdentifyRareLockbox');
	Template.DisplayName = "<font color='#" $ class'GrimyLoot_Research'.default.RARE_COLOR $ "'><b>" $ Template.DisplayName $ "</b></font>";
	Template.PointsToComplete = GetRareResearchCost();
	Template.RepeatPointsIncrease = GetRareResearchCostIncrease();
	Template.bRepeatable = true;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Storage_Module";
	Template.SortingTier = 4;
	//Template.ResearchCompletedFn = IdentifyRareLockboxDelegate;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('GrimyUnidentifiedLockboxRare');

	// Cost
	Artifacts.ItemTemplateName = 'GrimyUnidentifiedLockboxRare';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate IdentifyEpicLockboxTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_IdentifyEpicLockbox');
	Template.DisplayName = "<font color='#" $ class'GrimyLoot_Research'.default.EPIC_COLOR $ "'><b>" $ Template.DisplayName $ "</b></font>";
	Template.PointsToComplete = GetEpicResearchCost();
	Template.RepeatPointsIncrease = GetEpicResearchCostIncrease();
	Template.bRepeatable = true;
	Template.strImage = "img:///GrimyLootPackage.LockboxAL";
	Template.SortingTier = 4;
	//Template.ResearchCompletedFn = IdentifyEpicLockboxDelegate;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('GrimyUnidentifiedLockboxEpic');

	// Cost
	Artifacts.ItemTemplateName = 'GrimyUnidentifiedLockboxEpic';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate IdentifyLegendaryLockboxTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_IdentifyLegendaryLockbox');
	Template.DisplayName = "<font color='#" $ class'GrimyLoot_Research'.default.LEGENDARY_COLOR $ "'><b>" $ Template.DisplayName $ "</b></font>";
	Template.PointsToComplete = GetLegendaryResearchCost();
	Template.RepeatPointsIncrease = GetLegendaryResearchCostIncrease();
	Template.bRepeatable = true;
	Template.strImage = "img:///GrimyLootPackage.LockboxER";
	Template.SortingTier = 4;
	//Template.ResearchCompletedFn = IdentifyLegendaryLockboxDelegate;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('GrimyUnidentifiedLockboxLegendary');

	// Cost
	Artifacts.ItemTemplateName = 'GrimyUnidentifiedLockboxLegendary';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate IdentifyEpicLockboxInstantTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_IdentifyEpicLockboxInstant');
	Template.DisplayName = "<font color='#" $ class'GrimyLoot_Research'.default.EPIC_COLOR $ "'><b>" $ Template.DisplayName $ "</b></font>";
	Template.PointsToComplete = 1;
	Template.bRepeatable = true;
	Template.strImage = "img:///GrimyLootPackage.LockboxAL";
	Template.SortingTier = 4;
	//Template.ResearchCompletedFn = IdentifyEpicLockboxDelegate;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('GrimyUnidentifiedLockboxEpic');
	Template.Requirements.RequiredItems.AddItem('AdventDatapad');

	// Cost
	Artifacts.ItemTemplateName = 'GrimyUnidentifiedLockboxEpic';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	Artifacts.ItemTemplateName = 'AdventDatapad';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate IdentifyLegendaryLockboxInstantTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'Tech_IdentifyLegendaryLockboxInstant');
	Template.DisplayName = "<font color='#" $ class'GrimyLoot_Research'.default.LEGENDARY_COLOR $ "'><b>" $ Template.DisplayName $ "</b></font>";
	Template.PointsToComplete = 1;
	Template.bRepeatable = true;
	Template.strImage = "img:///GrimyLootPackage.LockboxER";
	Template.SortingTier = 4;
	//Template.ResearchCompletedFn = IdentifyLegendaryLockboxDelegate;

	// Requirements
	Template.Requirements.RequiredItems.AddItem('GrimyUnidentifiedLockboxLegendary');
	Template.Requirements.RequiredItems.AddItem('AlienDatapad');

	// Cost
	Artifacts.ItemTemplateName = 'GrimyUnidentifiedLockboxLegendary';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	Artifacts.ItemTemplateName = 'AlienDatapad';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	return Template;
}

// ------------------------
// Identification Functions
// ------------------------
static function IdentifyRareLockboxDelegate(XComGameState NewGameState, XComGameState_Tech TechState) {
	IdentifyRareLockbox(NewGameState, TechState);
}
static function IdentifyEpicLockboxDelegate(XComGameState NewGameState, XComGameState_Tech TechState) {
	IdentifyEpicLockbox(NewGameState, TechState);
}
static function IdentifyLegendaryLockboxDelegate(XComGameState NewGameState, XComGameState_Tech TechState) {
	IdentifyLegendaryLockbox(NewGameState, TechState);
}

static function int IdentifyIndex(bool bAllowArmorVariants) {
	local int RandInt;
	local XComGameState_HeadquartersXCom XComHQ;
	
	XComHQ = `XCOMHQ;
	RandInt = RAND(100);
	if ( RandInt < GetWeaponUnlockChance() ) {	// Produce a weapon
		if ( XComHQ.HasItemByName('SMG_CV') ) {
			return RAND(5);
		}
		else {
			return RAND(4);
		}
	}
	else if ( RandInt < GetWeaponUnlockChance() + GetArmorUnlockChance() ) {	// Produce an armor
		if ( !bAllowArmorVariants) { return 6; }
		RandInt = RAND(100);
		if ( RandInt < GetLightArmorChance() ) {
			return 5;
		}
		else if ( RandInt < GetHeavyArmorChance() + GetLightArmorChance() ) {
			return 7;
		}
		else {
			return 6;
		}
	}
	else {	// Produce a sidearm
		if ( XComHQ.HasFacilityByName('PsiChamber') ) {
			RandInt = RAND(5);
		}
		else {
			RandInt = RAND(4);
		}
		return RandInt + 8;
	}
}

static function GrimyLoot_GameState_Loot IdentifyByIndex(XComGameState_Tech TechState, int Index, int BonusSlots) {
	local XComGameState NewGameState;
	local GrimyLoot_GameState_Loot LootState;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Grimy Loot");

	switch ( Index ) {
		case 0:
			LootState = IdentifyAR(NewGameState, TechState, BonusSlots + 1);
			break;
		case 1:
			LootState = IdentifySG(NewGameState, TechState, BonusSlots + 1);
			break;
		case 2:
			LootState = IdentifyLMG(NewGameState, TechState, BonusSlots + 1);
			break;
		case 3:
			LootState = IdentifySR(NewGameState, TechState, BonusSlots + 1);
			break;
		case 4:
			LootState = IdentifySMG(NewGameState, TechState, BonusSlots + 1);
			break;
		case 5:
			LootState = IdentifyLightArmor(NewGameState, TechState, BonusSlots);
			break;
		case 6:
			LootState = IdentifyMediumArmor(NewGameState, TechState, BonusSlots);
			break;
		case 7:
			LootState = IdentifyHeavyArmor(NewGameState, TechState, BonusSlots);
			break;
		case 8:
			LootState = IdentifyPistol(NewGameState, TechState, BonusSlots);
			break;
		case 9:
			LootState = IdentifySword(NewGameState, TechState, BonusSlots);
			break;
		case 10:
			LootState = IdentifyGremlin(NewGameState, TechState, BonusSlots);
			break;
		case 11:
			LootState = IdentifyGrenadeLauncher(NewGameState, TechState, BonusSlots);
			break;
		case 12:
			LootState = IdentifyPsiAmp(NewGameState, TechState, BonusSlots);
			break;
	}

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	class'GrimyLoot_ScreenListener_MCM'.static.StaticSaveConfig();
	return LootState;
}

static function GrimyLoot_GameState_Loot IdentifyRareLockbox(XComGameState NewGameState, XComGameState_Tech TechState) {
	local int RandInt;
	local XComGameState_HeadquartersXCom XComHQ;
	
	XComHQ = `XCOMHQ;
	RandInt = `SYNC_RAND_STATIC(100);
	if ( RandInt < GetWeaponUnlockChance() ) {	// Produce a weapon
		if ( XComHQ.HasItemByName('SMG_CV') ) {
			RandInt = `SYNC_RAND_STATIC(5);
		}
		else {
			RandInt = `SYNC_RAND_STATIC(4);
		}
		switch (RandInt) {
			case 0:
				return IdentifyAR(NewGameState, TechState, 2);
			case 1:
				return IdentifyLMG(NewGameState, TechState, 2);
			case 2:
				return IdentifySG(NewGameState, TechState, 2);
			case 3:
				return IdentifySR(NewGameState, TechState, 2);
			case 4:
				return IdentifySMG(NewGameState, TechState, 2);
		}
	}
	else if ( RandInt < GetWeaponUnlockChance() + GetArmorUnlockChance() ) {	// Produce an armor
		IdentifyMediumArmor(NewGameState, TechState, 1);
	}
	else {	// Produce a sidearm
		if ( XComHQ.HasFacilityByName('PsiChamber') ) {
			RandInt = `SYNC_RAND_STATIC(5);
		}
		else {
			RandInt = `SYNC_RAND_STATIC(4);
		}
		switch (RandInt) {
			case 0:
				return IdentifyPistol(NewGameState, TechState, 1);
			case 1:
				return IdentifySword(NewGameState, TechState, 1);
			case 2:
				return IdentifyGremlin(NewGameState, TechState, 1);
			case 3:
				return IdentifyGrenadeLauncher(NewGameState, TechState, 1);
			case 4:
				return IdentifyPsiAmp(NewGameState, TechState, 1);
		}
	}
}

static function GrimyLoot_GameState_Loot IdentifyEpicLockbox(XComGameState NewGameState, XComGameState_Tech TechState) {
	local int RandInt;
	local XComGameState_HeadquartersXCom XComHQ;
	
	XComHQ = `XCOMHQ;
	RandInt = `SYNC_RAND_STATIC(100);
	if ( RandInt < GetWeaponUnlockChance() ) {	// Produce a weapon
		if ( XComHQ.HasItemByName('SMG_CV') ) {
			RandInt = `SYNC_RAND_STATIC(5);
		}
		else {
			RandInt = `SYNC_RAND_STATIC(4);
		}
		switch (RandInt) {
			case 0:
				return IdentifyAR(NewGameState, TechState, 3);
			case 1:
				return IdentifyLMG(NewGameState, TechState, 3);
			case 2:
				return IdentifySG(NewGameState, TechState, 3);
			case 3:
				return IdentifySR(NewGameState, TechState, 3);
			case 4:
				return IdentifySMG(NewGameState, TechState, 3);
		}
	}
	else if ( RandInt < GetWeaponUnlockChance() + GetArmorUnlockChance() ) {	// Produce an armor 
		RandInt = `SYNC_RAND_STATIC(100);
		if ( RandInt < GetLightArmorChance() ) {
			return IdentifyLightArmor(NewGameState, TechState, 2);
		}
		else if ( RandInt < GetHeavyArmorChance() + GetLightArmorChance() ) {
			return IdentifyHeavyArmor(NewGameState, TechState, 2);
		}
		else {
			return IdentifyMediumArmor(NewGameState, TechState, 2);
		}
	}
	else {	// Produce a sidearm
		if ( XComHQ.HasFacilityByName('PsiChamber') ) {
			RandInt = `SYNC_RAND_STATIC(5);
		}
		else {
			RandInt = `SYNC_RAND_STATIC(4);
		}
		switch (RandInt) {
			case 0:
				return IdentifyPistol(NewGameState, TechState, 2);
			case 1:
				return IdentifySword(NewGameState, TechState, 2);
			case 2:
				return IdentifyGremlin(NewGameState, TechState, 2);
			case 3:
				return IdentifyGrenadeLauncher(NewGameState, TechState, 2);
			case 4:
				return IdentifyPsiAmp(NewGameState, TechState, 2);
		}
	}
}

static function GrimyLoot_GameState_Loot IdentifyLegendaryLockbox(XComGameState NewGameState, XComGameState_Tech TechState) {
	local int RandInt;
	local XComGameState_HeadquartersXCom XComHQ;
	
	XComHQ = `XCOMHQ;
	RandInt = `SYNC_RAND_STATIC(100);
	if ( RandInt < GetWeaponUnlockChance() ) {	// Produce a weapon
		if ( XComHQ.HasItemByName('SMG_CV') ) {
			RandInt = `SYNC_RAND_STATIC(5);
		}
		else {
			RandInt = `SYNC_RAND_STATIC(4);
		}
		switch (RandInt) {
			case 0:
				return IdentifyAR(NewGameState, TechState, 4);
			case 1:
				return IdentifyLMG(NewGameState, TechState, 4);
			case 2:
				return IdentifySG(NewGameState, TechState, 4);
			case 3:
				return IdentifySR(NewGameState, TechState, 4);
			case 4:
				return IdentifySMG(NewGameState, TechState, 4);
		}
	}
	else if ( RandInt < GetWeaponUnlockChance() + GetArmorUnlockChance() ) {	// Produce an armor 
		RandInt = `SYNC_RAND_STATIC(100);
		if ( RandInt < GetLightArmorChance() ) {
			return IdentifyLightArmor(NewGameState, TechState, 2);
		}
		else if ( RandInt < GetHeavyArmorChance() + GetLightArmorChance() ) {
			return IdentifyHeavyArmor(NewGameState, TechState, 2);
		}
		else {
			return IdentifyMediumArmor(NewGameState, TechState, 3);
		}
	}
	else {	// Produce a sidearm
		if ( XComHQ.HasFacilityByName('PsiChamber') ) {
			RandInt = `SYNC_RAND_STATIC(5);
		}
		else {
			RandInt = `SYNC_RAND_STATIC(4);
		}
		switch (RandInt) {
			case 0:
				return IdentifyPistol(NewGameState, TechState, 3);
			case 1:
				return IdentifySword(NewGameState, TechState, 3);
			case 2:
				return IdentifyGremlin(NewGameState, TechState, 3);
			case 3:
				return IdentifyGrenadeLauncher(NewGameState, TechState, 3);
			case 4:
				return IdentifyPsiAmp(NewGameState, TechState, 3);
		}
	}
}


static function GrimyLoot_GameState_Loot IdentifyAR(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('AssaultRifle_BM') ) //HeavyPlasma PlasmaSniper AlloyCannon
	{
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.AR_T3[`SYNC_RAND_STATIC(default.AR_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('AssaultRifle_MG') )
	{
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.AR_T2[`SYNC_RAND_STATIC(default.AR_T2.length)]);
	}
	else 
	{
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.AR_T1[`SYNC_RAND_STATIC(default.AR_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots-1);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots-1) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE )
	{
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixOne);
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixTwo);
	if ( NumSlots >= 3 )
	{
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixThree);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 4 )
	{
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixFour);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if (XComHQ == none)
	{
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifySG(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('Shotgun_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SG_T3[`SYNC_RAND_STATIC(default.SG_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('Shotgun_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SG_T2[`SYNC_RAND_STATIC(default.SG_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SG_T1[`SYNC_RAND_STATIC(default.SG_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots-1);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots-1) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixOne);
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixTwo);
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixThree);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 4 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixFour);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate;
	TechState.bSeenResearchCompleteScreen = true;
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifySR(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('SniperRifle_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SR_T3[`SYNC_RAND_STATIC(default.SR_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('SniperRifle_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SR_T2[`SYNC_RAND_STATIC(default.SR_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SR_T1[`SYNC_RAND_STATIC(default.SR_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots-1);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots-1) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixOne);
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixTwo);
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixThree);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 4 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixFour);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyLMG(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('Cannon_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.LMG_T3[`SYNC_RAND_STATIC(default.LMG_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('Cannon_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.LMG_T2[`SYNC_RAND_STATIC(default.LMG_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.LMG_T1[`SYNC_RAND_STATIC(default.LMG_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots-1);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots-1) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixOne);
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixTwo);
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixThree);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 4 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixFour);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifySMG(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('SMG_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SMG_T3[`SYNC_RAND_STATIC(default.SMG_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('SMG_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SMG_T2[`SYNC_RAND_STATIC(default.SMG_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.SMG_T1[`SYNC_RAND_STATIC(default.SMG_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots-1);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots-1) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixOne);
	ApplyNovelUpgrade(ItemState, default.PrimaryAffixTwo);
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixThree);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 4 ) {
		ApplyNovelUpgrade(ItemState, default.PrimaryAffixFour);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyPistol(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	//Add the correct weapon type, be it magnetic, plasma, or conventional
	
	if ( XComHQ.HasItemByName('Pistol_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Pistol_T3[`SYNC_RAND_STATIC(default.Pistol_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('Pistol_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Pistol_T2[`SYNC_RAND_STATIC(default.Pistol_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Pistol_T1[`SYNC_RAND_STATIC(default.Pistol_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PistolAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.PistolAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NUmSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.PistolAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifySword(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	//Add the correct weapon type, be it magnetic, plasma, or conventional

	if ( XComHQ.HasItemByName('Sword_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Sword_T3[`SYNC_RAND_STATIC(default.Sword_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('Sword_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Sword_T2[`SYNC_RAND_STATIC(default.Sword_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Sword_T1[`SYNC_RAND_STATIC(default.Sword_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.SwordAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.SwordAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NUmSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.SwordAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyGremlin(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('Gremlin_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Gremlin_T3[`SYNC_RAND_STATIC(default.Gremlin_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('Gremlin_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Gremlin_T2[`SYNC_RAND_STATIC(default.Gremlin_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.Gremlin_T1[`SYNC_RAND_STATIC(default.Gremlin_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.GremlinAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.GremlinAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NUmSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.GremlinAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none)
	{
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyGrenadeLauncher(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('GrenadeLauncher_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.GL_T2[`SYNC_RAND_STATIC(default.GL_T2.length)]);
	}
	else  {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.GL_T1[`SYNC_RAND_STATIC(default.GL_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.GrenadeLauncherAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.GrenadeLauncherAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.GrenadeLauncherAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyPsiAmp(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	//Add the correct weapon type, be it magnetic, plasma, or conventional

	if ( XComHQ.HasItemByName('PsiAmp_BM') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PA_T3[`SYNC_RAND_STATIC(default.PA_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('PsiAmp_MG') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PA_T2[`SYNC_RAND_STATIC(default.PA_T2.length)]);
	}
	else  {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.PA_T1[`SYNC_RAND_STATIC(default.PA_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.PsiAmpAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.PsiAmpAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.PsiAmpAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyLightArmor(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('MediumPoweredArmor') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.LA_T3[`SYNC_RAND_STATIC(default.LA_T3.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.LA_T2[`SYNC_RAND_STATIC(default.LA_T2.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetEpicEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.ArmorAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.ArmorAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.ArmorAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyHeavyArmor(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('MediumPoweredArmor') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.HA_T3[`SYNC_RAND_STATIC(default.HA_T3.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.HA_T2[`SYNC_RAND_STATIC(default.HA_T2.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetEpicEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.ArmorAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.ArmorAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.ArmorAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

static function GrimyLoot_GameState_Loot IdentifyMediumArmor(XComGameState NewGameState, XComGameState_Tech TechState, int NumSlots) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local GrimyLoot_GameState_Loot ItemState;
	local X2ItemTemplate ItemTemplate;
	
	
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = `XComHQ;

	if ( XComHQ.HasItemByName('MediumPoweredArmor') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.MA_T3[`SYNC_RAND_STATIC(default.MA_T3.length)]);
	}
	else if ( XComHQ.HasItemByName('MediumPlatedArmor') ) {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.MA_T2[`SYNC_RAND_STATIC(default.MA_T2.length)]);
	}
	else {
		ItemTemplate = ItemTemplateManager.FindItemTemplate(default.MA_T1[`SYNC_RAND_STATIC(default.MA_T1.length)]);
	}
	XComHQ.UpdateItemTemplateToHighestAvailableUpgrade(ItemTemplate);
	
	//ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
	ItemState.OnCreation(ItemTemplate);
	if ( default.RANDOMIZE_NICKNAMES ) {
		ItemState.Nickname = GenerateNickname(NumSlots);
	}
	else {
		ItemState.Nickname = GetRarityPrefix(NumSlots) @ ItemTemplate.GetItemFriendlyNameNoStats();
	}
	ItemState.NumUpgrades = NumSlots;
	ItemState.TradingPostValue = GetRareEquipmentPrice();
	if ( default.RANDOMIZE_WEAPON_APPEARANCE ) {
		ItemState.WeaponAppearance.iWeaponTint = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.iWeaponDeco = `SYNC_RAND_STATIC(`CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length);
		ItemState.WeaponAppearance.nmWeaponPattern = GetRandPatternName();
	}
	ApplyNovelUpgrade(ItemState, default.ArmorAffixOne);
	if ( NumSlots >= 2 ) {
		ApplyNovelUpgrade(ItemState, default.ArmorAffixTwo);
		ItemState.TradingPostValue = GetEpicEquipmentPrice();
	}
	if ( NumSlots >= 3 ) {
		ApplyNovelUpgrade(ItemState, default.ArmorAffixThree);
		ItemState.TradingPostValue = GetLegendaryEquipmentPrice();
	}

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ) { break; }

	if (XComHQ == none) {
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	NewGameState.AddStateObject(ItemState);
	ItemState.OnItemBuilt(NewGameState);
	TechState.ItemReward = ItemTemplate; // Needed for UI Alert display info
	TechState.bSeenResearchCompleteScreen = true; // Reset the research report for techs that are repeatable
	XComHQ.PutItemInInventory(NewGameState, ItemState);
	`XEVENTMGR.TriggerEvent('ItemConstructionCompleted', ItemState, ItemState, NewGameState);
	return ItemState;
}

//#############################################################################################
//----------------   UPGRADE MANAGEMENT   -----------------------------------------------------
//#############################################################################################
static function string GenerateNickname(int rarity) {
	local X2SoldierClassTemplateManager		SoldierManager;
	local array<X2SoldierClassTemplate>		SoldierArray;
	local X2SoldierClassTemplate			SoldierTemplate;
	local string							RetName, AlertName;

	SoldierManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	SoldierArray = SoldierManager.GetAllSoldierClassTemplates();
	SoldierTemplate = SoldierArray[`SYNC_RAND_STATIC(SoldierArray.length)];
	Switch ( `SYNC_RAND_STATIC(3) ) {
		case 0:
			Retname = SoldierTemplate.RandomNicknames[`SYNC_RAND_STATIC(SoldierTemplate.RandomNicknames.length)];
			break;
		case 1:
			Retname = SoldierTemplate.RandomNicknames_Female[`SYNC_RAND_STATIC(SoldierTemplate.RandomNicknames_Female.length)];
			break;
		case 2:
			Retname = SoldierTemplate.RandomNicknames_Male[`SYNC_RAND_STATIC(SoldierTemplate.RandomNicknames_Male.length)];
			break;
	}
	if ( Retname == "" ) {
		return GenerateNickname(rarity);
	}

	AlertName = "<font size='50'><b>" $ RetName $ "</b></font>";
	switch ( rarity ) {
		case 1:
			RetName = "<font color='#" $ default.RARE_COLOR $ "'><b>" $ RetName $ "</b></font>";
			break;
		case 2:
			RetName = "<font color='#" $ default.EPIC_COLOR $ "'><b>" $ RetName $ "</b></font>";
			break;
		case 3:
			RetName = "<font color='#" $ default.LEGENDARY_COLOR $ "'><b>" $ RetName $ "</b></font>";
			break;
	}
	class'GrimyLoot_ScreenListener'.static.SetRecentName(AlertName);
	return RetName;
}

static function string GenerateMissionNickname(int rarity) {
	local string							RetName, AlertName;

	RetName = class'XGMission'.static.GenerateOpName() $ " Simulation";

	AlertName = "<font size='50'><b>" $ RetName $ "</b></font>";
	switch ( rarity ) {
		case 1:
			RetName = "<font color='#" $ default.RARE_COLOR $ "'><b>" $ RetName $ "</b></font>";
			break;
		case 2:
			RetName = "<font color='#" $ default.EPIC_COLOR $ "'><b>" $ RetName $ "</b></font>";
			break;
		case 3:
			RetName = "<font color='#" $ default.LEGENDARY_COLOR $ "'><b>" $ RetName $ "</b></font>";
			break;
	}
	class'GrimyLoot_ScreenListener'.static.SetRecentName(AlertName);
	return RetName;
}

static function string GetRarityPrefix(int Tier)
{
	switch ( Tier )
	{
		case 1:
			return default.m_strRareName;
		case 2:
			return default.m_strEpicName;
		case 3:
			return default.m_strLegendaryName;
		default:
			return "";
	}
}

static function ApplyNovelUpgrade(XComGameState_Item ItemState, array<name> UpgradeList) {
	local X2WeaponUpgradeTemplate TestUpgrade;
	local int UpgradeIndex;

	local X2ItemTemplateManager ItemTemplateManager;
	//Create a new item instance
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	UpgradeIndex = `SYNC_RAND_STATIC( UpgradeList.Length );
	TestUpgrade = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(UpgradeList[UpgradeIndex]));
	
	if ( TestUpgrade == none || HasUpgrade(ItemState, TestUpgrade) || ( HasProwlersProfit() && TestUpgrade.Tier == 0 ) ) {
		ApplyNovelUpgrade(ItemState, UpgradeList);
	}
	else {
		if ( testUpgrade == X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate('GrimyProcessor_Bsc')) ) {
			ItemState.ApplyWeaponUpgradeTemplate(X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate('GrimyWildcat_Bsc')));
		}
		else if ( testUpgrade == X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate('GrimyProcessor_Adv')) ) {
			ItemState.ApplyWeaponUpgradeTemplate(X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate('GrimyWildcat_Adv')));
		}
		else if ( testUpgrade == X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate('GrimyProcessor_Sup')) ) {
			ItemState.ApplyWeaponUpgradeTemplate(X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate('GrimyWildcat_Sup')));
		}
		else {
			ItemState.ApplyWeaponUpgradeTemplate(TestUpgrade);
		}
	}
	if ( class'GrimyLoot_ScreenListener_MCM'.default.FoundUpgrades.Find(UpgradeList[UpgradeIndex]) == INDEX_NONE ) {
		class'GrimyLoot_ScreenListener_MCM'.default.FoundUpgrades.AddItem(UpgradeList[UpgradeIndex]);
	}
}

static function bool HasUpgrade(XComGameState_Item ItemState, X2WeaponUpgradeTemplate TestUpgrade)
{
	local array<name> UpgradeList;
	local name ReadTemplate;

	UpgradeList = ItemState.GetMyWeaponUpgradeTemplateNames();

	foreach UpgradeList(ReadTemplate) {
		if ( TestUpgrade.MutuallyExclusiveUpgrades.Find(ReadTemplate) != INDEX_NONE ) {
			return true;
		}
	}

	return false;
}

static function name GetRandPatternName()
{
	local int i;
	local array<X2BodyPartTemplate> BodyParts;
	local X2BodyPartTemplateManager PartManager;

	PartManager = class'X2BodyPartTemplateManager'.static.GetBodyPartTemplateManager();
	PartManager.GetFilteredUberTemplates("Patterns", PartManager, `XCOMGAME.SharedBodyPartFilter.FilterAny, BodyParts);
	i = `SYNC_RAND_STATIC(BodyParts.Length);

	if(BodyParts[i].DisplayName != "")
		return BodyParts[i].DataName;
	else 
		return '';
}

//#############################################################################################
//-----------------   CONTINENT SCANNER   -----------------------------------------------------
//#############################################################################################
static function bool HasProwlersProfit()
{
	local XComGameState_Continent ContinentState;

	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Continent', ContinentState)
	{
		if ( ContinentState.ContinentBonus == 'ContinentBonus_ProwlersProfit' && ContinentState.bContinentBonusActive )
		{
			return true;
		}
	}
	return false;
}

//#############################################################################################
//----------------------   ALIEN RULERS   -----------------------------------------------------
//#############################################################################################

static function EnableAlienRulers() {
	local int i, j, NumItems;
	
	if ( default.bEnableAlienRulers ) {
		NumItems = default.AR_T1.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.AR_T1.AddItem(default.AR_T1[i]);
			}
			default.AR_T1.AddItem('AlienHunterRifle_CV');
		}
		
		NumItems = default.AR_T2.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.AR_T2.AddItem(default.AR_T2[i]);
			}
			default.AR_T2.AddItem('AlienHunterRifle_MG');
		}
		
		NumItems = default.AR_T3.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.AR_T3.AddItem(default.AR_T3[i]);
			}
			default.AR_T3.AddItem('AlienHunterRifle_BM');
		}
		
		NumItems = default.Pistol_T1.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.Pistol_T1.AddItem(default.Pistol_T1[i]);
			}
			default.Pistol_T1.AddItem('AlienHunterPistol_CV');
		}
		
		NumItems = default.Pistol_T2.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.Pistol_T2.AddItem(default.Pistol_T2[i]);
			}
			default.Pistol_T2.AddItem('AlienHunterPistol_MG');
		}
		
		NumItems = default.Pistol_T3.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.Pistol_T3.AddItem(default.Pistol_T3[i]);
			}
			default.Pistol_T3.AddItem('AlienHunterPistol_BM');
		}
		
		NumItems = default.Sword_T1.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.Sword_T1.AddItem(default.Sword_T1[i]);
			}
			default.Sword_T1.AddItem('AlienHunterAxe_CV');
		}
		
		NumItems = default.Sword_T2.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.Sword_T2.AddItem(default.Sword_T2[i]);
			}
			default.Sword_T2.AddItem('AlienHunterAxe_MG');
		}
		
		NumItems = default.Sword_T3.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.Sword_T3.AddItem(default.Sword_T3[i]);
			}
			default.Sword_T3.AddItem('AlienHunterAxe_BM');
		}
		
		NumItems = default.MA_T3.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.MA_T3.AddItem(default.MA_T3[i]);
			}
			default.MA_T3.AddItem('MediumAlienArmor');
		}
		
		NumItems = default.LA_T2.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.LA_T2.AddItem(default.LA_T2[i]);
			}
			default.LA_T2.AddItem('LightAlienArmor');
		}
		
		NumItems = default.LA_T3.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.LA_T3.AddItem(default.LA_T3[i]);
			}
			default.LA_T3.AddItem('LightAlienArmorMk2');
		}
		
		NumItems = default.HA_T2.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.HA_T2.AddItem(default.HA_T2[i]);
			}
			default.HA_T2.AddItem('HeavyAlienArmor');
		}
		
		NumItems = default.HA_T3.length;
		for ( i = 0; i < NumItems; i++ ) {
			for ( j = 1; j < default.iAlienRulerMult; j++ ) {
				default.HA_T3.AddItem(default.HA_T3[i]);
			}
			default.HA_T3.AddItem('HeavyAlienArmorMk2');
		}
	}
}

//#############################################################################################
//----------------------   MCM FUNCTIONS   ----------------------------------------------------
//#############################################################################################

static function int GetRareEquipmentPrice() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.RARE_VALUE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.RARE_VALUE;
	}
	else {
		return default.RARE_VALUE;
	}
}

static function int GetEpicEquipmentPrice() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.EPIC_VALUE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.EPIC_VALUE;
	}
	else {
		return default.EPIC_VALUE;
	}
}

static function int GetLegendaryEquipmentPrice() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.LEGENDARY_VALUE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.LEGENDARY_VALUE;
	}
	else {
		return default.LEGENDARY_VALUE;
	}
}

static function int GetRareResearchCost() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.RARE_RESEARCH_COST > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.RARE_RESEARCH_COST;
	}
	else {
		return default.RARE_RESEARCH_COST;
	}
}

static function int GetEpicResearchCost() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.EPIC_RESEARCH_COST > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.EPIC_RESEARCH_COST;
	}
	else {
		return default.EPIC_RESEARCH_COST;
	}
}

static function int GetLegendaryResearchCost() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.LEGENDARY_RESEARCH_COST > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.LEGENDARY_RESEARCH_COST;
	}
	else {
		return default.LEGENDARY_RESEARCH_COST;
	}
}

static function int GetRareResearchCostIncrease() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.RARE_RESEARCH_COST_INCREASE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.RARE_RESEARCH_COST_INCREASE;
	}
	else {
		return default.RARE_RESEARCH_COST_INCREASE;
	}
}

static function int GetEpicResearchCostIncrease() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.EPIC_RESEARCH_COST_INCREASE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.EPIC_RESEARCH_COST_INCREASE;
	}
	else {
		return default.EPIC_RESEARCH_COST_INCREASE;
	}
}

static function int GetLegendaryResearchCostIncrease() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.LEGENDARY_RESEARCH_COST_INCREASE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.LEGENDARY_RESEARCH_COST_INCREASE;
	}
	else {
		return default.LEGENDARY_RESEARCH_COST_INCREASE;
	}
}

static function int GetLightArmorChance() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.LIGHT_ARMOR_CHANCE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.LIGHT_ARMOR_CHANCE;
	}
	else {
		return default.LIGHT_ARMOR_CHANCE;
	}
}

static function int GetHeavyArmorChance() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.HEAVY_ARMOR_CHANCE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.HEAVY_ARMOR_CHANCE;
	}
	else {
		return default.HEAVY_ARMOR_CHANCE;
	}
}

static function int GetWeaponUnlockChance() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.WEAPON_UNLOCK_CHANCE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.WEAPON_UNLOCK_CHANCE;
	}
	else {
		return default.WEAPON_UNLOCK_CHANCE;
	}
}

static function int GetArmorUnlockChance() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.ARMOR_UNLOCK_CHANCE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.ARMOR_UNLOCK_CHANCE;
	}
	else {
		return default.ARMOR_UNLOCK_CHANCE;
	}
}