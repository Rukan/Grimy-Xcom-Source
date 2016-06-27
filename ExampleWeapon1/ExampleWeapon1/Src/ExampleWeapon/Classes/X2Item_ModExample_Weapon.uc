//---------------------------------------------------------------------------------------
//  FILE:   X2Item_ModExample_Weapon.uc
//  AUTHOR:  Ryan McFall
//           
//	Template classes define new game mechanics & items. In this example a weapon template
//  is created that can be used to add a new type of weapon to the XCom arsenal
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2Item_ModExample_Weapon extends X2Item; 

//Template classes are searched for by the game when it starts. Any derived classes have their CreateTemplates function called
//on the class default object. The game expects CreateTemplates to return a list of templates that it will add to the manager
//reponsible for those types of templates. Later, these templates will be automatically picked up by the game mechanics and systems.
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;

	ModWeapons.AddItem(CreateTemplate_ModWeapon_Conventional());

	return ModWeapons;
}

//Template creation functions form the bulk of a template class. This one builds our custom weapon.
static function X2DataTemplate CreateTemplate_ModWeapon_Conventional()
{
	local X2WeaponTemplate Template;

	// Basic properties copied from the conventional assault rifle
	//=====================================================================
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ModWeapon_CV');
	Template.WeaponPanelImage = "_ConventionalRifle";
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_Base";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 1;
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');	
	Template.Abilities.AddItem('Overwatch');	
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagA");
	Template.AddDefaultAttachment('Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticA");
	Template.AddDefaultAttachment('Reargrip', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_ReargripA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_ReargripA");
	Template.AddDefaultAttachment('Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_StockA");
	Template.AddDefaultAttachment('Trigger', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_TriggerA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");
	Template.iPhysicsImpulse = 5;
	Template.StartingItem = true;
	Template.CanBeBuilt = false;	
	Template.UpgradeItem = 'AssaultRifle_MG';
	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;
	//=====================================================================

	// Enhancements we're making to base
	//=====================================================================
	Template.BaseDamage.Damage += 2; //Boost damage
	Template.CritChance += 5; //Boost crit
	Template.Abilities.AddItem('Suppression'); //This weapon confers suppression
	Template.GameArchetype = "WP_ModExampleWeapon_CV.WP_ModExampleWeapon_CV"; //Use a custom archetype
	//=====================================================================
	
	return Template;
}