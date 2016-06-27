class GrimyLootPCS_Listener_LootRecovered extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local UIInventory_LootRecovered MyScreen;
	local UIInventory_ListItem ListItem;
	local int i;

	MyScreen = UIInventory_LootRecovered(Screen);

	MyScreen.ItemCard.Remove();
	MyScreen.ItemCard = MyScreen.Spawn(class'GrimyLootPCS_UIItemCard',MyScreen.ListContainer).InitItemCard('ItemCard');
	
	if(MyScreen.List.ItemCount > 0)
	{
		i = 0;
		while(i < MyScreen.List.ItemCount)
		{
			ListItem = UIInventory_ListItem(MyScreen.List.GetItem(i++));
			if(ListItem != none)
			{
				MyScreen.List.SetSelectedItem(ListItem);
				MyScreen.PopulateItemCard(ListItem.ItemTemplate, ListItem.ItemRef);
				break;
			}
		}
	}

	if ( MyScreen.List.ItemCount == 0 ) {
		MyScreen.SetCategory(MyScreen.m_strNoLoot);
	}
}

defaultproperties
{
	ScreenClass=class'UIInventory_LootRecovered'
}