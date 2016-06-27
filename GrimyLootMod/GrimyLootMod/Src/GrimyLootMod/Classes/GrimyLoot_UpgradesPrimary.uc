class GrimyLoot_UpgradesPrimary extends X2Item config(GrimyLootMod);

var config int BASIC_UPGRADE_VALUE, ADVANCED_UPGRADE_VALUE, SUPERIOR_UPGRADE_VALUE;
var config WeaponDamageValue MISS_DAMAGE_ONE, MISS_DAMAGE_TWO, MISS_DAMAGE_THREE, MISS_DAMAGE_FOUR;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	UpdateOldTemplates();

	Items.additem(CreateBasicGrimyDodgePierce());
	Items.additem(CreateAdvancedGrimyDodgePierce());
	Items.additem(CreateSuperiorGrimyDodgePierce());
	Items.additem(CreateBasicGrimyScanner());
	Items.additem(CreateAdvancedGrimyScanner());
	Items.additem(CreateSuperiorGrimyScanner());
	Items.additem(CreateBasicGrimyRedDot());
	Items.additem(CreateAdvancedGrimyRedDot());
	Items.additem(CreateSuperiorGrimyRedDot());
	Items.additem(CreateBasicGrimyVitalPoint());
	Items.additem(CreateAdvancedGrimyVitalPoint());
	Items.additem(CreateSuperiorGrimyVitalPoint());
	Items.additem(CreateBasicGrimyHeavyFrame());
	Items.additem(CreateAdvancedGrimyHeavyFrame());
	Items.additem(CreateSuperiorGrimyHeavyFrame());
	Items.additem(CreateBasicGrimyHangfire());
	Items.additem(CreateAdvancedGrimyHangfire());
	Items.additem(CreateSuperiorGrimyHangfire());
	Items.additem(CreateBasicGrimySuppressor());
	Items.additem(CreateAdvancedGrimySuppressor());
	Items.additem(CreateSuperiorGrimySuppressor());
	Items.additem(CreateBasicGrimyHeatSink());
	Items.additem(CreateAdvancedGrimyHeatSink());
	Items.additem(CreateSuperiorGrimyHeatSink());
	Items.additem(CreateBasicGrimyLightFrame());
	Items.additem(CreateAdvancedGrimyLightFrame());
	Items.additem(CreateSuperiorGrimyLightFrame());
	Items.additem(CreateBasicGrimyStabilizer());
	Items.additem(CreateAdvancedGrimyStabilizer());
	Items.additem(CreateSuperiorGrimyStabilizer());
	Items.additem(CreateBasicGrimyProgressive());
	Items.additem(CreateAdvancedGrimyProgressive());
	Items.additem(CreateSuperiorGrimyProgressive());
	Items.additem(CreateBasicGrimyHighCycle());
	Items.additem(CreateAdvancedGrimyHighCycle());
	Items.additem(CreateSuperiorGrimyHighCycle());
	Items.additem(CreateBasicGrimyHighCaliber());
	Items.additem(CreateAdvancedGrimyHighCaliber());
	Items.additem(CreateSuperiorGrimyHighCaliber());
	Items.additem(CreateBasicGrimyProcessor());
	Items.additem(CreateAdvancedGrimyProcessor());
	Items.additem(CreateSuperiorGrimyProcessor());
	Items.additem(CreateBasicGrimyWildcat());
	Items.additem(CreateAdvancedGrimyWildcat());
	Items.additem(CreateSuperiorGrimyWildcat());
	
	Items.additem(CreateBasicGrimyFrontload());
	Items.additem(CreateAdvancedGrimyFrontload());
	Items.additem(CreateSuperiorGrimyFrontload());
	Items.additem(CreateBasicGrimyReserve());
	Items.additem(CreateAdvancedGrimyReserve());
	Items.additem(CreateSuperiorGrimyReserve());
	
	Items.additem(CreateBasicGrimyAmmoSynthesizer());
	Items.additem(CreateAdvancedGrimyAmmoSynthesizer());
	Items.additem(CreateSuperiorGrimyAmmoSynthesizer());
	Items.additem(CreateBasicGrimyAddDragonRounds());
	Items.additem(CreateAdvancedGrimyAddDragonRounds());
	Items.additem(CreateSuperiorGrimyAddDragonRounds());
	Items.additem(CreateBasicGrimyAddVenomRounds());
	Items.additem(CreateAdvancedGrimyAddVenomRounds());
	Items.additem(CreateSuperiorGrimyAddVenomRounds());
	Items.additem(CreateBasicGrimyAddBluescreenRounds());
	Items.additem(CreateAdvancedGrimyAddBluescreenRounds());
	Items.additem(CreateSuperiorGrimyAddBluescreenRounds());
	Items.additem(CreateBasicGrimySentinelScope());
	Items.additem(CreateAdvancedGrimySentinelScope());
	Items.additem(CreateSuperiorGrimySentinelScope());
	Items.additem(CreateBasicGrimyUndertaker());
	Items.additem(CreateAdvancedGrimyUndertaker());
	Items.additem(CreateSuperiorGrimyUndertaker());
	Items.additem(CreateBasicGrimySeigebreakerScope());
	Items.additem(CreateAdvancedGrimySeigebreakerScope());
	Items.additem(CreateSuperiorGrimySeigebreakerScope());
	
	Items.additem(CreateBasicGrimySquadVideo());
	Items.additem(CreateAdvancedGrimySquadVideo());
	Items.additem(CreateSuperiorGrimySquadVideo());
	Items.additem(CreateBasicGrimyDoubleTap());
	Items.additem(CreateAdvancedGrimyDoubleTap());
	Items.additem(CreateSuperiorGrimyDoubleTap());
	Items.additem(CreateBasicGrimyBeltFeed());
	Items.additem(CreateAdvancedGrimyBeltFeed());
	Items.additem(CreateSuperiorGrimyBeltFeed());
	Items.additem(CreateBasicGrimyAntiMaterial());
	Items.additem(CreateAdvancedGrimyAntiMaterial());
	Items.additem(CreateSuperiorGrimyAntiMaterial());
	Items.additem(CreateBasicGrimyCustomStock());
	Items.additem(CreateAdvancedGrimyCustomStock());
	Items.additem(CreateSuperiorGrimyCustomStock());
	Items.additem(CreateBasicGrimyTwitchTrigger());
	Items.additem(CreateAdvancedGrimyTwitchTrigger());
	Items.additem(CreateSuperiorGrimyTwitchTrigger());
	Items.additem(CreateBasicGrimyMaxCaliber());
	Items.additem(CreateAdvancedGrimyMaxCaliber());
	Items.additem(CreateSuperiorGrimyMaxCaliber());
	
	return Items;
}

