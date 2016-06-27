class GrimyClass_WeaponUpgrades extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreatePistolUpgrade('GrimyTaserShotBsc', 'GrimyTaserShotBscUpgrade', 'GrimyTaserShotAdvUpgrade', 'GrimyTaserShotSupUpgrade', 0));
	Items.AddItem(CreatePistolUpgrade('GrimyTaserShotAdv', 'GrimyTaserShotAdvUpgrade', 'GrimyTaserShotBscUpgrade', 'GrimyTaserShotSupUpgrade', 1));
	Items.AddItem(CreatePistolUpgrade('GrimyTaserShotSup', 'GrimyTaserShotSupUpgrade', 'GrimyTaserShotAdvUpgrade', 'GrimyTaserShotBscUpgrade', 2));

	Items.AddItem(CreatePistolUpgrade('GrimyGunPointBsc', 'GrimyGunPointBscUpgrade', 'GrimyGunPointAdvUpgrade', 'GrimyGunPointSupUpgrade', 0));
	Items.AddItem(CreatePistolUpgrade('GrimyGunPointAdv', 'GrimyGunPointAdvUpgrade', 'GrimyGunPointBscUpgrade', 'GrimyGunPointSupUpgrade', 1));
	Items.AddItem(CreatePistolUpgrade('GrimyGunPointSup', 'GrimyGunPointSupUpgrade', 'GrimyGunPointAdvUpgrade', 'GrimyGunPointBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyGrapeShotBsc', 'GrimyGrapeShotBscUpgrade', 'GrimyGrapeShotAdvUpgrade', 'GrimyGrapeShotSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyGrapeShotAdv', 'GrimyGrapeShotAdvUpgrade', 'GrimyGrapeShotBscUpgrade', 'GrimyGrapeShotSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyGrapeShotSup', 'GrimyGrapeShotSupUpgrade', 'GrimyGrapeShotAdvUpgrade', 'GrimyGrapeShotBscUpgrade', 2));

	Items.AddItem(CreatePrimaryUpgrade('GrimyCausticSlugBsc', 'GrimyCausticSlugBscUpgrade', 'GrimyCausticSlugAdvUpgrade', 'GrimyCausticSlugSupUpgrade', 0));
	Items.AddItem(CreatePrimaryUpgrade('GrimyCausticSlugAdv', 'GrimyCausticSlugAdvUpgrade', 'GrimyCausticSlugBscUpgrade', 'GrimyCausticSlugSupUpgrade', 1));
	Items.AddItem(CreatePrimaryUpgrade('GrimyCausticSlugSup', 'GrimyCausticSlugSupUpgrade', 'GrimyCausticSlugAdvUpgrade', 'GrimyCausticSlugBscUpgrade', 2));

	return Items;
}

static function X2DataTemplate CreatePistolUpgrade(name AbilityName, name TemplateName1, name TemplateName2, name TemplateName3, int tier)
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, TemplateName1);
	SetUpPistolGraphics_Blank(Template);
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
			Template.AddUpgradeAttachment('', '', "", "", WeaponTemplate.DataName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_heat_sink");
		}
	}
}

static function SetUpPistolGraphics_Blank(out X2WeaponUpgradeTemplate Template)
{
	local X2ItemTemplateManager			ItemManager;
	local array<X2WeaponTemplate>		WeaponTemplates;
	local X2WeaponTemplate				WeaponTemplate;
	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToWeaponPistol;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	WeaponTemplates = ItemManager.GetAllWeaponTemplates();

	foreach WeaponTemplates(WeaponTemplate) {
		if ( WeaponTemplate.WeaponCat == 'pistol' ) {
			Template.AddUpgradeAttachment('', '', "", "", WeaponTemplate.DataName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_heat_sink");
		}
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

static function bool CanApplyUpgradeToWeaponPistol(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, int SlotIndex)
{
	local array<X2WeaponUpgradeTemplate> AttachedUpgradeTemplates;
	local X2WeaponUpgradeTemplate AttachedUpgrade; 
	local int iSlot;
		
	AttachedUpgradeTemplates = Weapon.GetMyWeaponUpgradeTemplates();

	if ( Weapon.GetWeaponCategory() != 'pistol' )
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