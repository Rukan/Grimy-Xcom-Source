class GrimyClassHH_WeaponUpgrades extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreatePrimaryUpgrade('GrimyPiercingShotBsc', 'GrimyPiercingShotBscUpgrade', 'GrimyPiercingShotAdvUpgrade', 'GrimyPiercingShotSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyPiercingShotAdv', 'GrimyPiercingShotAdvUpgrade', 'GrimyPiercingShotBscUpgrade', 'GrimyPiercingShotSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyPiercingShotSup', 'GrimyPiercingShotSupUpgrade', 'GrimyPiercingShotAdvUpgrade', 'GrimyPiercingShotBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyThunderclapBsc', 'GrimyThunderclapBscUpgrade', 'GrimyThunderclapAdvUpgrade', 'GrimyThunderclapSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyThunderclapAdv', 'GrimyThunderclapAdvUpgrade', 'GrimyThunderclapBscUpgrade', 'GrimyThunderclapSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyThunderclapSup', 'GrimyThunderclapSupUpgrade', 'GrimyThunderclapAdvUpgrade', 'GrimyThunderclapBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyIncendiaryShotBsc', 'GrimyIncendiaryShotBscUpgrade', 'GrimyIncendiaryShotAdvUpgrade', 'GrimyIncendiaryShotSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyIncendiaryShotAdv', 'GrimyIncendiaryShotAdvUpgrade', 'GrimyIncendiaryShotBscUpgrade', 'GrimyIncendiaryShotSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyIncendiaryShotSup', 'GrimyIncendiaryShotSupUpgrade', 'GrimyIncendiaryShotAdvUpgrade', 'GrimyIncendiaryShotBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyTwinFangsBsc', 'GrimyTwinFangsBscUpgrade', 'GrimyTwinFangsAdvUpgrade', 'GrimyTwinFangsSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyTwinFangsAdv', 'GrimyTwinFangsAdvUpgrade', 'GrimyTwinFangsBscUpgrade', 'GrimyTwinFangsSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyTwinFangsSup', 'GrimyTwinFangsSupUpgrade', 'GrimyTwinFangsAdvUpgrade', 'GrimyTwinFangsBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyBuckshotBsc', 'GrimyBuckshotBscUpgrade', 'GrimyBuckshotAdvUpgrade', 'GrimyBuckshotSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyBuckshotAdv', 'GrimyBuckshotAdvUpgrade', 'GrimyBuckshotBscUpgrade', 'GrimyBuckshotSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyBuckshotSup', 'GrimyBuckshotSupUpgrade', 'GrimyBuckshotAdvUpgrade', 'GrimyBuckshotBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyHexHunterBsc', 'GrimyHexHunterBscUpgrade', 'GrimyHexHunterAdvUpgrade', 'GrimyHexHunterSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyHexHunterAdv', 'GrimyHexHunterAdvUpgrade', 'GrimyHexHunterBscUpgrade', 'GrimyHexHunterSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyHexHunterSup', 'GrimyHexHunterSupUpgrade', 'GrimyHexHunterAdvUpgrade', 'GrimyHexHunterBscUpgrade', 2));

	Items.AddItem(CreateArmorUpgrade('GrimyPreparationBsc', 'GrimyPreparationBscUpgrade', 'GrimyPreparationAdvUpgrade', 'GrimyPreparationSupUpgrade', 0));
	Items.AddItem(CreateArmorUpgrade('GrimyPreparationAdv', 'GrimyPreparationAdvUpgrade', 'GrimyPreparationBscUpgrade', 'GrimyPreparationSupUpgrade', 1));
	Items.AddItem(CreateArmorUpgrade('GrimyPreparationSup', 'GrimyPreparationSupUpgrade', 'GrimyPreparationAdvUpgrade', 'GrimyPreparationBscUpgrade', 2));

	Items.AddItem(CreateSwordUpgrade('GrimyBladeOilBsc', 'GrimyBladeOilBscUpgrade', 'GrimyBladeOilAdvUpgrade', 'GrimyBladeOilSupUpgrade', 0));
	Items.AddItem(CreateSwordUpgrade('GrimyBladeOilAdv', 'GrimyBladeOilAdvUpgrade', 'GrimyBladeOilBscUpgrade', 'GrimyBladeOilSupUpgrade', 1));
	Items.AddItem(CreateSwordUpgrade('GrimyBladeOilSup', 'GrimyBladeOilSupUpgrade', 'GrimyBladeOilAdvUpgrade', 'GrimyBladeOilBscUpgrade', 2));

	return Items;
}