// #######################################################################################
// -------------------- GENERIC SETUP FUNCTIONS ------------------------------------------
// #######################################################################################

static function SetUpWeaponUpgradePrimary(out X2WeaponUpgradeTemplate Template, bool bSidearmOnly)
{
	if ( bSidearmOnly )
	{
		Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPistol;
	}
	else
	{
		Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponPrimary;
	}

	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
}

static function int GetBasicPrice() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.BASIC_UPGRADE_VALUE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.BASIC_UPGRADE_VALUE;
	}
	else {
		return default.BASIC_UPGRADE_VALUE;
	}
}

static function int GetAdvancedPrice() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.ADVANCED_UPGRADE_VALUE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.ADVANCED_UPGRADE_VALUE;
	}
	else {
		return default.ADVANCED_UPGRADE_VALUE;
	}
}

static function int GetSuperiorPrice() {
	if ( class'GrimyLoot_ScreenListener_MCM'.default.SUPERIOR_UPGRADE_VALUE > 0 ) {
		return class'GrimyLoot_ScreenListener_MCM'.default.SUPERIOR_UPGRADE_VALUE;
	}
	else {
		return default.SUPERIOR_UPGRADE_VALUE;
	}
}

static function SetUpTier1Upgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentA';
	Template.TradingPostValue = GetBasicPrice();
	Template.Tier = 0;
}

static function SetUpTier2Upgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentB';
	Template.TradingPostValue = GetAdvancedPrice();
	Template.Tier = 1;
}

static function SetUpTier3Upgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentA';
	Template.TradingPostValue = GetSuperiorPrice();
	Template.Tier = 2;
}

// #######################################################################################
// -------------------- TEMPLATE FUNCTIONS -----------------------------------------------
// #######################################################################################

