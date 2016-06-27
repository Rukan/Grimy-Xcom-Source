class GrimyLoot_ScreenListener_UIInventory_Storage extends UIScreenListener;

var UIInventory_Storage MyScreen;
var UIButton Choice;
var bool bShowEncyclopedia;

var localized string kToggle, kCompletion;

event OnInit(UIScreen Screen)
{
	bShowEncyclopedia = true;

	MyScreen = UIInventory_Storage(Screen);
	
	Choice = MyScreen.Spawn(class'UIButton', MyScreen);
	Choice.bAnimateOnInit = false;
	Choice.SetResizeToText(false);
	Choice.InitButton('Choice', "Toggle Encyclopedia", ShowLootEncyclopedia);
	Choice.AnchorCenter();
	Choice.SetStyle(eUIButtonStyle_BUTTON_WHEN_MOUSE);
	Choice.SetFontSize(20);
	Choice.SetHeight(25);
	Choice.SetWidth(340);
	Choice.SetX(-190);
	Choice.SetY(-350);
}

event OnRemoved(UIScreen Screen) {
	Choice.Remove();
	Choice = none;
	MyScreen = none;
}

function ShowLootEncyclopedia(UIButton button) {
	local X2ItemTemplateManager				ItemManager;
	local array<X2WeaponUpgradeTemplate>	UpgradeTemplates;
	local X2WeaponUpgradeTemplate			UpgradeTemplate;
	local int								Found, Total;

	if ( MyScreen == none ) { return; }
	
	if ( bShowEncyclopedia ) {
		bShowEncyclopedia = false;
	
		MyScreen.List.ClearItems();
		MyScreen.PopulateItemCard();

		if( MyScreen.List.ItemCount == 0 && MyScreen.m_strEmptyListTitle  != "" )
		{
			MyScreen.TitleHeader.SetText(MyScreen.m_strTitle, MyScreen.m_strEmptyListTitle);
			MyScreen.SetCategory("");
		}

		ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
		UpgradeTemplates = ItemManager.GetAllUpgradeTemplates();
		Found = 0;
		Total = UpgradeTemplates.length;
		
		foreach UpgradeTemplates(UpgradeTemplate) {
			if ( class'GrimyLoot_Screenlistener_MCM'.default.FoundUpgrades.Find(UpgradeTemplate.DataName) != INDEX_NONE ) {
				MyScreen.Spawn(class'UIInventory_ListItem', MyScreen.List.itemContainer).InitInventoryListItem(UpgradeTemplate, 0);
				Found++;
			}
		}

		Choice.SetText(default.kToggle $ Found $ " / " $ Total $ kCompletion);
	
		MyScreen.TitleHeader.SetText(MyScreen.m_strTitle, "");
		MyScreen.PopulateItemCard(UpgradeTemplates[0]);

		MyScreen.List.SetSelectedIndex(0, true);
	}
	else {
		bShowEncyclopedia = true;
		MyScreen.PopulateData();
		MyScreen.List.SetSelectedIndex(0, true);
	}
}

defaultproperties
{
	ScreenClass=class'UIInventory_Storage'
}