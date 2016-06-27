class GrimyLootPCS_Listener_ItemCard extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local UIInventory_Implants MyScreen;
	MyScreen = UIInventory_Implants(Screen);

	MyScreen.ItemCard.Remove();
	MyScreen.ItemCard = MyScreen.Spawn(class'GrimyLootPCS_UIItemCard',MyScreen.ListContainer).InitItemCard('ItemCard');
	
	MyScreen.ItemCard.SetPosition(1200, 0);
	MyScreen.SetInventoryLayout();
	MyScreen.PopulateData();
}

defaultproperties
{
	ScreenClass=class'UIInventory_Implants'
}