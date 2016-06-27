class LAByrinth_UIInventory_ListItem extends UIInventory_ListItem;

simulated function PopulateData(optional bool bRealizeDisabled)
{
	local string ItemQuantity; 
	
	if(Quantity > 0)
		ItemQuantity = GetColoredText(string(Quantity));
	else
		ItemQuantity = GetColoredText("-");

	MC.BeginFunctionOp("populateData");
	if(Screen.Class == class'UIInventory_BuildItems' && ItemTemplate.bPriority)
	{
		MC.QueueString(GetColoredText(ItemTemplate.GetItemFriendlyName(ItemRef.ObjectID) $ class'UIUtilities_Text'.default.m_strPriority));
	}
	else if( Screen.Class == class'LAByrinth_UIInventory_XComDatabase' )
	{
		MC.QueueString(XComDatabaseEntry.GetListTitle());
		ItemQuantity = "";
	}
	else if(!ClassIsChildOf(Screen.Class, class'UISimpleCommodityScreen'))
	{
		MC.QueueString(GetColoredText(ItemTemplate.GetItemFriendlyName(ItemRef.ObjectID)));
	}
	else
	{
		MC.QueueString(GetColoredText(ItemComodity.Title));
		ItemQuantity = GetColoredText("");
	}
	
	MC.QueueString(ItemQuantity);
	
	MC.EndOp();

	//---------------

	if(bRealizeDisabled)
		RealizeDisabledState();

	RealizeBadState();

	//Button.SetDisabled(bIsDisabled);
	//ConfirmButton.SetDisabled(bIsDisabled);
}