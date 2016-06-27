class Grimy_CutContentAmmo_DataTemplates extends X2Item config(CutContentAmmo);

var config int FALCON_BONUS_DAMAGE;
//var config int FALCON_DODGE_PIERCING;

//var config int FLECHETTE_BONUS_DAMAGE_PER_TIER;
//var config int FLECHETTE_BONUS_DAMAGE_NO_TIER;

//var config int NEEDLE_BONUS_DAMAGE_PER_TIER;
//var config int NEEDLE_BONUS_DAMAGE_NO_TIER;

//var config int STILETTO_BONUS_DAMAGE_PER_TIER;
//var config int STILETTO_BONUS_DAMAGE_NO_TIER;
var config int STILETTO_STUN_DURATION;
var config int STILETTO_STUN_CHANCE;

var config int REDSCREEN_DISABLE_CHANCE;
var config int REDSCREEN_DAMAGE_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(GrimyCreateFalconRounds());
	Templates.AddItem(GrimyCreateFlechetteRounds());
	Templates.AddItem(GrimyCreateNeedleRounds());
	Templates.AddItem(GrimyCreateStilettoRounds());
	Templates.AddItem(GrimyCreateRedscreenRounds());

	return Templates;
}

//Create Falcon Rounds
static function X2DataTemplate GrimyCreateFalconRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'GrimyFalconRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Falcon_Rounds";
	Template.Abilities.AddItem('GrimyFalconRounds');
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.RewardDecks.AddItem('ExperimentalAmmoRewards');
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DamageBonusLabel, , default.FALCON_BONUS_DAMAGE);

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 50;
	Template.Cost.ResourceCosts.AddItem(Resources);
		
	//FX Reference
	Template.GameArchetype = "Ammo_Talon.PJ_Talon";
	
	return Template;
}

//Create Flechette Rounds
static function X2DataTemplate GrimyCreateFlechetteRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'GrimyFlechetteRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Flechette_Rounds";
	Template.Abilities.AddItem('GrimyFlechetteRounds');
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.RewardDecks.AddItem('ExperimentalAmmoRewards');
	
	//UI stat markup doesn't make sense since this damage scales with tier.

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 50;
	Template.Cost.ResourceCosts.AddItem(Resources);
		
	//FX Reference
	Template.GameArchetype = "Ammo_Flechette.PJ_Flechette";
	
	return Template;
}

//Create Needle Rounds
static function X2DataTemplate GrimyCreateNeedleRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'GrimyNeedleRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Needle_Rounds";
	Template.Abilities.AddItem('GrimyNeedleRounds');
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.RewardDecks.AddItem('ExperimentalAmmoRewards');
	
	//UI stat markup doesn't make sense since this damage scales with tier.

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 50;
	Template.Cost.ResourceCosts.AddItem(Resources);
		
	//FX Reference
	Template.GameArchetype = "Ammo_Needle.PJ_Needle";
	
	return Template;
}

//Create Stiletto Rounds
static function X2DataTemplate GrimyCreateStilettoRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'GrimyStilettoRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Stiletto_Rounds";
	Template.TargetEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.STILETTO_STUN_DURATION, default.STILETTO_STUN_CHANCE));
	Template.Abilities.AddItem('GrimyStilettoRounds');
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.RewardDecks.AddItem('ExperimentalAmmoRewards');
	
	//UI stat markup doesn't make sense since this damage scales with tier.

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 50;
	Template.Cost.ResourceCosts.AddItem(Resources);
		
	//FX Reference
	Template.GameArchetype = "Ammo_Stiletto.PJ_Stiletto";
	
	return Template;
}

//Create Redscreen Rounds
static function X2DataTemplate GrimyCreateRedscreenRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;
	local X2Effect_DisableWeapon DisableEffect;
	local WeaponDamageValue DamageValue;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'GrimyRedscreenRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Redscreen_Rounds";
	Template.Abilities.AddItem('GrimyRedscreenRounds');
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.RewardDecks.AddItem('ExperimentalAmmoRewards');
	
	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 50;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Damage
	DamageValue.Damage = default.REDSCREEN_DAMAGE_BONUS;
	DamageValue.DamageType = 'Explosive';
	Template.AddAmmoDamageModifier(none, DamageValue);

	//Disabling Effect
	DisableEffect = new class'X2Effect_DisableWeapon';
	DisableEffect.ApplyChance = default.REDSCREEN_DISABLE_CHANCE;
	Template.TargetEffects.AddItem(DisableEffect);
		
	//FX Reference
	Template.GameArchetype = "Ammo_Redscreen.PJ_Redscreen";
	
	return Template;
}