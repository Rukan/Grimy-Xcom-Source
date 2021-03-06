class GrimyAttrition_Upgrades extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreateReserveArmor_Bsc());
	Items.AddItem(CreateReserveArmor_Adv());
	Items.AddItem(CreateReserveArmor_Sup());

	return Items;
}

static function X2DataTemplate CreateReserveArmor_Bsc()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReserveArmor_Bsc');
	SetUpArmorGraphics_Blank(Template);
	SetUpTier1Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAttrition_BscReserves');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Sup');
	return Template;
}

static function X2DataTemplate CreateReserveArmor_Adv()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReserveArmor_Adv');
	SetUpArmorGraphics_Blank(Template);
	SetUpTier2Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAttrition_AdvReserves');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Sup');
	return Template;
}

static function X2DataTemplate CreateReserveArmor_Sup()
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'GrimyReserveArmor_Sup');
	SetUpArmorGraphics_Blank(Template);
	SetUpTier3Upgrade(Template);
	Template.BonusAbilities.AddItem('GrimyAttrition_SupReserves');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('GrimyReserveArmor_Sup');
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

static function SetUpTier1Upgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentA';
	Template.TradingPostValue = 25;
	Template.Tier = 0;
}

static function SetUpTier2Upgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentB';
	Template.TradingPostValue = 50;
	Template.Tier = 1;
}

static function SetUpTier3Upgrade(out X2WeaponUpgradeTemplate Template)
{
	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentA';
	Template.TradingPostValue = 100;
	Template.Tier = 2;
}