static function X2DataTemplate CreateBasicGrimyDodgePierce()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDodgePierce_Bsc');
	SetUpScopeGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDodgePierce_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyDodgePierce()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDodgePierce_Adv');
	SetUpScopeGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDodgePierce_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyDodgePierce()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDodgePierce_Sup');
	SetUpScopeGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDodgePierce_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDodgePierce_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyScanner()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyScanner_Bsc');
	SetUpScopeGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyScanner_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyScanner()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyScanner_Adv');
	SetUpScopeGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyScanner_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyScanner()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyScanner_Sup');
	SetUpScopeGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyScanner_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyScanner_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyRedDot()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRedDot_Bsc');
	SetUpLaserGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;
	Template.BonusAbilities.AddItem('GrimyRedDot_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyRedDot()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRedDot_Adv');
	SetUpLaserGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;
	Template.BonusAbilities.AddItem('GrimyRedDot_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyRedDot()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRedDot_Sup');
	SetUpLaserGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;
	Template.BonusAbilities.AddItem('GrimyRedDot_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRedDot_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyVitalPoint()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyVitalPoint_Bsc');
	SetUpLaserGraphics(Template);
	SetUpTier1Upgrade(Template);
	//Template.BonusAbilities.AddItem('GrimyVitalPoint_Bsc');
	Template.BonusAbilities.AddItem('Deadeye');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyVitalPoint()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyVitalPoint_Adv');
	SetUpLaserGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyVitalPoint_Adv');
	Template.BonusAbilities.AddItem('Deadeye');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyVitalPoint()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyVitalPoint_Sup');
	SetUpLaserGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyVitalPoint_Sup');
	Template.BonusAbilities.AddItem('Deadeye');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyVitalPoint_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyHeavyFrame()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHeavyFrame_Bsc');
	SetUpReloadGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent20');
	Template.BonusAbilities.AddItem('GrimyDecreaseMobility_Two');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyHeavyFrame()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHeavyFrame_Adv');
	SetUpReloadGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent25');
	Template.BonusAbilities.AddItem('GrimyDecreaseMobility_Two');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyHeavyFrame()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHeavyFrame_Sup');
	SetUpReloadGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent30');
	Template.BonusAbilities.AddItem('GrimyDecreaseMobility_Two');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeavyFrame_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyHangfire()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHangfire_Bsc');
	SetUpReloadGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHangfire_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyHangfire()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHangfire_Adv');
	SetUpReloadGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHangfire_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyHangfire()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHangfire_Sup');
	SetUpReloadGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHangfire_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHangfire_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimySuppressor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySuppressor_Bsc');
	SetUpSuppressorGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySuppressor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimySuppressor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySuppressor_Adv');
	SetUpSuppressorGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySuppressor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimySuppressor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySuppressor_Sup');
	SetUpSuppressorGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySuppressor_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySuppressor_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyHeatSink()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHeatSink_Bsc');
	SetUpSuppressorGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('Suppression');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyHeatSink()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHeatSink_Adv');
	SetUpSuppressorGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('Suppression');
	Template.BonusAbilities.AddItem('Demolition');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyHeatSink()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHeatSink_Sup');
	SetUpSuppressorGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('Suppression');
	Template.BonusAbilities.AddItem('Demolition');
	Template.BonusAbilities.AddItem('GrimyKillZoneOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHeatSink_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyLightFrame()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyLightFrame_Bsc');
	SetUpStockGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMobility_One');
	Template.BonusAbilities.AddItem('GrimyDecreaseDamagePercent15');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyLightFrame()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyLightFrame_Adv');
	SetUpStockGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMobility_Two');
	Template.BonusAbilities.AddItem('GrimyDecreaseDamagePercent20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyLightFrame()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyLightFrame_Sup');
	SetUpStockGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMobility_Three');
	Template.BonusAbilities.AddItem('GrimyDecreaseDamagePercent25');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLightFrame_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyStabilizer()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStabilizer_Bsc');
	SetUpStockGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyRunAndGunOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyStabilizer()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStabilizer_Adv');
	SetUpStockGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyRunAndGunTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyStabilizer()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStabilizer_Sup');
	SetUpStockGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyRunAndGunThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStabilizer_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyProgressive()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyProgressive_Bsc');
	SetUpTriggerGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyRapidFireOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyProgressive()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyProgressive_Adv');
	SetUpTriggerGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyRapidFireTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyProgressive()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyProgressive_Sup');
	SetUpTriggerGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyRapidFireThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProgressive_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyHighCycle()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHighCycle_Bsc');
	SetUpTriggerGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHighCycle_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyHighCycle()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHighCycle_Adv');
	SetUpTriggerGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHighCycle_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyHighCycle()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHighCycle_Sup');
	SetUpTriggerGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHighCycle_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCycle_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyHighCaliber()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHighCaliber_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent30');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	Template.ClipSizeBonus = -2;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyHighCaliber()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHighCaliber_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent35');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	Template.ClipSizeBonus = -2;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyHighCaliber()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHighCaliber_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent40');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	Template.ClipSizeBonus = -2;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function int GetGrimyClipBonus(X2WeaponUpgradeTemplate UpgradeTemplate)
{
	return UpgradeTemplate.ClipSizeBonus;
}

static function X2DataTemplate CreateBasicGrimyProcessor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyProcessor_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusHacking_One');
	Template.BonusAbilities.AddItem('GrimyBonusPsiOffense_One');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyProcessor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyProcessor_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusHacking_Two');
	Template.BonusAbilities.AddItem('GrimyBonusPsiOffense_Two');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyProcessor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyProcessor_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusHacking_Three');
	Template.BonusAbilities.AddItem('GrimyBonusPsiOffense_Three');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyProcessor_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyWildcat()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyWildcat_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyWildcat_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyWildcat()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyWildcat_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyWildcat_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyWildcat()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyWildcat_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyWildcat_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyWildcat_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyFrontload()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyFrontload_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyFrontload_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyFrontload()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyFrontload_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyFrontload_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyFrontload()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyFrontload_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyFrontload_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFrontload_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyReserve()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReserve_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReserve_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyReserve()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReserve_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReserve_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyReserve()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReserve_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReserve_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserve_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyAmmoSynthesizer()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAmmoSynthesizer_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAmmoSynthesizerBsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyAmmoSynthesizer()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAmmoSynthesizer_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAmmoSynthesizerAdv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyAmmoSynthesizer()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAmmoSynthesizer_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAmmoSynthesizerSup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAmmoSynthesizer_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyAddDragonRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddDragonRounds_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddDragonRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	Template.ClipSizeBonus = -1;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyAddDragonRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddDragonRounds_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddDragonRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyAddDragonRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddDragonRounds_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddDragonRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	Template.ClipSizeBonus = 1;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateBasicGrimyAddVenomRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddVenomRounds_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddVenomRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	Template.ClipSizeBonus = -1;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyAddVenomRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddVenomRounds_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddVenomRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyAddVenomRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddVenomRounds_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddVenomRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	Template.ClipSizeBonus = 1;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateBasicGrimyAddBluescreenRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddBluescreenRounds_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddBluescreenRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	Template.ClipSizeBonus = -1;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyAddBluescreenRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddBluescreenRounds_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddBluescreenRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyAddBluescreenRounds()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAddBluescreenRounds_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAddBluescreenRounds');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Sup');
	Template.AdjustClipSizeFn = GrimyAdjustClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	Template.ClipSizeBonus = 1;
	Template.GetBonusAmountFn = GetGrimyClipBonus;
	return Template;
}

