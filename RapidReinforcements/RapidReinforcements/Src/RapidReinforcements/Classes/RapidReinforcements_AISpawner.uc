class RapidReinforcements_AISpawner extends XComGameState_AIReinforcementSpawner;

function EventListenerReturn OnReinforcementSpawnerCreated(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState NewGameState;
	local XComGameState_AIReinforcementSpawner NewSpawnerState;
	local X2EventManager EventManager;
	local Object ThisObj;
	local X2CharacterTemplate SelectedTemplate;
	local XComGameState_Player PlayerState;
	local XComGameState_BattleData BattleData;
	local XComGameState_MissionSite MissionSiteState;
	local XComAISpawnManager SpawnManager;
	local int AlertLevel, ForceLevel;
	local XComGameStateHistory History;
	local Name CharTemplateName;
	local X2CharacterTemplateManager CharTemplateManager;

	CharTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	SpawnManager = `SPAWNMGR;
	History = `XCOMHISTORY;

	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));

	ForceLevel = BattleData.GetForceLevel();
	AlertLevel = BattleData.GetAlertLevel();

	if( BattleData.m_iMissionID > 0 )
	{
		MissionSiteState = XComGameState_MissionSite(History.GetGameStateForObjectID(BattleData.m_iMissionID));

		if( MissionSiteState != None && MissionSiteState.SelectedMissionData.SelectedMissionScheduleName != '' )
		{
			AlertLevel = MissionSiteState.SelectedMissionData.AlertLevel;
			ForceLevel = MissionSiteState.SelectedMissionData.ForceLevel;
		}
	}

	// Select the spawning visualization mechanism and build the persistent in-world visualization for this spawner
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState(string(GetFuncName()));
	XComGameStateContext_ChangeContainer(NewGameState.GetContext()).BuildVisualizationFn = BuildVisualizationForSpawnerCreation;

	NewSpawnerState = XComGameState_AIReinforcementSpawner(NewGameState.CreateStateObject(class'XComGameState_AIReinforcementSpawner', ObjectID));

	// choose reinforcement spawn location

	// build a character selection that will work at this location
	SpawnManager.SelectPodAtLocation(NewSpawnerState.SpawnInfo, ForceLevel, AlertLevel);

	// explicitly disabled all timed loot from reinforcement groups
	NewSpawnerState.SpawnInfo.bGroupDoesNotAwardLoot = true;

	// determine if the spawning mechanism will be via ATT or PsiGate
	//  A) ATT requires open sky above the reinforcement location
	//  B) ATT requires that none of the selected units are oversized (and thus don't make sense to be spawning from ATT)
	NewSpawnerState.UsingPsiGates = NewSpawnerState.SpawnInfo.bForceSpawnViaPsiGate || !DoesLocationSupportATT(NewSpawnerState.SpawnInfo.SpawnLocation);

	if( !NewSpawnerState.UsingPsiGates )
	{
		// determine if we are going to be using psi gates or the ATT based on if the selected templates support it
		foreach NewSpawnerState.SpawnInfo.SelectedCharacterTemplateNames(CharTemplateName)
		{
			SelectedTemplate = CharTemplateManager.FindCharacterTemplate(CharTemplateName);

			if( !SelectedTemplate.bAllowSpawnFromATT )
			{
				NewSpawnerState.UsingPsiGates = true;
				break;
			}
		}
	}

	NewGameState.AddStateObject(NewSpawnerState);

	`TACTICALRULES.SubmitGameState(NewGameState);


	// no countdown specified, spawn reinforcements immediately
	if( Countdown <= 0 )
	{
		NewSpawnerState.SpawnReinforcements();
	}
	// countdown is active, need to listen for AI Turn Begun in order to tick down the countdown
	else
	{
		EventManager = `XEVENTMGR;
		ThisObj = self;

		//PlayerState = `BATTLE.GetAIPlayerState();
		foreach History.IterateByClassType(class'XComGameState_Player', PlayerState)
		{
			if( PlayerState.GetTeam() == eTeam_XCom )
			{
				EventManager.RegisterForEvent(ThisObj, 'PlayerTurnEnded', OnTurnBegun, ELD_OnStateSubmitted, , PlayerState);
				break;
			}
		}
	}

	return ELR_NoInterrupt;
}

function bool DoesLocationSupportATT(Vector TargetLocation)
{
	local TTile TargetLocationTile;
	local TTile AirCheckTile;
	local VoxelRaytraceCheckResult CheckResult;
	local XComWorldData WorldData;

	WorldData = `XWORLD;

		TargetLocationTile = WorldData.GetTileCoordinatesFromPosition(TargetLocation);
	AirCheckTile = TargetLocationTile;
	AirCheckTile.Z = WorldData.NumZ - 1;

	// the space is free if the raytrace hits nothing
	return (WorldData.VoxelRaytrace_Tiles(TargetLocationTile, AirCheckTile, CheckResult) == false);
}
