class GrimyClassAN_GrenadeLauncher extends X2Item_DefaultGrenades;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(MicroGrenadeLauncher());
	Templates.AddItem(MicroAdvGrenadeLauncher());

	return Templates;
}

static function X2GrenadeLauncherTemplate MicroGrenadeLauncher()
{
	local X2GrenadeLauncherTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, 'MicroGrenadeLauncher_CV');

	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvGrenade";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";

	Template.iSoundRange = default.GRENADELAUNCHER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.GRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.GRENADELAUNCHER_TRADINGPOSTVALUE;
	Template.iClipSize = default.GRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = 0;

	Template.IncreaseGrenadeRadius = default.GRENADELAUNCHER_RADIUSBONUS;
	Template.IncreaseGrenadeRange = default.GRENADELAUNCHER_RANGEBONUS;

	Template.GameArchetype = "GrimyClassAN_GrenadeLauncher.WP_GrenadeLauncher_CV";
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.GRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.GRENADELAUNCHER_RADIUSBONUS);

//	Template.BonusWeaponEffects.AddItem(StunEffect);

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.StowedLocation = eSlot_RightHand;
	//Template.bSoundOriginatesFromOwnerLocation = true;

	return Template;
}

static function X2GrenadeLauncherTemplate MicroAdvGrenadeLauncher()
{
	local X2GrenadeLauncherTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, 'MicroGrenadeLauncher_MG');

	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagLauncher";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";

	Template.iSoundRange = default.ADVGRENADELAUNCHER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ADVGRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = 18;
	Template.iClipSize = default.ADVGRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = 1;

	Template.IncreaseGrenadeRadius = default.ADVGRENADELAUNCHER_RADIUSBONUS;
	Template.IncreaseGrenadeRange = default.ADVGRENADELAUNCHER_RANGEBONUS;

	Template.GameArchetype = "GrimyClassAN_GrenadeLauncher.WP_GrenadeLauncher_MG";

	Template.CreatorTemplateName = 'GrenadeLauncher_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'MicroGrenadeLauncher_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeBonusLabel, , default.ADVGRENADELAUNCHER_RANGEBONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusBonusLabel, , default.ADVGRENADELAUNCHER_RADIUSBONUS);
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.StowedLocation = eSlot_RightHand;
	//Template.bSoundOriginatesFromOwnerLocation = true;

	return Template;
}