static function X2DataTemplate CreateBasicGrimySentinelScope()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySentinelScope_Bsc');
	SetUpScopeGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySentinelOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimySentinelScope()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySentinelScope_Adv');
	SetUpScopeGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySentinelTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimySentinelScope()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySentinelScope_Sup');
	SetUpScopeGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySentinelThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySentinelScope_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyUndertaker()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyUndertaker_Bsc');
	SetUpScopeGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyUndertaker3');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyUndertaker()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyUndertaker_Adv');
	SetUpScopeGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyUndertaker4');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyUndertaker()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyUndertaker_Sup');
	SetUpScopeGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyUndertaker5');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndertaker_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyDuelist()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDuelist_Bsc');
	SetUpStockGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDuelist25');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyDuelist()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDuelist_Adv');
	SetUpStockGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDuelist30');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyDuelist()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDuelist_Sup');
	SetUpStockGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDuelist35');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDuelist_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimySeigebreakerScope()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySeigebreakerScope_Bsc');
	SetUpScopeGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySeigebreakerOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimySeigebreakerScope()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySeigebreakerScope_Adv');
	SetUpScopeGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySeigebreakerTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimySeigebreakerScope()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySeigebreakerScope_Sup');
	SetUpScopeGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySeigebreakerThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySeigebreakerScope_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimySquadVideo()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySquadVideo_Bsc');
	SetUpScopeGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('Squadsight');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimySquadVideo()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySquadVideo_Adv');
	SetUpScopeGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('Squadsight');
	Template.BonusAbilities.AddItem('LongWatch');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimySquadVideo()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySquadVideo_Sup');
	SetUpScopeGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('Squadsight');
	Template.BonusAbilities.AddItem('LongWatch');
	Template.BonusAbilities.AddItem('EverVigilant');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySquadVideo_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticC_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyDoubleTap()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDoubleTap_Bsc');
	SetUpLaserGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('ChainShot');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyDoubleTap()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDoubleTap_Adv');
	SetUpLaserGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('ChainShot');
	Template.BonusAbilities.AddItem('GrimyHailOfBulletsOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyDoubleTap()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDoubleTap_Sup');
	SetUpLaserGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('ChainShot');
	Template.BonusAbilities.AddItem('GrimyHailOfBulletsTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDoubleTap_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyBeltFeed()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyBeltFeed_Bsc');
	SetUpReloadGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySaturationFireOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyBeltFeed()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyBeltFeed_Adv');
	SetUpReloadGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySaturationFireTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyBeltFeed()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyBeltFeed_Sup');
	SetUpReloadGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySaturationFireThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBeltFeed_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyAntiMaterial()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAntiMaterial_Bsc');
	SetUpSuppressorGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusArmorPiercing_Bsc');
	Template.BonusAbilities.AddItem('GrimyBonusShred_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyAntiMaterial()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAntiMaterial_Adv');
	SetUpSuppressorGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusArmorPiercing_Adv');
	Template.BonusAbilities.AddItem('GrimyBonusShred_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyAntiMaterial()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAntiMaterial_Sup');
	SetUpSuppressorGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusArmorPiercing_Sup');
	Template.BonusAbilities.AddItem('GrimyBonusShred_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAntiMaterial_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyCustomStock()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyCustomStock_Bsc');
	SetUpStockGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.GetBonusAmountFn = class'X2Item_DefaultUpgrades'.static.GetDamageBonusAmount;
	Template.BonusDamage = default.MISS_DAMAGE_TWO;
	Template.BonusAbilities.AddItem('GrimyBonusDamage_Two');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyCustomStock()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyCustomStock_Adv');
	SetUpStockGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.GetBonusAmountFn = class'X2Item_DefaultUpgrades'.static.GetDamageBonusAmount;
	Template.BonusDamage = default.MISS_DAMAGE_THREE;
	Template.BonusAbilities.AddItem('GrimyBonusDamage_Three');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyCustomStock()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyCustomStock_Sup');
	SetUpStockGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.GetBonusAmountFn = class'X2Item_DefaultUpgrades'.static.GetDamageBonusAmount;
	Template.BonusDamage = default.MISS_DAMAGE_FOUR;
	Template.BonusAbilities.AddItem('GrimyBonusDamage_Four');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyCustomStock_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyTwitchTrigger()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyTwitchTrigger_Bsc');
	SetUpTriggerGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySerialOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyTwitchTrigger()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyTwitchTrigger_Adv');
	SetUpTriggerGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySerialTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyTwitchTrigger()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyTwitchTrigger_Sup');
	SetUpTriggerGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimySerialThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTwitchTrigger_Sup');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv";
	return Template;
}

static function X2DataTemplate CreateBasicGrimyMaxCaliber()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMaxCaliber_Bsc');
	SetUpMagazineGraphics(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent100');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Bsc');
	Template.AdjustClipSizeFn = GrimyMaxCaliberClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyMaxCaliber()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMaxCaliber_Adv');
	SetUpMagazineGraphics(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent100');
	Template.BonusAbilities.AddItem('GrimyAntiMaterial_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Bsc');
	Template.AdjustClipSizeFn = GrimyMaxCaliberClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv";
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyMaxCaliber()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMaxCaliber_Sup');
	SetUpMagazineGraphics(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusDamagePercent100');
	Template.BonusAbilities.AddItem('GrimyAntiMaterial_Sup');
	Template.BonusAbilities.AddItem('GrimyMaxCaliber_Crit');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMaxCaliber_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHighCaliber_Sup');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddDragonRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddVenomRounds_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAddBluescreenRounds_Bsc');
	Template.AdjustClipSizeFn = GrimyMaxCaliberClipSize;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv";
	return Template;
}

