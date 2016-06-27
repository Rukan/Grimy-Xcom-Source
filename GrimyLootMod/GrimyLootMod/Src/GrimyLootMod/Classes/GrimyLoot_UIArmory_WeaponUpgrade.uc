class GrimyLoot_UIArmory_WeaponUpgrade extends UIArmory_WeaponUpgrade config(GrimyLootMod);

var config int MAXLENGTH_ITEM_NAME;

simulated function UpdateSlots()
{
	local XGParamTag LocTag;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_Item Weapon;
	local int i, SlotsAvailable, NumUpgradeSlots;
	local array<X2WeaponUpgradeTemplate> EquippedUpgrades;
	local string EquipSlotLockedStr;

	LocTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	Weapon = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(WeaponRef.ObjectID));

	LocTag.StrValue0 = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(Weapon.GetMyTemplate().GetItemFriendlyName(Weapon.ObjectID));

	// Get equipped upgrades
	EquippedUpgrades = Weapon.GetMyWeaponUpgradeTemplates();
	if ( GrimyLoot_GameState_Loot(Weapon).NumUpgrades > 0 )
	{
		NumUpgradeSlots = GrimyLoot_GameState_Loot(Weapon).NumUpgrades;
	}
	else if ( X2WeaponTemplate(Weapon.GetMyTemplate()).NumUpgradeSlots > 0 )
	{
		NumUpgradeSlots = X2WeaponTemplate(Weapon.GetMyTemplate()).NumUpgradeSlots;
	}
	else
	{
		NumUpgradeSlots = 1;
	}

	if (XComHQ.bExtraWeaponUpgrade)
		NumUpgradeSlots++;

	SlotsAvailable = NumUpgradeSlots - EquippedUpgrades.Length;

	SetAvailableSlots(class'UIUtilities_Text'.static.GetColoredText(m_strSlotsAvailable, eUIState_Disabled, 26),
					  class'UIUtilities_Text'.static.GetColoredText(SlotsAvailable $ "/" $ NumUpgradeSlots, eUIState_Highlight, 40));

	SlotsList.ClearItems();
	
	// Add equipped slots
	for (i = 0; i < EquippedUpgrades.Length; ++i)
	{
		// If an upgrade was equipped while the extra slot continent bonus was active, but it is now disabled, don't allow the upgrade to be edited
		EquipSlotLockedStr = (i > (NumUpgradeSlots - 1)) ? class'UIUtilities_Text'.static.GetColoredText(m_strRequiresContinentBonus, eUIState_Bad) : "";
		UIArmory_WeaponUpgradeItem(SlotsList.CreateItem(class'UIArmory_WeaponUpgradeItem')).InitUpgradeItem(Weapon, EquippedUpgrades[i], i, EquipSlotLockedStr);
	}

	// Add available upgrades
	for (i = 0; i < SlotsAvailable; ++i)
	{
		UIArmory_WeaponUpgradeItem(SlotsList.CreateItem(class'UIArmory_WeaponUpgradeItem')).InitUpgradeItem(Weapon, none, i + EquippedUpgrades.Length);
	}

	if(SlotsAvailable < 1)
		SetSlotsListTitle(`XEXPAND.ExpandString(m_strWeaponFullyUpgraded));
	else
		SetSlotsListTitle(`XEXPAND.ExpandString(m_strUpgradeWeapon));
}

simulated function OpenWeaponNameInputBox()
{
	local TInputDialogData kData;

	kData.strTitle = m_strCustomizeWeaponName;
	kData.iMaxChars = default.MAXLENGTH_ITEM_NAME;
	kData.strInputBoxText = UpdatedWeapon.Nickname;
	kData.fnCallback = OnNameInputBoxClosed;

	Movie.Pres.UIInputDialog(kData);
}