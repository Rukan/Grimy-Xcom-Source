//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_GrimyLootMod.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_GrimyLootMod extends X2DownloadableContentInfo config(GrimyLootMod);

var config array<name> CONTINENT_BONUSES;
var config int NUM_CONTINENTS;

static function UpdatePsiAbilities() {
	local X2AbilityTemplateManager					AbilityManager;
	local X2AbilityTemplate							AbilityTemplate;
	local GrimyLoot_ChargeCost						ChargeCost;
	local X2Condition_AbilityProperty				AbilityCondition;
	local X2Effect_GrantActionPoints				ActionPointEffect;
	local GrimyLoot_DominationCooldown				Cooldown;
	local GrimyLoot_TargetCursor					CursorTarget;
	local GrimyLoot_MultiTargetRadius				RadiusMultiTarget;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplate = AbilityManager.FindAbilityTemplate('LaunchGrenade');

	CursorTarget = new class'GrimyLoot_TargetCursor';
	CursorTarget.bRestrictToWeaponRange = true;
	AbilityTemplate.AbilityTargetStyle = CursorTarget;

	RadiusMultiTarget = new class'GrimyLoot_MultiTargetRadius';
	RadiusMultiTarget.bUseWeaponRadius = true;
	RadiusMultiTarget.SoldierAbilityName = 'VolatileMix';
	RadiusMultiTarget.BonusRadius = class'X2Ability_GrenadierAbilitySet'.default.VOLATILE_RADIUS;
	AbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Soulfire');
	ChargeCost = new class'GrimyLoot_ChargeCost';
	ChargeCost.NumCharges = 1;
	ChargeCost.ReqAbility = 'GrimyBonusSoulfire';
	AbilityTemplate.AbilityCosts.AddItem(ChargeCost);

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Insanity');
	ChargeCost = new class'GrimyLoot_ChargeCost';
	ChargeCost.NumCharges = 1;
	ChargeCost.ReqAbility = 'GrimyBonusInsanity';
	AbilityTemplate.AbilityCosts.AddItem(ChargeCost);

	AbilityTemplate = AbilityManager.FindAbilityTemplate('VoidRift');
	ChargeCost = new class'GrimyLoot_ChargeCost';
	ChargeCost.NumCharges = 1;
	ChargeCost.ReqAbility = 'GrimyBonusVoidRift';
	AbilityTemplate.AbilityCosts.AddItem(ChargeCost);

	AbilityTemplate = AbilityManager.FindAbilityTemplate('NullLance');
	ChargeCost = new class'GrimyLoot_ChargeCost';
	ChargeCost.NumCharges = 1;
	ChargeCost.ReqAbility = 'GrimyBonusNullLance';
	AbilityTemplate.AbilityCosts.AddItem(ChargeCost);

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Inspire');
	ChargeCost = new class'GrimyLoot_ChargeCost';
	ChargeCost.NumCharges = 1;
	ChargeCost.ReqAbility = 'GrimyBonusInspire';
	AbilityTemplate.AbilityCosts.AddItem(ChargeCost);

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyBonusInspire');
	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 1;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
	ActionPointEffect.TargetConditions.ADdItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(ActionPointEffect);

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Domination');

	Cooldown = new class'GrimyLoot_DominationCooldown';
	Cooldown.iNumTurns = class'X2Ability_PsiOperativeAbilitySet'.default.DOMINATION_COOLDOWN;
	Cooldown.bDoNotApplyOnHit = true;
	AbilityTemplate.AbilityCooldown = Cooldown;
}

static event OnPostTemplatesCreated() {
	local X2ItemTemplateManager					ItemManager;
	local X2ItemTemplate						itemTemplate;
	local name									ItemName;
	

	local array<X2DataTemplate>		DifficultyTemplates;
	local X2DataTemplate			DifficultyTemplate;

	UpdatePsiAbilities();

	class'GrimyLoot_Research'.static.EnableAlienRulers();

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemManager.FindDataTemplateAllDifficulties('FragGrenade',DifficultyTemplates);
	foreach DifficultyTemplates(DifficultyTemplate) {
		ItemTemplate = X2ItemTemplate(DifficultyTemplate);
		if ( ItemTemplate != none ) {
			ItemTemplate.HideIfResearched = '';
		}
	}

	foreach class'GrimyLoot_Research'.default.PrimaryAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PrimaryAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PrimaryAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PrimaryAffixFour(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}

	ItemTemplate = ItemManager.FindItemTemplate('GrimyWildcat_Bsc');
	class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	ItemTemplate = ItemManager.FindItemTemplate('GrimyWildcat_Adv');
	class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	ItemTemplate = ItemManager.FindItemTemplate('GrimyWildcat_Sup');
	class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	
	foreach class'GrimyLoot_Research'.default.PistolAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PistolAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PistolAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}
	
	foreach class'GrimyLoot_Research'.default.SwordAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.SwordAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.SwordAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}
	
	foreach class'GrimyLoot_Research'.default.GremlinAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.GremlinAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.GremlinAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}

	foreach class'GrimyLoot_Research'.default.GrenadeLauncherAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.GrenadeLauncherAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.GrenadeLauncherAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}
	
	foreach class'GrimyLoot_Research'.default.PsiAmpAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PsiAmpAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.PsiAmpAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}
	
	foreach class'GrimyLoot_Research'.default.ArmorAffixOne(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.RARE_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.ArmorAffixTwo(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.EPIC_COLOR);
	}
	foreach class'GrimyLoot_Research'.default.ArmorAffixThree(ItemName) {
		ItemTemplate = ItemManager.FindItemTemplate(ItemName);
		class'GrimyLoot_ItemTemplateHelper'.static.AddFontColor(ItemTemplate,class'GrimyLoot_Research'.default.LEGENDARY_COLOR);
	}
}

