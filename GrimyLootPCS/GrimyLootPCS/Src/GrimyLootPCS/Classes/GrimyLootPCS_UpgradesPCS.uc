class GrimyLootPCS_UpgradesPCS extends X2Item config(GrimyLootPCS_ItemData);

var config array<name> PCSRewards;
var config string UpgradeColor;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventTrooperBsc','GrimyPCSUpgradeAdventTrooperBsc','GrimyPCSUpgradeAdventTrooperAdv','GrimyPCSUpgradeAdventTrooperSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventTrooperAdv','GrimyPCSUpgradeAdventTrooperAdv','GrimyPCSUpgradeAdventTrooperBsc','GrimyPCSUpgradeAdventTrooperSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventTrooperSup','GrimyPCSUpgradeAdventTrooperSup','GrimyPCSUpgradeAdventTrooperAdv','GrimyPCSUpgradeAdventTrooperBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventOfficerBsc','GrimyPCSUpgradeAdventOfficerBsc','GrimyPCSUpgradeAdventOfficerAdv','GrimyPCSUpgradeAdventOfficerSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventOfficerAdv','GrimyPCSUpgradeAdventOfficerAdv','GrimyPCSUpgradeAdventOfficerBsc','GrimyPCSUpgradeAdventOfficerSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventOfficerSup','GrimyPCSUpgradeAdventOfficerSup','GrimyPCSUpgradeAdventOfficerAdv','GrimyPCSUpgradeAdventOfficerBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventTurretBsc','GrimyPCSUpgradeAdventTurretBsc','GrimyPCSUpgradeAdventTurretAdv','GrimyPCSUpgradeAdventTurretSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventTurretAdv','GrimyPCSUpgradeAdventTurretAdv','GrimyPCSUpgradeAdventTurretBsc','GrimyPCSUpgradeAdventTurretSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventTurretSup','GrimyPCSUpgradeAdventTurretSup','GrimyPCSUpgradeAdventTurretAdv','GrimyPCSUpgradeAdventTurretBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventMECBsc','GrimyPCSUpgradeAdventMECBsc','GrimyPCSUpgradeAdventMECAdv','GrimyPCSUpgradeAdventMECSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventMECAdv','GrimyPCSUpgradeAdventMECAdv','GrimyPCSUpgradeAdventMECBsc','GrimyPCSUpgradeAdventMECSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventMECSup','GrimyPCSUpgradeAdventMECSup','GrimyPCSUpgradeAdventMECAdv','GrimyPCSUpgradeAdventMECBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventStunLancerBsc','GrimyPCSUpgradeAdventStunLancerBsc','GrimyPCSUpgradeAdventStunLancerAdv','GrimyPCSUpgradeAdventStunLancerSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventStunLancerAdv','GrimyPCSUpgradeAdventStunLancerAdv','GrimyPCSUpgradeAdventStunLancerBsc','GrimyPCSUpgradeAdventStunLancerSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventStunLancerSup','GrimyPCSUpgradeAdventStunLancerSup','GrimyPCSUpgradeAdventStunLancerAdv','GrimyPCSUpgradeAdventStunLancerBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventShieldbearerBsc','GrimyPCSUpgradeAdventShieldbearerBsc','GrimyPCSUpgradeAdventShieldbearerAdv','GrimyPCSUpgradeAdventShieldbearerSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventShieldbearerAdv','GrimyPCSUpgradeAdventShieldbearerAdv','GrimyPCSUpgradeAdventShieldbearerBsc','GrimyPCSUpgradeAdventShieldbearerSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAdventShieldbearerSup','GrimyPCSUpgradeAdventShieldbearerSup','GrimyPCSUpgradeAdventShieldbearerAdv','GrimyPCSUpgradeAdventShieldbearerBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAndromedonBsc','GrimyPCSUpgradeAndromedonBsc','GrimyPCSUpgradeAndromedonAdv','GrimyPCSUpgradeAndromedonSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAndromedonAdv','GrimyPCSUpgradeAndromedonAdv','GrimyPCSUpgradeAndromedonBsc','GrimyPCSUpgradeAndromedonSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusAndromedonSup','GrimyPCSUpgradeAndromedonSup','GrimyPCSUpgradeAndromedonAdv','GrimyPCSUpgradeAndromedonBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusViperBsc','GrimyPCSUpgradeViperBsc','GrimyPCSUpgradeViperAdv','GrimyPCSUpgradeViperSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusViperAdv','GrimyPCSUpgradeViperAdv','GrimyPCSUpgradeViperBsc','GrimyPCSUpgradeViperSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusViperSup','GrimyPCSUpgradeViperSup','GrimyPCSUpgradeViperAdv','GrimyPCSUpgradeViperBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusArchonBsc','GrimyPCSUpgradeArchonBsc','GrimyPCSUpgradeArchonAdv','GrimyPCSUpgradeArchonSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusArchonAdv','GrimyPCSUpgradeArchonAdv','GrimyPCSUpgradeArchonBsc','GrimyPCSUpgradeArchonSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusArchonSup','GrimyPCSUpgradeArchonSup','GrimyPCSUpgradeArchonAdv','GrimyPCSUpgradeArchonBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusMutonBsc','GrimyPCSUpgradeMutonBsc','GrimyPCSUpgradeMutonAdv','GrimyPCSUpgradeMutonSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusMutonAdv','GrimyPCSUpgradeMutonAdv','GrimyPCSUpgradeMutonBsc','GrimyPCSUpgradeMutonSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusMutonSup','GrimyPCSUpgradeMutonSup','GrimyPCSUpgradeMutonAdv','GrimyPCSUpgradeMutonBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusChryssalidBsc','GrimyPCSUpgradeChryssalidBsc','GrimyPCSUpgradeChryssalidAdv','GrimyPCSUpgradeChryssalidSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusChryssalidAdv','GrimyPCSUpgradeChryssalidAdv','GrimyPCSUpgradeChryssalidBsc','GrimyPCSUpgradeChryssalidSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusChryssalidSup','GrimyPCSUpgradeChryssalidSup','GrimyPCSUpgradeChryssalidAdv','GrimyPCSUpgradeChryssalidBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusSectoidBsc','GrimyPCSUpgradeSectoidBsc','GrimyPCSUpgradeSectoidAdv','GrimyPCSUpgradeSectoidSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusSectoidAdv','GrimyPCSUpgradeSectoidAdv','GrimyPCSUpgradeSectoidBsc','GrimyPCSUpgradeSectoidSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusSectoidSup','GrimyPCSUpgradeSectoidSup','GrimyPCSUpgradeSectoidAdv','GrimyPCSUpgradeSectoidBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusSectopodBsc','GrimyPCSUpgradeSectopodBsc','GrimyPCSUpgradeSectopodAdv','GrimyPCSUpgradeSectopodSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusSectopodAdv','GrimyPCSUpgradeSectopodAdv','GrimyPCSUpgradeSectopodBsc','GrimyPCSUpgradeSectopodSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusSectopodSup','GrimyPCSUpgradeSectopodSup','GrimyPCSUpgradeSectopodAdv','GrimyPCSUpgradeSectopodBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusFacelessBsc','GrimyPCSUpgradeFacelessBsc','GrimyPCSUpgradeFacelessAdv','GrimyPCSUpgradeFacelessSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusFacelessAdv','GrimyPCSUpgradeFacelessAdv','GrimyPCSUpgradeFacelessBsc','GrimyPCSUpgradeFacelessSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusFacelessSup','GrimyPCSUpgradeFacelessSup','GrimyPCSUpgradeFacelessAdv','GrimyPCSUpgradeFacelessBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusCyberusBsc','GrimyPCSUpgradeCyberusBsc','GrimyPCSUpgradeCyberusAdv','GrimyPCSUpgradeCyberusSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusCyberusAdv','GrimyPCSUpgradeCyberusAdv','GrimyPCSUpgradeCyberusBsc','GrimyPCSUpgradeCyberusSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusCyberusSup','GrimyPCSUpgradeCyberusSup','GrimyPCSUpgradeCyberusAdv','GrimyPCSUpgradeCyberusBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusGatekeeperBsc','GrimyPCSUpgradeGatekeeperBsc','GrimyPCSUpgradeGatekeeperAdv','GrimyPCSUpgradeGatekeeperSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusGatekeeperAdv','GrimyPCSUpgradeGatekeeperAdv','GrimyPCSUpgradeGatekeeperBsc','GrimyPCSUpgradeGatekeeperSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusGatekeeperSup','GrimyPCSUpgradeGatekeeperSup','GrimyPCSUpgradeGatekeeperAdv','GrimyPCSUpgradeGatekeeperBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusBerserkerBsc','GrimyPCSUpgradeBerserkerBsc','GrimyPCSUpgradeBerserkerAdv','GrimyPCSUpgradeBerserkerSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusBerserkerAdv','GrimyPCSUpgradeBerserkerAdv','GrimyPCSUpgradeBerserkerBsc','GrimyPCSUpgradeBerserkerSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusBerserkerSup','GrimyPCSUpgradeBerserkerSup','GrimyPCSUpgradeBerserkerAdv','GrimyPCSUpgradeBerserkerBsc',2));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusPsiWitchBsc','GrimyPCSUpgradePsiWitchBsc','GrimyPCSUpgradePsiWitchAdv','GrimyPCSUpgradePsiWitchSup',0));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusPsiWitchAdv','GrimyPCSUpgradePsiWitchAdv','GrimyPCSUpgradePsiWitchBsc','GrimyPCSUpgradePsiWitchSup',1));
	Items.AddItem(CreatePCSUpgrade('GrimyCorpseBonusPsiWitchSup','GrimyPCSUpgradePsiWitchSup','GrimyPCSUpgradePsiWitchAdv','GrimyPCSUpgradePsiWitchBsc',2));

	return Items;
}