static function bool GrimyMaxCaliberClipSize(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, const int CurrentClipSize, out int AdjustedClipSize)
{
	AdjustedClipSize = 1;
	return true;
}

static function bool GrimyAdjustClipSize(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, const int CurrentClipSize, out int AdjustedClipSize)
{
	AdjustedClipSize = CurrentClipSize+UpgradeTemplate.ClipSizeBonus;
	return true;
}

// #######################################################################################
// -------------------- GRAPHICAL FUNCTIONS ----------------------------------------------
// #######################################################################################
static function SetUpAlienHuntersGraphics(X2WeaponUpgradeTemplate Template) {
	if ( class'GrimyLoot_Research'.default.bEnableAlienRulers ) {
		Template.AddUpgradeAttachment('', '', "", "", 'AlienHunterRifle_CV', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		Template.AddUpgradeAttachment('', '', "", "", 'AlienHunterRifle_MG', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		Template.AddUpgradeAttachment('', '', "", "", 'AlienHunterRifle_BM', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
}

static function SetUpLaserGraphics(out X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);

	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_OpticA", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticA_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "ConvShotgun.Meshes.SM_ConvShotgun_OpticB", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "MagShotgun.Meshes.SM_MagShotgun_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "BeamShotgun.Meshes.SM_BeamShotgun_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_OpticA", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_OpticA_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// Sniper Rifle
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "ConvSniper.Meshes.SM_ConvSniper_OpticB", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "MagSniper.Meshes.SM_MagSniper_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "ConvCannon.Meshes.SM_ConvCannon_OpticB", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "MagCannon.Meshes.SM_MagCannon_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "BeamCannon.Meshes.SM_BeamCannon_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_OpticA", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_OpticA_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{	
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_OpticA", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticA_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// SMG
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_CV.Meshes.SK_LWConvSMG_OpticB", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_MG.Meshes.SK_LWMagSMG_OpticB", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_BM.Meshes.SK_LWBeamSMG_OpticB", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticA_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	
	SetUpAlienHuntersGraphics(Template);
}

static function SetUpScopeGraphics(out X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);
	
	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	
	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "ConvShotgun.Meshes.SM_ConvShotgun_OpticC", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "MagShotgun.Meshes.SM_MagShotgun_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "BeamShotgun.Meshes.SM_BeamShotgun_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	
	// Sniper Rifle
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "ConvSniper.Meshes.SM_ConvSniper_OpticC", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "MagSniper.Meshes.SM_MagSniper_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "ConvCannon.Meshes.SM_ConvCannon_OpticC", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_OpticsC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_OpticsC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "MagCannon.Meshes.SM_MagCannon_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "BeamCannon.Meshes.SM_BeamCannon_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}

	// SMG
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_CV.Meshes.SK_LWConvSMG_OpticC", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_MG.Meshes.SK_LWMagSMG_OpticC", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_BM.Meshes.SK_LWBeamSMG_OpticC", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	
	SetUpAlienHuntersGraphics(Template);
}

static function SetUpMagazineGraphics(X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);
		
	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}
	
	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "ConvShotgun.Meshes.SM_ConvShotgun_MagB", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
		Template.AddUpgradeAttachment('Foregrip', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "ConvShotgun.Meshes.SM_ConvShotgun_ForegripB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "MagShotgun.Meshes.SM_MagShotgun_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
		Template.AddUpgradeAttachment('Foregrip', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "MagShotgun.Meshes.SM_MagShotgun_ForegripB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "BeamShotgun.Meshes.SM_BeamShotgun_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	
	// Sniper Rifle
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "ConvSniper.Meshes.SM_ConvSniper_MagB", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "MagSniper.Meshes.SM_MagSniper_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "BeamSniper.Meshes.SM_BeamSniper_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}
	
	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "ConvCannon.Meshes.SM_ConvCannon_MagB", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "MagCannon.Meshes.SM_MagCannon_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "BeamCannon.Meshes.SM_BeamCannon_MagB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}

	// Pistol	
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagB", "", 'Pistol_CV', , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagB", "", 'Pistol_MG', , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagB", "", 'Pistol_BM', , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}

	// SMG
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_CV.Meshes.SK_LWConvSMG_MagB", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_MagB", "img:///UILibrary_SMG.conventional.LWConvSMG_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagB", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagB", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}
	
	SetUpAlienHuntersGraphics(Template);
}

static function SetUpTriggerGraphics(out X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);

	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAttachments.Meshes.SM_ConvReargripB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_ReargripB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "ConvAttachments.Meshes.SM_ConvTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAttachments.Meshes.SM_MagReargripB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "MagAttachments.Meshes.SM_MagTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Core', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_CoreB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Core_Teeth', '', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_TeethA", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_Teeth", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}

	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "ConvAttachments.Meshes.SM_ConvReargripB", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "ConvAttachments.Meshes.SM_ConvTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "MagAttachments.Meshes.SM_MagReargripB", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "MagAttachments.Meshes.SM_MagTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Core_Left', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "BeamShotgun.Meshes.SM_BeamShotgun_CoreB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Core_Right', '', "BeamShotgun.Meshes.SM_BeamShotgun_CoreB", "", WeaponName);
		Template.AddUpgradeAttachment('Core_Teeth', '', "BeamShotgun.Meshes.SM_BeamShotgun_TeethA", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_Teeth", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}

	// Sniper
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "ConvAttachments.Meshes.SM_ConvReargripB", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "ConvAttachments.Meshes.SM_ConvTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "MagSniper.Meshes.SM_MagSniper_ReargripB", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "MagAttachments.Meshes.SM_MagTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Core', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "BeamSniper.Meshes.SM_BeamSniper_CoreB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Core_Teeth', '', "BeamSniper.Meshes.SM_BeamSniper_TeethA", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_Teeth", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}

	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Cannon_Stock', "ConvCannon.Meshes.SM_ConvCannon_ReargripB", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "ConvCannon.Meshes.SM_ConvCannon_TriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Cannon_Stock', "MagCannon.Meshes.SM_MagCannon_ReargripB", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "MagCannon.Meshes.SM_MagCannon_TriggerB", "", WeaponName, ,"","");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Core', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "BeamCannon.Meshes.SM_BeamCannon_CoreB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Core_Center', '', "BeamCannon.Meshes.SM_BeamCannon_CoreB_Center", "", WeaponName);
		Template.AddUpgradeAttachment('Core_Teeth', '', "BeamCannon.Meshes.SM_BeamCannon_TeethA", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_Teeth", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAttachments.Meshes.SM_ConvReargripB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_ReargripB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAttachments.Meshes.SM_MagReargripB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName) {
		Template.AddUpgradeAttachment('Core', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_CoreB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Core_Teeth', '', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_TeethA", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_Teeth", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}

	// SMG
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Trigger', '', "ConvAttachments.Meshes.SM_ConvTriggerB", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_TriggerA", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger"); // use conventional trigger attachment
	}
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAttachments.Meshes.SM_MagReargripB", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Trigger', '', "MagAttachments.Meshes.SM_MagTriggerB", "", WeaponName);
	}
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Core', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_BM.Meshes.SK_LWBeamSMG_CoreA", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
		Template.AddUpgradeAttachment('Core_Teeth', '', "LWSMG_BM.Meshes.SK_LWBeamSMG_TeethA", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_TeethA", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
	
	SetUpAlienHuntersGraphics(Template);
} 
static function SetUpReloadGraphics(out X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);
	
	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagC", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagD", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagD", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName) {
		Template.AddUpgradeAttachment('AutoLoader', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_AutoLoader", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_AutoLoader_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}

	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "ConvShotgun.Meshes.SM_ConvShotgun_MagC", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "ConvShotgun.Meshes.SM_ConvShotgun_MagD", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "MagShotgun.Meshes.SM_MagShotgun_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "MagShotgun.Meshes.SM_MagShotgun_MagD", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "BeamShotgun.Meshes.SM_BeamShotgun_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_AutoLoader_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "BeamShotgun.Meshes.SM_BeamShotgun_MagD", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}

	// Sniper Rifle
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "ConvSniper.Meshes.SM_ConvSniper_MagC", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "ConvSniper.Meshes.SM_ConvSniper_MagD", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "MagSniper.Meshes.SM_MagSniper_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "MagSniper.Meshes.SM_MagSniper_MagD", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName) {
		Template.AddUpgradeAttachment('AutoLoader', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "BeamSniper.Meshes.SM_BeamSniper_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_AutoLoader", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_AutoLoader_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}

	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "ConvCannon.Meshes.SM_ConvCannon_MagC", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "ConvCannon.Meshes.SM_ConvCannon_MagD", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "MagCannon.Meshes.SM_MagCannon_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "MagCannon.Meshes.SM_MagCannon_MagD", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('AutoLoader', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "BeamCannon.Meshes.SM_BeamCannon_MagC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_AutoLoader", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_AutoLoader_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}

	// SMG
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_CV.Meshes.SK_LWConvSMG_MagC", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_MagC", "img:///UILibrary_SMG.conventional.LWConvSMG_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_CV.Meshes.SK_LWConvSMG_MagD", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_MagD", "img:///UILibrary_SMG.conventional.LWConvSMG_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagC", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagD", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagD_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('AutoLoader', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagC", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_AutoLoader_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}
	
	SetUpAlienHuntersGraphics(Template);
}