static event OnLoadedSavedGame()
{
	if ( !IsResearchInHistory('Tech_IdentifyEpicLockboxInstant') )
	{
		UpdateResearch();
	}
}

static event InstallNewCampaign(XComGameState StartState)
{
	UpdateContinentBonuses(StartState);
}

static function bool IsResearchInHistory(name ResearchName)
{
	// Check if we've already injected the tech templates
	local XComGameState_Tech	TechState;
	
	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Tech', TechState)
	{
		if ( TechState.GetMyTemplateName() == ResearchName )
		{
			return true;
		}
	}
	return false;
}

static private function UpdateResearch()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local X2TechTemplate TechTemplate;
	local XComGameState_Tech TechState;
	local X2StrategyElementTemplateManager	StratMgr;
	
	//In this method, we demonstrate functionality that will add ExampleWeapon to the player's inventory when loading a saved
	//game. This allows players to enjoy the content of the mod in campaigns that were started without the mod installed.
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	History = `XCOMHISTORY;	

	//Create a pending game state change
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Research Templates");

	//Find tech template
	if ( !IsResearchInHistory('Tech_IdentifyRareLockbox') ) {
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyRareLockbox'));
		TechState = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech'));
		TechState.OnCreation(TechTemplate);
		NewGameState.AddStateObject(TechState);
	}
	
	if ( !IsResearchInHistory('Tech_IdentifyEpicLockbox') ) {
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyEpicLockbox'));
		TechState = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech'));
		TechState.OnCreation(TechTemplate);
		NewGameState.AddStateObject(TechState);
	}
	
	if ( !IsResearchInHistory('Tech_IdentifyLegendaryLockbox') ) {
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyLegendaryLockbox'));
		TechState = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech'));
		TechState.OnCreation(TechTemplate);
		NewGameState.AddStateObject(TechState);
	}
	
	if ( !IsResearchInHistory('Tech_IdentifyEpicLockboxInstant') ) {
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyEpicLockboxInstant'));
		TechState = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech'));
		TechState.OnCreation(TechTemplate);
		NewGameState.AddStateObject(TechState);
	}
	
	if ( !IsResearchInHistory('Tech_IdentifyLegendaryLockboxInstant') ) {
		TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyLegendaryLockboxInstant'));
		TechState = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech'));
		TechState.OnCreation(TechTemplate);
		NewGameState.AddStateObject(TechState);
	}

	//Commit the state change into the history.
	History.AddGameStateToHistory(NewGameState);
}

static private function UpdateContinentBonuses(XComGameState StartState)
{
	local array<name> OutputBonuses;
	local int idx;
	local XComGameState_Continent continent_state, UpdateContinent;

	OutputBonuses = default.CONTINENT_BONUSES;

	if ( OutputBonuses.length >= 6 )
	{
		while ( OutputBonuses.length > default.NUM_CONTINENTS )
		{
			OutputBonuses.RemoveItem(OutputBonuses[`SYNC_RAND_STATIC(OutputBonuses.length)]);
		}

		idx = 0;
		foreach StartState.IterateByClassType(class 'XComGameState_Continent', continent_state)
		{
			UpdateContinent = XComGameState_Continent(StartState.CreateStateObject(class'XComGameState_Continent', continent_state.ObjectID));
			UpdateContinent.ContinentBonus = OutputBonuses[idx++];
			StartState.AddStateObject(UpdateContinent);
		}
	}
}

exec function GrimyLootUpdateResearch() {
	UpdateResearch();
}

exec function GiveItemNickname(string SoldierName, string Nickname, optional string HexColor, optional int SlotNum = 2) {
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local XComGameState_Item ItemState;
	local int idx;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Turn Solier Into Class Cheat");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);

	for (idx = 0; idx < XComHQ.Crew.Length; idx++) {
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[idx].ObjectID));
				
		if (UnitState.GetFullName() == SoldierName ) {
			ItemState = UnitState.GetItemInSlot(EInventorySlot(SlotNum));

			ItemState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', ItemState.ObjectID));
			NewGameState.AddStateObject(ItemState);

			if ( HexColor == "" ) {
				ItemState.Nickname = NickName;
			}
			else {
				ItemState.Nickname = "<font color='#" $ HexColor $ "'><b>" $ Nickname $ "</b></font>";
			}
		}
	}

	if (NewGameState.GetNumGameStateObjects() > 0) {
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else {
		History.CleanupPendingGameState(NewGameState);
	}	
}