class LoadedSaveTweak extends XComOnlineEventMgr;

private event PreloadSaveGameData(byte LocalUserNum, bool Success, int GameNum, int SaveID)
{
	local XComGameState_Unit Unit;
	local XComGameStateHistory History;
	local XComOnlineEventMgr EventManager;
	local array<X2DownloadableContentInfo> DLCInfos;
	local XComGameState_CampaignSettings Settings;
	local int i;
	local bool bAnySuperSoldiers;
	local name DLCName;

	if(Success)
	{
		//Disable achievements if a super soldier is being used
		History = `XCOMHISTORY;
		foreach History.IterateByClassType(class'XComGameState_Unit', Unit)
		{
			if(Unit.bIsSuperSoldier)
			{
				bAnySuperSoldiers = true;
				break;				
			}
		}

		if(bAnySuperSoldiers)
		{
			EnableAchievements(false, true);
		}
		else
		{
			EnableAchievements(true, false);
		}

		//Fills out the 'RequestedArchetypes' array in the content manager by iterating the state objects in the recently loaded history
		`CONTENT.RequestContent();

		//Check to see if we have campaign settings. If so, see if we have DLCs that have been newly added that should process - and if so
		//add them to our list of required DLC
		Settings = XComGameState_CampaignSettings(History.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings', true));
		if(Settings != none)
		{	
			EventManager = `ONLINEEVENTMGR;
			
			// Let the DLC / Mods hook the creation of a new campaign
			// GRIMY CHANGE, Switch GetDLCInfos from true to false
			DLCInfos = EventManager.GetDLCInfos(false);
			for(i = 0; i < DLCInfos.Length; ++i)
			{
				`LOG("GRIMY LOG - UPDATING DLCInfos");
				if ( DLCInfos[i].DLCIdentifier != "XCom_DLC_Day0" && DLCInfos[i].DLCIdentifier != "DLC_1" && DLCInfos[i].DLCIdentifier != "DLC_2") {
					DLCInfos[i].OnLoadedSavedGame();
				}
			}

			// Add new DLCs to the list of required DLCs. Directly writing to the state object outside of a game state change is 
			// unorthodox, but works for this situation
			for(i = 0; i < EventManager.GetNumDLC(); ++i)
			{
				DLCName = EventManager.GetDLCNames(i);					
				if(Settings.RequiredDLC.Find(DLCName) == -1)
				{
					Settings.AddRequiredDLC(DLCName);
				}
			}			
		}
	}
}