static function SetUpStockGraphics(out X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);

	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "ConvAttachments.Meshes.SM_ConvCrossbar", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_CrossbarA", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "MagAttachments.Meshes.SM_MagCrossbar", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_Crossbar", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName) {
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_HeatsinkB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}

	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "ConvShotgun.Meshes.SM_ConvShotgun_StockB", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "ConvAttachments.Meshes.SM_ConvCrossbar", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_CrossbarA", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "MagShotgun.Meshes.SM_MagShotgun_StockB", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "MagAttachments.Meshes.SM_MagCrossbar", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_Crossbar", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName) {
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "BeamShotgun.Meshes.SM_BeamShotgun_HeatsinkB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}

	// Sniper Rifle
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Sniper_Stock', "ConvSniper.Meshes.SM_ConvSniper_StockB", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "ConvAttachments.Meshes.SM_ConvCrossbar", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_CrossbarA", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Sniper_Stock', "MagSniper.Meshes.SM_MagSniper_StockB", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "MagAttachments.Meshes.SM_MagCrossbar", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_Crossbar", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName) {
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_Sniper_Stock', "BeamSniper.Meshes.SM_BeamSniper_HeatsinkB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}

	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Cannon_Stock', "ConvCannon.Meshes.SM_ConvCannon_StockB", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('StockSupport', '', "ConvCannon.Meshes.SM_ConvCannon_StockB_Support", "", WeaponName);
	}	
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Foregrip', 'UIPawnLocation_WeaponUpgrade_Cannon_Stock', "MagCannon.Meshes.SM_MagCannon_StockB", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('StockSupport', '', "MagCannon.Meshes.SM_MagCannon_StockB_Support", "", WeaponName);
	}	
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_Cannon_Stock', "BeamCannon.Meshes.SM_BeamCannon_HeatsinkB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName) {
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_HeatsinkB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}

	// SMG
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('StockB', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_StockB_alt", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}	
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
		Template.AddUpgradeAttachment('Crossbar', '', "MagAttachments.Meshes.SM_MagCrossbar", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_Crossbar", , , class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent);
	}	
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "LWSMG_BM.Meshes.SK_LWBeamSMG_HeatsinkB", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}
	
	SetUpAlienHuntersGraphics(Template);
} 

