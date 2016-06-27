class MoreHotkeys_ItemCard extends UIItemCard;

var localized string kItemTags;

var UIText kDesc, kVals;

simulated function PopulateItemCard(optional X2ItemTemplate ItemTemplate, optional StateObjectReference ItemRef)
{
	local string strDesc, strRequirement, strTitle;
	local XComGameState_Item				ItemState;
	local X2WeaponTemplate					WeaponTemplate;
	local WeaponDamageValue					WeaponDamage;
	local string							sVals;

	if( ItemTemplate == None )
	{
		Hide();
		return;
	}

	bWaitingForImageUpdate = false;

	strDesc = ""; //Description and requirements strings are reversed for item cards, desc appears at the very bottom of the card so not needed here
	//strRequirement = class'UIUtilities_Text'.static.GetColoredText(ItemTemplate.GetItemBriefSummary(ItemRef.ObjectID), eUIState_Normal, 20);
	strRequirement = "";

	ItemState = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(ItemRef.ObjectID));
	if ( ItemState.NickName != "" ) {
		strTitle = ItemState.Nickname;
	}
	else {
		strTitle = class'UIUtilities_Text'.static.GetColoredText(class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(ItemTemplate.GetItemFriendlyName()), eUIState_Header, 24);
	}

	ItemState.GetBaseWeaponDamageValue(ItemState, WeaponDamage);
	WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());

	sVals = WeaponDamage.Tag $ "\n";
	sVals = sVals $ WeaponDamage.DamageType $ "\n";

	if ( ItemState.HasInfiniteAmmo() )
		sVals = sVals $ "Infinite\n";
	else
		sVals = sVals $ ItemState.Ammo $ "/" $ ItemState.GetClipSize() $ "\n";

	sVals = sVals $ WeaponDamage.Damage $ "\n";
	sVals = sVals $ WeaponDamage.Spread $ "\n";
	sVals = sVals $ WeaponDamage.PlusOne $ "\n";
	sVals = sVals $ WeaponTemplate.default.iEnvironmentDamage $ "\n";
	sVals = sVals $ WeaponTemplate.default.CritChance $ "\n";
	sVals = sVals $ WeaponDamage.Crit $ "\n";
	sVals = sVals $ WeaponDamage.Pierce $ "\n";
	sVals = sVals $ WeaponDamage.Shred $ "\n";
	sVals = sVals $ WeaponDamage.Rupture;

	if ( kDesc == none ) {
		kDesc = Spawn(class'UIText', self).InitText('DescriptionText', class'UIUtilities_Text'.static.GetColoredText(kItemTags, eUIState_Header, 24));
		kDesc.SetPosition(17,380);
		kDesc.Show();
	}
	else {
		kDesc.SetText(class'UIUtilities_Text'.static.GetColoredText(kItemTags, eUIState_Header, 24));
	}
	if ( kVals == none ) {
		kVals = Spawn(class'UIText', self).InitText('ValueText', class'UIUtilities_Text'.static.GetColoredText(sVals, eUIState_Header, 24));
		kVals.SetPosition(282,380);
		kVals.Show();
	}
	else {
		kVals.SetText(class'UIUtilities_Text'.static.GetColoredText(sVals, eUIState_Header, 24));
	}

	PopulateData(strTitle, strDesc, strRequirement, "");
	SetItemImages(ItemTemplate, ItemRef);
}