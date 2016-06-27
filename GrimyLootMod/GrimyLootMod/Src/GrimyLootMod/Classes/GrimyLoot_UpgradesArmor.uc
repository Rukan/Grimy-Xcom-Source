class GrimyLoot_UpgradesArmor extends X2Item config(GrimyLootMod);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreateBasicGrimyTacticalSensorsArmor());
	Items.AddItem(CreateAdvancedGrimyTacticalSensorsArmor());
	Items.AddItem(CreateSuperiorGrimyTacticalSensorsArmor());
	Items.AddItem(CreateBasicGrimyReactiveSensorsArmor());
	Items.AddItem(CreateAdvancedGrimyReactiveSensorsArmor());
	Items.AddItem(CreateSuperiorGrimyReactiveSensorsArmor());
	
	Items.AddItem(CreateBasicGrimyBlastPaddingArmor());
	Items.AddItem(CreateAdvancedGrimyBlastPaddingArmor());
	Items.AddItem(CreateSuperiorGrimyBlastPaddingArmor());
	Items.AddItem(CreateBasicGrimyHardpointsArmor());
	Items.AddItem(CreateAdvancedGrimyHardpointsArmor());
	Items.AddItem(CreateSuperiorGrimyHardpointsArmor());
	Items.AddItem(CreateBasicGrimyFlexweaveArmor());
	Items.AddItem(CreateAdvancedGrimyFlexweaveArmor());
	Items.AddItem(CreateSuperiorGrimyFlexweaveArmor());
	Items.AddItem(CreateBasicGrimyUndervestArmor());
	Items.AddItem(CreateAdvancedGrimyUndervestArmor());
	Items.AddItem(CreateSuperiorGrimyUndervestArmor());
	Items.AddItem(CreateBasicGrimyMagDeflectorsArmor());
	Items.AddItem(CreateAdvancedGrimyMagDeflectorsArmor());
	Items.AddItem(CreateSuperiorGrimyMagDeflectorsArmor());
	Items.AddItem(CreateBasicGrimyEnergyDiffuserArmor());
	Items.AddItem(CreateAdvancedGrimyEnergyDiffuserArmor());
	Items.AddItem(CreateSuperiorGrimyEnergyDiffuserArmor());
	
	Items.AddItem(CreateBasicGrimyShieldBatteryArmor());
	Items.AddItem(CreateAdvancedGrimyShieldBatteryArmor());
	Items.AddItem(CreateSuperiorGrimyShieldBatteryArmor());
	Items.AddItem(CreateBasicGrimyLegServosArmor());
	Items.AddItem(CreateAdvancedGrimyLegServosArmor());
	Items.AddItem(CreateSuperiorGrimyLegServosArmor());
	Items.AddItem(CreateBasicGrimyDigitalCamoArmor());
	Items.AddItem(CreateAdvancedGrimyDigitalCamoArmor());
	Items.AddItem(CreateSuperiorGrimyDigitalCamoArmor());
	Items.AddItem(CreateBasicGrimyStasisArmor());
	Items.AddItem(CreateAdvancedGrimyStasisArmor());
	Items.AddItem(CreateSuperiorGrimyStasisArmor());
	Items.AddItem(CreateBasicGrimyRageStimulantArmor());
	Items.AddItem(CreateAdvancedGrimyRageStimulantArmor());
	Items.AddItem(CreateSuperiorGrimyRageStimulantArmor());
	
	Items.AddItem(CreateBasicGrimyMediSatchelArmor());
	Items.AddItem(CreateAdvancedGrimyMediSatchelArmor());
	Items.AddItem(CreateSuperiorGrimyMediSatchelArmor());
	Items.AddItem(CreateBasicGrimySmokeSatchelArmor());
	Items.AddItem(CreateAdvancedGrimySmokeSatchelArmor());
	Items.AddItem(CreateSuperiorGrimySmokeSatchelArmor());
	Items.AddItem(CreateBasicGrimySpotterSatchelArmor());
	Items.AddItem(CreateAdvancedGrimySpotterSatchelArmor());
	Items.AddItem(CreateSuperiorGrimySpotterSatchelArmor());
	Items.AddItem(CreateBasicGrimyRiotHarnessArmor());
	Items.AddItem(CreateAdvancedGrimyRiotHarnessArmor());
	Items.AddItem(CreateSuperiorGrimyRiotHarnessArmor());
	
	Items.AddItem(CreateBasicGrimyStimplantArmor());
	Items.AddItem(CreateAdvancedGrimyStimplantArmor());
	Items.AddItem(CreateSuperiorGrimyStimplantArmor());
	Items.AddItem(CreateBasicGrimyReactiveServosArmor());
	Items.AddItem(CreateAdvancedGrimyReactiveServosArmor());
	Items.AddItem(CreateSuperiorGrimyReactiveServosArmor());
	Items.AddItem(CreateBasicGrimyAbsorptionFieldArmor());
	Items.AddItem(CreateAdvancedGrimyAbsorptionFieldArmor());
	Items.AddItem(CreateSuperiorGrimyAbsorptionFieldArmor());
	Items.AddItem(CreateBasicGrimyShieldGateArmor());
	Items.AddItem(CreateAdvancedGrimyShieldGateArmor());
	Items.AddItem(CreateSuperiorGrimyShieldGateArmor());

	return Items;
}