static function SetUpSuppressorGraphics(out X2WeaponUpgradeTemplate Template, optional bool bPistol = false)
{
	local name WeaponName;
	SetUpWeaponUpgradePrimary(Template, bPistol);
	
	// Assault Rifle
	foreach class'GrimyLoot_Research'.default.AR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.AR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.AR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}

	// Shotgun
	foreach class'GrimyLoot_Research'.default.SG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Shotgun_Suppressor', "ConvShotgun.Meshes.SM_ConvShotgun_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvShotgun_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.SG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Shotgun_Suppressor', "MagShotgun.Meshes.SM_MagShotgun_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.SG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Shotgun_Suppressor', "BeamShotgun.Meshes.SM_BeamShotgun_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamShotgun_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}

	// Sniper Rifle
	foreach class'GrimyLoot_Research'.default.SR_T1(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "ConvSniper.Meshes.SM_ConvSniper_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.ConvSniper.ConvSniper_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.SR_T2(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "MagSniper.Meshes.SM_MagSniper_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_MagSniper.MagSniper_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.SR_T3(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "BeamSniper.Meshes.SM_BeamSniper_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}

	// Cannon
	foreach class'GrimyLoot_Research'.default.LMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "ConvCannon.Meshes.SM_ConvCannon_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.ConvCannon.ConvCannon_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "MagCannon.Meshes.SM_MagCannon_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_MagCannon.MagCannon_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.LMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "BeamCannon.Meshes.SM_BeamCannon_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}

	// SMGs
	foreach class'GrimyLoot_Research'.default.SMG_T1(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "LWSMG_CV.Meshes.SK_LWConvSMG_SuppressorB", "", WeaponName, , "img:///UILibrary_SMG.conventional.LWConvSMG_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.SMG_T2(WeaponName) {
		Template.AddUpgradeAttachment('SuppressorB', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "MagShotgun.Meshes.SM_MagShotgun_SuppressorB", "", WeaponName, , "img:///UILibrary_SMG.magnetic.LWMagSMG_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagShotgun_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.SMG_T3(WeaponName) {
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "LWSMG_BM.Meshes.SK_LWBeamSMG_SuppressorA", "", WeaponName, , "img:///UILibrary_SMG.Beam.LWBeamSMG_SuppressorA", "img:///UILibrary_SMG.Beam.Inv_LWBeamSMG_SuppressorA", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");  
	}
	
	SetUpAlienHuntersGraphics(Template);
} 

// #######################################################################################
// -------------------- UPGRADE FUNCTIONS ------------------------------------------------
// #######################################################################################

static function bool IsPrimary(XComGameState_Item SourceWeapon)
{
	return SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon;
}

static function bool CanApplyUpgradeToWeaponPrimary(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, int SlotIndex)
{
	local array<X2WeaponUpgradeTemplate> AttachedUpgradeTemplates;
	local X2WeaponUpgradeTemplate AttachedUpgrade; 
	local int iSlot;
		
	AttachedUpgradeTemplates = Weapon.GetMyWeaponUpgradeTemplates();

	if ( Weapon.GetWeaponCategory() == 'grenade_launcher' ) { return false; }
	if ( !IsPrimary(Weapon) ) { return false; }

	foreach AttachedUpgradeTemplates(AttachedUpgrade, iSlot)
	{
		// Slot Index indicates the upgrade slot the player intends to replace with this new upgrade
		if (iSlot == SlotIndex)
		{
			// The exact upgrade already equipped in a slot cannot be equipped again
			// This allows different versions of the same upgrade type to be swapped into the slot
			if (AttachedUpgrade == UpgradeTemplate)
			{
				return false;
			}
		}
		else if (UpgradeTemplate.MutuallyExclusiveUpgrades.Find(AttachedUpgrade.Name) != INDEX_NONE)
		{
			// If the new upgrade is mutually exclusive with any of the other currently equipped upgrades, it is not allowed
			return false;
		}
	}

	return true;
}

static function bool CanApplyUpgradeToWeaponArmor(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, int SlotIndex)
{
	local array<X2WeaponUpgradeTemplate> AttachedUpgradeTemplates;
	local X2WeaponUpgradeTemplate AttachedUpgrade; 
	local int iSlot;
		
	AttachedUpgradeTemplates = Weapon.GetMyWeaponUpgradeTemplates();

	if ( Weapon.InventorySlot != eInvSlot_Armor )
	{
		return false;
	}

	foreach AttachedUpgradeTemplates(AttachedUpgrade, iSlot)
	{
		// Slot Index indicates the upgrade slot the player intends to replace with this new upgrade
		if (iSlot == SlotIndex)
		{
			// The exact upgrade already equipped in a slot cannot be equipped again
			// This allows different versions of the same upgrade type to be swapped into the slot
			if (AttachedUpgrade == UpgradeTemplate)
			{
				return false;
			}
		}
		else if (UpgradeTemplate.MutuallyExclusiveUpgrades.Find(AttachedUpgrade.Name) != INDEX_NONE)
		{
			// If the new upgrade is mutually exclusive with any of the other currently equipped upgrades, it is not allowed
			return false;
		}
	}

	return true;
}

// #######################################################################################
// ------------------------ OLD TEMPLATE ADJUSTER ----------------------------------------
// #######################################################################################

static function UpdateOldTemplates()
{
	local X2ItemTemplateManager ItemManager;
	local X2WeaponUpgradeTemplate ItemTemplate;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('CritUpgrade_Bsc'));
	SetUpCritUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('CritUpgrade_Adv'));
	SetUpCritUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('CritUpgrade_Sup'));
	SetUpCritUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);

	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('AimUpgrade_Bsc'));
	SetUpAimBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('AimUpgrade_Adv'));
	SetUpAimBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('AimUpgrade_Sup'));
	SetUpAimBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('ClipSizeUpgrade_Bsc'));
	SetUpClipSizeBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('ClipSizeUpgrade_Adv'));
	SetUpClipSizeBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('ClipSizeUpgrade_Sup'));
	SetUpClipSizeBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('FreeFireUpgrade_Bsc'));
	SetUpFreeFireBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('FreeFireUpgrade_Adv'));
	SetUpFreeFireBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('FreeFireUpgrade_Sup'));
	SetUpFreeFireBonusUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('MissDamageUpgrade_Bsc'));
	SetUpMissDamageUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('MissDamageUpgrade_Adv'));
	SetUpMissDamageUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('MissDamageUpgrade_Sup'));
	SetUpMissDamageUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('FreeKillUpgrade_Bsc'));
	SetUpFreeKillUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('FreeKillUpgrade_Adv'));
	SetUpFreeKillUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('FreeKillUpgrade_Sup'));
	SetUpFreeKillUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('ReloadUpgrade_Bsc'));
	SetUpReloadUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('ReloadUpgrade_Adv'));
	SetUpReloadUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
	ItemTemplate = X2WeaponUpgradeTemplate(ItemManager.FindItemTemplate('ReloadUpgrade_Sup'));
	SetUpReloadUpgrade(ItemTemplate);
	SetUpAlienHuntersGraphics(ItemTemplate);
}

