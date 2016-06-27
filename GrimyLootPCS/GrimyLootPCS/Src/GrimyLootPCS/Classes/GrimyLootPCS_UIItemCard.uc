class GrimyLootPCS_UIItemCard extends UIItemCard;

simulated function PopulateItemCard(optional X2ItemTemplate ItemTemplate, optional StateObjectReference ItemRef)
{
	local string strDesc, strRequirement, strTitle;
	local XComGameState_Item				ItemState;
	local array<X2WeaponUpgradeTemplate>	UpgradeTemplates;
	local X2WeaponUpgradeTemplate			Upgradetemplate;

	if( ItemTemplate == None )
	{
		Hide();
		return;
	}

	bWaitingForImageUpdate = false;

	strTitle = class'UIUtilities_Text'.static.GetColoredText(class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(ItemTemplate.GetItemFriendlyName()), eUIState_Header, 24);
	strDesc = ""; //Description and requirements strings are reversed for item cards, desc appears at the very bottom of the card so not needed here
	strRequirement = class'UIUtilities_Text'.static.GetColoredText(ItemTemplate.GetItemBriefSummary(ItemRef.ObjectID), eUIState_Normal, 24);

	if ( ItemRef.ObjectID > 0 ) {
		ItemState = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(ItemRef.ObjectID));

		UpgradeTemplates = ItemState.GetMyWeaponUpgradeTemplates();
		foreach UpgradeTemplates(UpgradeTemplate) {
			strRequirement = strRequirement $ "\n\n";
			strRequirement = strRequirement $ class'UIUtilities_Text'.static.GetColoredText(UpgradeTemplate.GetItemFriendlyNameNoStats(), eUIState_Header, 24);
			strRequirement = strRequirement $ "\n" $ UpgradeTemplate.GetItemBriefSummary();
		}
	}

	PopulateData(strTitle, strDesc, strRequirement, "");
	SetItemImages(ItemTemplate, ItemRef);
}