class Grimy_CutContent_PsionicDataTemplates extends X2Item config(CutContentPsionics);

var config int GRIMY_AMPBOOSTER_SUPPLYCOST;
var config int GRIMY_NEUROWHIP_SUPPLYCOST;
var config int GRIMY_AMPBOOSTER_SELLVALUE;
var config int GRIMY_NEUROWHIP_SELLVALUE;

var localized array<string> PCSBlackMarketTexts;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;
	
	Resources.AddItem(CreateAmpBooster());
	Resources.AddItem(CreateNeuroWhip());
	Resources.AddItem(CreateCommonPSIConditioning());
	Resources.AddItem(CreateRarePSIConditioning());
	Resources.AddItem(CreateEpicPSIConditioning());

	return Resources;
}

static function X2DataTemplate CreateAmpBooster()
{
	local X2EquipmentTemplate Template;
	local ArtifactCost Resources;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'AmpBooster');
	Template.ItemCat = 'psidefense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Amp_Booster";
	Template.EquipSound = "StrategyUI_Mindshield_Equip";

	Template.Abilities.AddItem('AmpBooster');

	Template.CanBeBuilt = true;
	Template.TradingPostValue = default.GRIMY_AMPBOOSTER_SELLVALUE;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'Grimy_CutContent_PsionicAbilityTemplates'.default.GRIMY_AMPBOOSTER_BONUS, true);

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsySectoid');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GRIMY_AMPBOOSTER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'CorpseSectoid';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);
	
	return Template;
}

static function X2DataTemplate CreateNeuroWhip()
{
	local X2EquipmentTemplate Template;
	local ArtifactCost Resources;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'GrimyNeuroWhip');
	Template.ItemCat = 'psidefense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_NeuroWhip";
	Template.EquipSound = "StrategyUI_Mindshield_Equip";

	Template.Abilities.AddItem('GrimyNeuroWhip');

	Template.CanBeBuilt = true;
	Template.TradingPostValue = default.GRIMY_NEUROWHIP_SELLVALUE;
	Template.PointsToComplete = 0;
	Template.Tier = 2;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'Grimy_CutContent_PsionicAbilityTemplates'.default.GRIMY_NEUROWHIP_BONUS, true);

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyGatekeeper');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GRIMY_NEUROWHIP_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'CorpseGatekeeper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);
	
	return Template;
}

static function X2DataTemplate CreateCommonPSIConditioning()
{
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'CommonPCSPsi');

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Psi";
	Template.ItemCat = 'combatsim';
	Template.TradingPostValue = 20;
	Template.bAlwaysUnique = false;
	Template.Tier = 0;

	Template.StatBoostPowerLevel = 1;
	Template.StatsToBoost.AddItem(eStat_PsiOffense);
	Template.bUseBoostIncrement = true;
	Template.InventorySlot = eInvSlot_CombatSim;

	Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return Template;
}

static function X2DataTemplate CreateRarePSIConditioning()
{
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'RarePCSPsi');

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Psi";
	Template.ItemCat = 'combatsim';
	Template.TradingPostValue = 40;
	Template.bAlwaysUnique = false;
	Template.Tier = 1;

	Template.StatBoostPowerLevel = 2;
	Template.StatsToBoost.AddItem(eStat_PsiOffense);
	Template.bUseBoostIncrement = true;
	Template.InventorySlot = eInvSlot_CombatSim;

	Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return Template;
}

static function X2DataTemplate CreateEpicPSIConditioning()
{
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'EpicPCSPsi');

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.AdventPCS';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_CombatSim_Psi";
	Template.ItemCat = 'combatsim';
	Template.TradingPostValue = 75;
	Template.bAlwaysUnique = false;
	Template.Tier = 2;

	Template.StatBoostPowerLevel = 3;
	Template.StatsToBoost.AddItem(eStat_PsiOffense);
	Template.bUseBoostIncrement = true;
	Template.InventorySlot = eInvSlot_CombatSim;

	Template.BlackMarketTexts = default.PCSBlackMarketTexts;

	return Template;
}