static function X2DataTemplate CreateArmorUpgrade(name AbilityName, name TemplateName1, name TemplateName2, name TemplateName3, int tier)
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, TemplateName1);
	SetUpArmorGraphics_Blank(Template);
	SetUpTierUpgrade(Template, tier);
	Template.BonusAbilities.AddItem(AbilityName);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName1);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName2);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName3);
	return Template;
}

static function X2DataTemplate CreateSwordUpgrade(name AbilityName, name TemplateName1, name TemplateName2, name TemplateName3, int tier)
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, TemplateName1);
	SetUpSwordGraphics_Blank(Template);
	SetUpTierUpgrade(Template, tier);
	Template.BonusAbilities.AddItem(AbilityName);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName1);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName2);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName3);
	return Template;
}

static function X2DataTemplate CreatePrimaryUpgrade(name AbilityName, name TemplateName1, name TemplateName2, name TemplateName3, int tier)
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, TemplateName1);
	SetUpPrimaryGraphics_Blank(Template);
	SetUpTierUpgrade(Template, tier);
	Template.BonusAbilities.AddItem(AbilityName);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName1);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName2);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName3);
	return Template;
}

// UTILITY FUNCTIONS

static function SetUpPrimaryGraphics_Blank(out X2WeaponUpgradeTemplate Template)
{
	local X2ItemTemplateManager			ItemManager;
	local array<X2WeaponTemplate>		WeaponTemplates;
	local X2WeaponTemplate				WeaponTemplate;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponPrimary;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	WeaponTemplates = ItemManager.GetAllWeaponTemplates();

	foreach WeaponTemplates(WeaponTemplate) {
		if ( WeaponTemplate.InventorySlot == eInvSlot_PrimaryWeapon ) {
			Template.AddUpgradeAttachment('', '', "", "", WeaponTemplate.DataName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		}
	}
}

static function SetUpSwordGraphics_Blank(out X2WeaponUpgradeTemplate Template)
{
	local X2ItemTemplateManager			ItemManager;
	local array<X2WeaponTemplate>		WeaponTemplates;
	local X2WeaponTemplate				WeaponTemplate;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponSword;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	WeaponTemplates = ItemManager.GetAllWeaponTemplates();

	foreach WeaponTemplates(WeaponTemplate) {
		if ( WeaponTemplate.WeaponCat == 'Sword' ) {
			Template.AddUpgradeAttachment('', '', "", "", WeaponTemplate.DataName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
		}
	}
}

static function SetUpArmorGraphics_Blank(out X2WeaponUpgradeTemplate Template)
{
	local X2ItemTemplateManager			ItemManager;
	local array<X2EquipmentTemplate>	ArmorTemplates;
	local X2EquipmentTemplate			ArmorTemplate;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponArmor;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ArmorTemplates = ItemManager.GetAllArmorTemplates();

	foreach ArmorTemplates(ArmorTemplate) {
		Template.AddUpgradeAttachment('', '', "", "", ArmorTemplate.DataName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
}


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

	if ( !IsPrimary(Weapon) )
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

static function bool CanApplyUpgradeToWeaponSword(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, int SlotIndex)
{
	local array<X2WeaponUpgradeTemplate> AttachedUpgradeTemplates;
	local X2WeaponUpgradeTemplate AttachedUpgrade; 
	local int iSlot;
		
	AttachedUpgradeTemplates = Weapon.GetMyWeaponUpgradeTemplates();

	if ( Weapon.GetWeaponCategory() != 'Sword' )
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

static function SetUpTierUpgrade(out X2WeaponUpgradeTemplate Template, int tier)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentA';
	switch ( tier ) {
		case 2:
			Template.TradingPostValue = 100;
			break;
		case 1:
			Template.TradingPostValue = 50;
			break;
		case 0:
		default:
			Template.TradingPostValue = 25;
	}
	Template.Tier = Tier;
}