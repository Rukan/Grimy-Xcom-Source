class MissionTimers_Upgrades extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreateArmorUpgrade('GrimyBonusTimeBsc', 'GrimyBonusTimeBscUpgrade', 'GrimyBonusTimeAdvUpgrade', 'GrimyBonusTimeSupUpgrade', 0));
	Items.AddItem(CreateArmorUpgrade('GrimyBonusTimeAdv', 'GrimyBonusTimeAdvUpgrade', 'GrimyBonusTimeBscUpgrade', 'GrimyBonusTimeSupUpgrade', 1));
	Items.AddItem(CreateArmorUpgrade('GrimyBonusTimeSup', 'GrimyBonusTimeSupUpgrade', 'GrimyBonusTimeAdvUpgrade', 'GrimyBonusTimeBscUpgrade', 2));

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