// #######################################################################################
// -------------------- ARMOR TEMPLATE FUNCTIONS -----------------------------------------
// #######################################################################################

static function X2DataTemplate CreateBasicGrimyTacticalSensorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyTacticalSensors_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyTacticalSensors5');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyTacticalSensorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyTacticalSensors_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyTacticalSensors10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyTacticalSensorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyTacticalSensors_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyTacticalSensors15');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyTacticalSensors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyReactiveSensorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReactiveSensors_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReactiveSensors15');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyReactiveSensorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReactiveSensors_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReactiveSensors20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyReactiveSensorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReactiveSensors_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReactiveSensors25');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveSensors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyBlastPaddingArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyBlastPadding_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusArmor1');
	Template.BonusAbilities.AddItem('GrimyResistExplosion50');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyBlastPaddingArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyBlastPadding_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusArmor1');
	Template.BonusAbilities.AddItem('GrimyResistExplosion70');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyBlastPaddingArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyBlastPadding_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusArmor1');
	Template.BonusAbilities.AddItem('GrimyResistExplosion90');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyBlastPadding_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyHardpointsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHardpoints_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReduceCrit5');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyHardpointsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHardpoints_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReduceCrit10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyHardpointsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyHardpoints_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReduceCrit15');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyHardpoints_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyFlexweaveArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyFlexweave_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMobility_One');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyFlexweaveArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyFlexweave_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMobility_One');
	Template.BonusAbilities.AddItem('GrimyIncreaseDodge10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyFlexweaveArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyFlexweave_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMobility_One');
	Template.BonusAbilities.AddItem('GrimyIncreaseDodge20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyFlexweave_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyUndervestArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyUndervest_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHitPoint1');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyUndervestArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyUndervest_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHitPoint2');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyUndervestArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyUndervest_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHitPoint3');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyUndervest_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyMagDeflectorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMagDeflectors_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyResistMag20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyMagDeflectorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMagDeflectors_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyResistMag25');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyMagDeflectorsArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMagDeflectors_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyResistMag30');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMagDeflectors_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyEnergyDiffuserArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyEnergyDiffuser_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyResistBeam20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyEnergyDiffuserArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyEnergyDiffuser_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyResistBeam25');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyEnergyDiffuserArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyEnergyDiffuser_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyResistBeam30');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyEnergyDiffuser_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyShieldBatteryArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyShieldBattery_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyShieldBattery1');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyShieldBatteryArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyShieldBattery_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyShieldBattery2');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyShieldBatteryArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyShieldBattery_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyShieldBattery3');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldBattery_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyLegServosArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyLegServos_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyLegServos1');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyLegServosArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyLegServos_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyLegServos2');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyLegServosArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyLegServos_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyLegServos3');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyLegServos_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyDigitalCamoArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDigitalCamo_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDetectionModifier10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyDigitalCamoArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDigitalCamo_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDetectionModifier20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyDigitalCamoArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyDigitalCamo_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyDetectionModifier30');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyDigitalCamo_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyStasisArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStasis_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHealthRegen6');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyStasisArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStasis_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHealthRegen8');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyStasisArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStasis_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyHealthRegen10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStasis_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyRageStimulantArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRageStimulant_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyInjuredBonus10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyRageStimulantArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRageStimulant_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyInjuredBonus15');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyRageStimulantArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRageStimulant_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyInjuredBonus20');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRageStimulant_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyMediSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMediSatchel_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMedikitsOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyMediSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMediSatchel_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMedikitsTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyMediSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyMediSatchel_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusMedikitsThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyMediSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimySmokeSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySmokeSatchel_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusSmokesOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimySmokeSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySmokeSatchel_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusSmokesTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimySmokeSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySmokeSatchel_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusSmokesThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySmokeSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimySpotterSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySpotterSatchel_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusScannerOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimySpotterSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySpotterSatchel_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusScannerTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimySpotterSatchelArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimySpotterSatchel_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusScannerThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimySpotterSatchel_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyRiotHarnessArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRiotHarness_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusFlashbangsOne');
	Template.BonusAbilities.AddItem('GrimyFlashbangDamageOne');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyRiotHarnessArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRiotHarness_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusFlashbangsOne');
	Template.BonusAbilities.AddItem('GrimyFlashbangDamageTwo');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyRiotHarnessArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyRiotHarness_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyBonusFlashbangsOne');
	Template.BonusAbilities.AddItem('GrimyFlashbangDamageThree');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyRiotHarness_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyStimplantArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStimplant_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyStimplant3');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyStimplantArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStimplant_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyStimplant4');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyStimplantArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyStimplant_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyStimplant5');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyStimplant_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyReactiveServosArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReactiveServos_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReturnShot');
	Template.BonusAbilities.AddItem('GrimyBonusOverwatch5');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyReactiveServosArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReactiveServos_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReturnShot');
	Template.BonusAbilities.AddItem('GrimyBonusOverwatch10');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyReactiveServosArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReactiveServos_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyReturnShot');
	Template.BonusAbilities.AddItem('GrimyBonusOverwatch15');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReactiveServos_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyAbsorptionFieldArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAbsorptionField_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAbsorption40');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyAbsorptionFieldArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAbsorptionField_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAbsorption35');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyAbsorptionFieldArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyAbsorptionField_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAbsorption30');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyAbsorptionField_SupArmor');
	return Template;
}

