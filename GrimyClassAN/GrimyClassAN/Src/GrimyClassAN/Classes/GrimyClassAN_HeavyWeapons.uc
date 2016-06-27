class GrimyClassAN_HeavyWeapons extends X2Item_HeavyWeapons;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;
	
	Weapons.AddItem(GrimyFlamethrower());
	Weapons.AddItem(GrimyShredderGun());

	return Weapons;
}

static function X2WeaponTemplate GrimyShredderGun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'GrimyShredderGun');
	Template.WeaponCat = 'heavy';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Shredder_Gun";
	Template.EquipSound = "StrategyUI_Heavy_Weapon_Equip";

	Template.BaseDamage = default.SHREDDERGUN_BASEDAMAGE;
	Template.iSoundRange = default.SHREDDERGUN_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SHREDDERGUN_IENVIRONMENTDAMAGE;
	Template.iClipSize = default.SHREDDERGUN_ICLIPSIZE;
	Template.iRange = default.SHREDDERGUN_RANGE;
	Template.iRadius = default.SHREDDERGUN_RADIUS;
	Template.PointsToComplete = 0;
	
	Template.PointsToComplete = default.SHREDDERGUN_IPOINTS;
	Template.TradingPostValue = default.SHREDDERGUN_TRADINGPOSTVALUE;
	
	Template.InventorySlot = eInvSlot_SeptenaryWeapon;
	Template.StowedLocation = eSlot_HeavyWeapon;
	Template.GameArchetype = "WP_Heavy_ShredderGun.WP_Heavy_ShredderGun";
	Template.AltGameArchetype = "WP_Heavy_ShredderGun.WP_Heavy_ShredderGun_Powered";
	Template.ArmorTechCatForAltArchetype = 'powered';
	Template.bMergeAmmo = true;

	Template.CanBeBuilt = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.SHREDDERGUN_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.SHREDDERGUN_RADIUS);

	return Template;
}

static function X2WeaponTemplate GrimyFlamethrower()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'GrimyFlamethrower');
	Template.WeaponCat = 'heavy';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_FlameThrower";
	Template.EquipSound = "StrategyUI_Heavy_Weapon_Equip";

	Template.BaseDamage = default.FLAMETHROWER_BASEDAMAGE;
	Template.iSoundRange = default.FLAMETHROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.FLAMETHROWER_IENVIRONMENTDAMAGE;
	Template.iClipSize = default.FLAMETHROWER_ICLIPSIZE;
	Template.iRange = default.FLAMETHROWER_RANGE;
	Template.iRadius = default.FLAMETHROWER_RADIUS;
	Template.PointsToComplete = 0;
	Template.DamageTypeTemplateName = 'Fire';
	Template.fCoverage = 100.0f;

	Template.PointsToComplete = default.FLAMETHROWER_IPOINTS;
	Template.TradingPostValue = default.FLAMETHROWER_TRADINGPOSTVALUE;
	
	Template.InventorySlot = eInvSlot_SenaryWeapon;
	Template.StowedLocation = eSlot_HeavyWeapon;
	Template.GameArchetype = "WP_HeavyFlamethrower.WP_Heavy_Flamethrower";
	Template.AltGameArchetype = "WP_HeavyFlamethrower.WP_Heavy_Flamethrower_Powered";
	Template.ArmorTechCatForAltArchetype = 'powered';
	Template.bMergeAmmo = true;

	Template.CanBeBuilt = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.FLAMETHROWER_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.FLAMETHROWER_RADIUS);

	return Template;
}