static function SetUpCritUpgrade(out X2WeaponUpgradeTemplate Template)
{
	local name WeaponName;
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_OpticA", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticA_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
}

static function SetUpAimBonusUpgrade(out X2WeaponUpgradeTemplate Template)
{
	local name WeaponName;
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;
	
	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_OpticC_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticC", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_OpticB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
}

static function SetUpClipSizeBonusUpgrade(X2WeaponUpgradeTemplate Template)
{
	local name WeaponName;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponPrimary;
	
	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagB", "", 'Pistol_CV', , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagB", "", 'Pistol_MG', , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagB", "", 'Pistol_BM', , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_MagB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	}
}

static function SetUpFreeFireBonusUpgrade(out X2WeaponUpgradeTemplate Template)
{
	local name WeaponName;
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "ConvAttachments.Meshes.SM_ConvReargripB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_ReargripB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_ReargripB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "MagAttachments.Meshes.SM_MagReargripB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_TriggerB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Core', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_CoreB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_CoreB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_CoreB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Core_Teeth', '', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_TeethA", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_Teeth", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_Teeth_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");
	}
}

static function SetUpMissDamageUpgrade(out X2WeaponUpgradeTemplate Template)
{
	local name WeaponName;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponPrimary;

	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_StockB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('HeatSink', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_HeatsinkB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_HeatsinkB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_HeatsinkB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	}
}

static function SetUpFreeKillUpgrade(out X2WeaponUpgradeTemplate Template)
{
	local name WeaponName;
	Template.CanApplyUpgradeToWeaponFn = class'GrimyLoot_UpgradesSecondary'.static.CanApplyUpgradeToWeaponPrimaryOrPistol;
	
	// Pistol
	foreach class'GrimyLoot_Research'.default.Pistol_T1(WeaponName)
	{
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T2(WeaponName)
	{
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
	foreach class'GrimyLoot_Research'.default.Pistol_T3(WeaponName)
	{
		Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_SuppressorB", "", WeaponName, , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	}
}

static function SetUpReloadUpgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponPrimary;
}