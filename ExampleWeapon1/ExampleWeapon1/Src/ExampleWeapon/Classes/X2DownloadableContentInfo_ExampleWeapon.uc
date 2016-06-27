//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_ExampleWeapon.uc
//  AUTHOR:  Ryan McFall
//           
//	Demonstrates how to use the X2DownloadableContentInfo class to specify unique mod
//  behavior when the player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_ExampleWeapon extends X2DownloadableContentInfo;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom OldXComHQState;	
	local XComGameState_HeadquartersXCom NewXComHQState;
	local XComGameState_Item ItemState;
	local X2ItemTemplateManager ItemMgr;
	local X2ItemTemplate ItemTemplate;

	//In this method, we demonstrate functionality that will add ExampleWeapon to the player's inventory when loading a saved
	//game. This allows players to enjoy the content of the mod in campaigns that were started without the mod installed.
	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	History = `XCOMHISTORY;	

	//Create a pending game state change
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding ExampleWeapon Objects");

	//Get the previous XCom HQ state - we'll need it's ID to create a new state for it
	OldXComHQState = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	//Make the new XCom HQ state. This starts out as just a copy of the previous state.
	NewXComHQState = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', OldXComHQState.ObjectID));
	
	//Make the changes to the HQ state. Here we add items to the HQ's inventory
	ItemTemplate = ItemMgr.FindItemTemplate('ModWeapon_CV');
		
	//Instantiate a new item state object using the template.
	ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(ItemState);

	//Add the newly created item to the HQ inventory
	NewXComHQState.AddItemToHQInventory(ItemState);	

	//Commit the new HQ state object to the state change that we built
	NewGameState.AddStateObject(NewXComHQState);

	//Commit the state change into the history.
	History.AddGameStateToHistory(NewGameState);
}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{
	//Don't need to do anything - the weapon should be picked up and placed into the HQ inventory when starting a new campaign.
}