static function X2DataTemplate CreatePCSUpgrade(name AbilityName, name TemplateName1, name TemplateName2, name TemplateName3, int tier)
{
	local X2WeaponUpgradeTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, TemplateName1);
	class'GrimyLootPCS_ItemTemplateHelper'.static.AddFontColor(Template,default.UpgradeColor);
	SetUpPCSGraphics_Blank(Template);
	SetUpTierUpgrade(Template, tier);
	Template.BonusAbilities.AddItem(AbilityName);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName1);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName2);
	Template.MutuallyExclusiveUpgrades.AddItem(TemplateName3);
	return Template;
}

static function SetUpPCSGraphics_Blank(out X2WeaponUpgradeTemplate Template)
{
	local name PCSName;

	Template.CanApplyUpgradeToWeaponFn = CanApplyUpgradeToPCS;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;

	Template.BlackMarketTexts = class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;
	
	foreach default.PCSRewards(PCSName) {
		Template.AddUpgradeAttachment('', '', "", "", PCSName, , "", "", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");
	}
}

static function bool IsPCS(XComGameState_Item SourceWeapon)
{
	return SourceWeapon.InventorySlot == eInvSlot_CombatSim;
}

static function bool CanApplyUpgradeToPCS(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Item Weapon, int SlotIndex)
{
	local array<X2WeaponUpgradeTemplate> AttachedUpgradeTemplates;
	local X2WeaponUpgradeTemplate AttachedUpgrade; 
	local int iSlot;
		
	AttachedUpgradeTemplates = Weapon.GetMyWeaponUpgradeTemplates();

	if ( !IsPCS(Weapon) )
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