static function X2DataTemplate CreateBasicGrimyShieldGateArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyShieldGate_BscArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyShieldGate');
	Template.BonusAbilities.AddItem('GrimyShieldPoint1');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_SupArmor');
	return Template;
}

static function X2DataTemplate CreateAdvancedGrimyShieldGateArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyShieldGate_AdvArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyShieldGate');
	Template.BonusAbilities.AddItem('GrimyShieldPoint2');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_SupArmor');
	return Template;
}

static function X2DataTemplate CreateSuperiorGrimyShieldGateArmor()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyShieldGate_SupArmor');
	SetUpArmorGraphics_Blank(Template);
	class'GrimyLoot_UpgradesPrimary'.static.SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyShieldGate');
	Template.BonusAbilities.AddItem('GrimyShieldPoint3');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_BscArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_AdvArmor');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyShieldGate_SupArmor');
	return Template;
}

// #######################################################################################
// -------------------- GRAPHICAL FUNCTIONS ----------------------------------------------
// #######################################################################################

static function SetUpArmorGraphics_Blank(out X2WeaponUpgradeTemplate Template)
{
	local name ArmorName;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponArmor;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
	
	foreach class'GrimyLoot_Research'.default.MA_T1(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }
	foreach class'GrimyLoot_Research'.default.LA_T2(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }
	foreach class'GrimyLoot_Research'.default.MA_T2(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }
	foreach class'GrimyLoot_Research'.default.HA_T2(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }
	foreach class'GrimyLoot_Research'.default.LA_T3(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }
	foreach class'GrimyLoot_Research'.default.MA_T3(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }
	foreach class'GrimyLoot_Research'.default.HA_T3(ArmorName) { Template.AddUpgradeAttachment('', '', "", "", ArmorName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope"); }

	if ( class'GrimyLoot_Research'.default.bEnableAlienRulers ) {
		Template.AddUpgradeAttachment('', '', "", "", 'LightAlienArmor', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		Template.AddUpgradeAttachment('', '', "", "", 'MediumAlienArmor', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		Template.AddUpgradeAttachment('', '', "", "", 'HeavyAlienArmor', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");	
		Template.AddUpgradeAttachment('', '', "", "", 'MediumAlienArmorMk2', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		Template.AddUpgradeAttachment('', '', "", "", 'HeavyAlienArmorMk2', , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");	
	}
}

// #######################################################################################
// -------------------- UPGRADE FUNCTIONS ------------------------------------------------
// #######################################################################################

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