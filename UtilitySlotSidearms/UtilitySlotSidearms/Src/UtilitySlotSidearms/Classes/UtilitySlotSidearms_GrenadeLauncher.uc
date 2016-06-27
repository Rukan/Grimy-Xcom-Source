class UtilitySlotSidearms_GrenadeLauncher extends X2Item_DefaultGrenades config(UtilitySlotSidearms);

var config bool bEnableGrenadeLaunchers, bHideThrowGrenade;
var config array<name> GrenadeLauncherAbilities;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;

	if ( default.bEnableGrenadeLaunchers ) {
		Weapons.AddItem(UtilityGrenadeLauncher());
		Weapons.AddItem(AdvUtilityGrenadeLauncher());
		Weapons.AddItem(PairedGrenadeLauncher());
		Weapons.AddItem(AdvPairedGrenadeLauncher());
	}

	return Weapons;
}

static function X2PairedWeaponTemplate PairedGrenadeLauncher() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedGrenadeLauncher_CV');

	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvGrenade";
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityGrenadeLauncher_CV';
	Template.InventorySlot = eInvSlot_Utility;
	Template.WeaponCat = 'grenade_launcher';

	Template.Tier = 0;

	//Template.GameArchetype = "WP_GrenadeLauncher_CV.WP_GrenadeLauncher_CV";
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.GRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.GRENADELAUNCHER_RADIUSBONUS);

	return Template;
}

static function X2PairedWeaponTemplate AdvPairedGrenadeLauncher() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedGrenadeLauncher_MG');

	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagLauncher";
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_Utility;
	Template.WeaponCat = 'grenade_launcher';

	Template.TradingPostValue = 18;
	Template.Tier = 1;

	//Template.GameArchetype = "WP_GrenadeLauncher_MG.WP_GrenadeLauncher_MG";

	Template.CreatorTemplateName = 'GrenadeLauncher_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedGrenadeLauncher_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.ADVGRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.ADVGRENADELAUNCHER_RADIUSBONUS);

	return Template;
}

static function X2GrenadeLauncherTemplate UtilityGrenadeLauncher() {
	local X2GrenadeLauncherTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, 'UtilityGrenadeLauncher_CV');

	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvGrenade";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.GrenadeLauncherAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.iSoundRange = default.GRENADELAUNCHER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.GRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.GRENADELAUNCHER_TRADINGPOSTVALUE;
	Template.iClipSize = default.GRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = 0;

	Template.IncreaseGrenadeRadius = default.GRENADELAUNCHER_RADIUSBONUS;
	Template.IncreaseGrenadeRange = default.GRENADELAUNCHER_RANGEBONUS;

	Template.GameArchetype = "WP_GrenadeLauncher_CV.WP_GrenadeLauncher_CV";
	
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.GRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.GRENADELAUNCHER_RADIUSBONUS);

	return Template;
}

static function X2GrenadeLauncherTemplate AdvUtilityGrenadeLauncher() {
	local X2GrenadeLauncherTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, 'UtilityGrenadeLauncher_MG');

	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagLauncher";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.GrenadeLauncherAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.iSoundRange = default.ADVGRENADELAUNCHER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ADVGRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = 18;
	Template.iClipSize = default.ADVGRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = 1;

	Template.IncreaseGrenadeRadius = default.ADVGRENADELAUNCHER_RADIUSBONUS;
	Template.IncreaseGrenadeRange = default.ADVGRENADELAUNCHER_RANGEBONUS;

	Template.GameArchetype = "WP_GrenadeLauncher_MG.WP_GrenadeLauncher_MG";

	Template.CreatorTemplateName = 'GrenadeLauncher_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityGrenadeLauncher_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.ADVGRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.ADVGRENADELAUNCHER_RADIUSBONUS);

	return Template;
}