class X2DownloadableContentInfo_UtilitySlotSidearm extends X2DownloadableContentInfo;

exec function UpdateUtilitySlotSidearms() {
	AddItemTemplates();
}

static function AddItemTemplates() {
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
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Utility Slot Sidearms");

	//Get the previous XCom HQ state - we'll need it's ID to create a new state for it
	OldXComHQState = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	//Make the new XCom HQ state. This starts out as just a copy of the previous state.
	NewXComHQState = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', OldXComHQState.ObjectID));
	
	if ( class'UtilitySlotSidearms'.default.bEnablePistols ) {
		ItemTemplate = ItemMgr.FindItemTemplate('PairedPistol_CV');
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(ItemState);
		NewXComHQState.AddItemToHQInventory(ItemState);

		if ( NewXComHQState.HasItemByName('Pistol_MG') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedPistol_MG');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}

		if ( NewXComHQState.HasItemByName('Pistol_BM') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedPistol_BM');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}
	}

	if ( class'UtilitySlotSidearms'.default.bEnableSwords ) {
		ItemTemplate = ItemMgr.FindItemTemplate('PairedSword_CV');
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(ItemState);
		NewXComHQState.AddItemToHQInventory(ItemState);

		if ( NewXComHQState.HasItemByName('Sword_MG') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedSword_MG');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}

		if ( NewXComHQState.HasItemByName('Sword_BM') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedSword_BM');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}
	}

	if ( class'UtilitySlotSidearms'.default.bEnableGremlins ) {
		ItemTemplate = ItemMgr.FindItemTemplate('PairedGremlin_CV');
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(ItemState);
		NewXComHQState.AddItemToHQInventory(ItemState);

		if ( NewXComHQState.HasItemByName('Gremlin_MG') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedGremlin_MG');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}

		if ( NewXComHQState.HasItemByName('Gremlin_BM') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedGremlin_BM');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}
	}

	if ( class'UtilitySlotSidearms'.default.bEnablePsiAmps ) {
		ItemTemplate = ItemMgr.FindItemTemplate('PairedPsiAmp_CV');
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(ItemState);
		NewXComHQState.AddItemToHQInventory(ItemState);

		if ( NewXComHQState.HasItemByName('PsiAmp_MG') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedPsiAmp_MG');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}

		if ( NewXComHQState.HasItemByName('PsiAmp_BM') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedPsiAmp_BM');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}
	}

	if ( class'UtilitySlotSidearms_GrenadeLauncher'.default.bEnableGrenadeLaunchers ) {
		ItemTemplate = ItemMgr.FindItemTemplate('PairedGrenadeLauncher_CV');
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(ItemState);
		NewXComHQState.AddItemToHQInventory(ItemState);

		if ( NewXComHQState.HasItemByName('GrenadeLauncher_MG') ) {
			ItemTemplate = ItemMgr.FindItemTemplate('PairedGrenadeLauncher_MG');
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(ItemState);
			NewXComHQState.AddItemToHQInventory(ItemState);
		}
	}

	//Commit the new HQ state object to the state change that we built
	NewGameState.AddStateObject(NewXComHQState);

	//Commit the state change into the history.
	History.AddGameStateToHistory(NewGameState);
}