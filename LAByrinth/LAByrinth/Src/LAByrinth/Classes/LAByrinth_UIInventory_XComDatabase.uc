class LAByrinth_UIInventory_XComDatabase extends UIInventory_XComDatabase config(LAByrinth);

struct TagData
{
	var string TagPath;
	var string TogPath;
	var string Tooltip;
	var name TemplateName;
	var int PosX;
	var int PosY;
};

var UIImage Connectors;
var array<UIImage> Tags;

var config int ConnectorSizeX, ConnectorSizeY, ConnectorPosX, ConnectorPosY, TagSize;
var config array<TagData> TagList;

simulated function PopulateData()
{
	local X2EncyclopediaTemplateManager EncyclopediaTemplateMgr;
	local X2DataTemplate Iter;
	local X2EncyclopediaTemplate CurrentHeader, CurrentEntry;
	local UIInventory_HeaderListItem HeaderItem;
	local array<X2EncyclopediaTemplate> HeaderTemplates, EntryTemplates, CategoryTemplates;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	EncyclopediaTemplateMgr = class'X2EncyclopediaTemplateManager'.static.GetEncyclopediaTemplateManager();

	foreach EncyclopediaTemplateMgr.IterateTemplates(Iter, None)
	{
		CurrentEntry = X2EncyclopediaTemplate(Iter);

		if(XComHQ.MeetsAllStrategyRequirements(CurrentEntry.Requirements))
		{
			if(CurrentEntry.bCategoryHeader)
			{
				HeaderTemplates.AddItem(CurrentEntry);
			}
			else
			{
				EntryTemplates.AddItem(CurrentEntry);
			}
		}
	}

	HeaderTemplates.Sort(SortEncyclopedia);

	foreach HeaderTemplates(CurrentHeader)
	{
		HeaderItem = Spawn(class'UIInventory_HeaderListItem', List.ItemContainer);
		HeaderItem.bIsNavigable = false;
		HeaderItem.InitHeaderItem( "", CurrentHeader.GetListTitle());

		foreach EntryTemplates(CurrentEntry)
		{
			if( CurrentEntry.ListCategory == CurrentHeader.ListCategory )
			{
				CategoryTemplates.AddItem(CurrentEntry);
			}
		}

		CategoryTemplates.Sort(SortEncyclopedia);

		foreach CategoryTemplates(CurrentEntry)
		{
			Spawn(class'LAByrinth_UIInventory_ListItem', List.ItemContainer).InitInventoryListXComDatabase(CurrentEntry);
		}

		CategoryTemplates.Remove(0, CategoryTemplates.Length);
	}

	SetCategory("");

	if(List.ItemCount > 0)
	{
		List.SetSelectedIndex(0);
		PopulateXComDatabaseCard(EntryTemplates[0]);
	}
}

simulated function SelectedItemChanged(UIList ContainerList, int ItemIndex)
{
	local LAByrinth_UIInventory_ListItem ListItem;
	ListItem = LAByrinth_UIInventory_ListItem(ContainerList.GetItem(ItemIndex));
	if( ListItem != none )
	{
		PopulateXComDatabaseCard(ListItem.XComDatabaseEntry);
	}
}

simulated function PopulateXComDatabaseCard(X2EncyclopediaTemplate EncyclopediaEntry)
{
	if ( EncyclopediaEntry.DataName == 'LAByrinth' )
		ShowGraph();
	else
		HideGraph();

	ItemCard.PopulateXComDatabaseCard(EncyclopediaEntry);
	ItemCard.Show();
}

simulated function ShowGraph() {
	local TagData TagIndex;
	local UIImage kTag;
	local int Index;

	if ( Connectors == none ) {
		Connectors = Spawn(class'UIImage', self).InitImage('LAByrinthConnectors',"img:///LAByrinthConnectorPackage.LAByrinthConnectors");
		Connectors.bAnimateOnInit = false;
		Connectors.SetSize(default.ConnectorSizeX, default.ConnectorSizeY);
		Connectors.SetPosition(default.ConnectorPosX,default.ConnectorPosY);
	}
	Connectors.Show();

	if ( Tags.Length == 0 ) {
		Index = 0;
		foreach default.TagList(TagIndex) {
			kTag = Spawn(class'UIImage', self).InitImage(name("LAByrinthTag" $ (Index++)), TagIndex.TagPath);
			kTag.bAnimateOnInit = false;
			kTag.SetSize(default.TagSize, default.TagSize);
			kTag.SetPosition(TagIndex.PosX, TagIndex.PosY);
			Tags.AddItem(kTag);
		}
	}
	foreach Tags(kTag) {
		kTag.Show();
	}
}

simulated function HideGraph() {
	local UIImage kTag;

	Connectors.Hide();
	foreach Tags(kTag) {
		kTag.Hide();
	}
}

