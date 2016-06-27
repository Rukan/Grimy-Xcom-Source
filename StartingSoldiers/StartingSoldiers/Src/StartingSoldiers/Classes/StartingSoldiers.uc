class StartingSoldiers extends XComGameState_HeadquartersXCom config(StartingSoldiers);

struct StartingSoldierData {
	var string SoldierName;
	var name SoldierClass;
	var int SoldierRank;
};

var config array<StartingSoldierData> CHARACTER_INFO;

static function CreateStartingSoldiers(XComGameState StartState, optional bool bTutorialEnabled = false)
{
	local XComGameState_Unit NewSoldierState;	
	local XComGameState_HeadquartersXCom XComHQ;
	local XGCharacterGenerator CharacterGenerator;
	local TSoldier TutSoldier;
	local int Index, i;
	local XComGameState_GameTime GameTime;
	local XComGameState_Analytics Analytics;
	local TAppearance TutSoldierAppearance;
	local TDateTime TutKIADate;
	local StateObjectReference EmptyRef;
	local X2MissionSourceTemplate MissionSource;
	local XComOnlineProfileSettings ProfileSettings;

	assert(StartState != none);

	foreach StartState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	foreach StartState.IterateByClassType(class'XComGameState_GameTime', GameTime)
	{
		break;
	}
	`assert( GameTime != none );

	foreach StartState.IterateByClassType( class'XComGameState_Analytics', Analytics )
	{
		break;
	}
	`assert( Analytics != none );

	ProfileSettings = `XPROFILESETTINGS;

	// Starting soldiers
	for( Index = 0; Index < class'XGTacticalGameCore'.default.NUM_STARTING_SOLDIERS; ++Index )
	{
		if ( Index < default.CHARACTER_INFO.length && default.CHARACTER_INFO[Index].SoldierName != "" ) {
			NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(StartState, ProfileSettings.Data.m_eCharPoolUsage,,,default.CHARACTER_INFO[Index].SoldierName);
		} 
		else {
			NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(StartState, ProfileSettings.Data.m_eCharPoolUsage);
		}

		CharacterGenerator = `XCOMGRI.Spawn(NewSoldierState.GetMyTemplate().CharacterGeneratorClass);
		`assert(CharacterGenerator != none);

		if(bTutorialEnabled && Index == 0)
		{
			TutSoldier = CharacterGenerator.CreateTSoldier('Soldier', default.TutorialSoldierGender, default.TutorialSoldierCountry);
			TutSoldierAppearance = default.TutorialSoldierAppearance;

			if(GetLanguage() == "FRA")
			{
				TutSoldierAppearance.nmVoice = default.TutorialSoldierFrenchVoice;
			}
			else if(GetLanguage() == "DEU")
			{
				TutSoldierAppearance.nmVoice = default.TutorialSoldierGermanVoice;
			}
			else if(GetLanguage() == "ITA")
			{
				TutSoldierAppearance.nmVoice = default.TutorialSoldierItalianVoice;
			}
			else if(GetLanguage() == "ESN")
			{
				TutSoldierAppearance.nmVoice = default.TutorialSoldierSpanishVoice;
			}
			else
			{
				TutSoldierAppearance.nmVoice = default.TutorialSoldierEnglishVoice;
			}

			NewSoldierState.SetTAppearance(TutSoldierAppearance);
			NewSoldierState.SetCharacterName(class'XLocalizedData'.default.TutorialSoldierFirstName, class'XLocalizedData'.default.TutorialSoldierLastName, TutSoldier.strNickName);
			NewSoldierState.SetCountry(TutSoldier.nmCountry);
			NewSoldierState.SetXPForRank(1);
			NewSoldierState.GenerateBackground();
			NewSoldierState.StartingRank = 1;
			NewSoldierState.iNumMissions = 1;
			XComHQ.TutorialSoldier = NewSoldierState.GetReference();
		}
		
		NewSoldierState.RandomizeStats();
		NewSoldierState.ApplyInventoryLoadout(StartState);

		NewSoldierState.SetHQLocation(eSoldierLoc_Barracks);

		XComHQ.AddToCrew(StartState, NewSoldierState);
		NewSoldierState.m_RecruitDate = GameTime.CurrentTime; // AddToCrew does this, but during start state creation the StrategyRuleset hasn't been created yet

		if(XComHQ.Squad.Length < class'X2StrategyGameRulesetDataStructures'.static.GetMaxSoldiersAllowedOnMission())
		{
			// Start of Grimy Changes
			if ( Index < default.CHARACTER_INFO.length ) {
				if ( default.CHARACTER_INFO[Index].SoldierRank > 0 ) {
					NewSoldierState.RankUpSoldier(StartState, default.CHARACTER_INFO[Index].SoldierClass);
					NewSoldierState.ApplySquaddieLoadout(StartState);
					for(i = 0; i < NewSoldierState.GetSoldierClassTemplate().GetAbilityTree(0).Length; ++i)
					{
						NewSoldierState.BuySoldierProgressionAbility(StartState, 0, i);
					}
					for ( i=1; i < default.CHARACTER_INFO[Index].SoldierRank; i++ ) {
						NewSoldierState.RankUpSoldier(StartState);
					}
				}
			}
			// End of Grimy Changes
			XComHQ.Squad.AddItem(NewSoldierState.GetReference());
		}

		StartState.AddStateObject( NewSoldierState );
	}

	// Dead tutorial soldiers

	if(bTutorialEnabled)
	{
		class'X2StrategyGameRulesetDataStructures'.static.SetTime(TutKIADate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH,
			class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);

		MissionSource = X2MissionSourceTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate('MissionSource_Start'));

		// Osei
		NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(StartState, ProfileSettings.Data.m_eCharPoolUsage);
		TutSoldier = CharacterGenerator.CreateTSoldier('Soldier', default.DeadTutorialSoldier1Gender, default.DeadTutorialSoldier1Country);
		NewSoldierState.SetTAppearance(default.DeadTutorialSoldier1Appearance);
		NewSoldierState.SetCharacterName(class'XLocalizedData'.default.DeadTutorialSoldier1FirstName, class'XLocalizedData'.default.DeadTutorialSoldier1LastName, TutSoldier.strNickName);
		NewSoldierState.SetCountry(TutSoldier.nmCountry);
		NewSoldierState.SetXPForRank(1);
		NewSoldierState.StartingRank = 1;
		NewSoldierState.iNumMissions = 1;
		NewSoldierState.RandomizeStats();
		NewSoldierState.ApplyInventoryLoadout(StartState);
		NewSoldierState.SetHQLocation(eSoldierLoc_Barracks);
		NewSoldierState.SetCurrentStat(eStat_HP, 0.0f);
		NewSoldierState.m_KIADate = TutKIADate;
		NewSoldierState.m_strKIAOp = MissionSource.BattleOpName;
		NewSoldierState.m_strCauseOfDeath = default.DeadTutorialSoldier1CauseOfDeath;
		NewSoldierState.m_strEpitaph = default.DeadTutorialSoldier1Epitaph;

		for(i = 0; i < default.DeadTutorialSoldier1NumKills; i++)
		{
			NewSoldierState.SimGetKill(EmptyRef);
		}

		StartState.AddStateObject(NewSoldierState);
		XComHQ.DeadCrew.AddItem(NewSoldierState.GetReference());

		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_SERVICE_HOURS, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNITS_HEALED_HOURS, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_ATTACKS, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_DEALT_DAMAGE, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_ABILITIES_RECIEVED, 0, NewSoldierState.GetReference( ) );

		// Ramirez
		NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(StartState, ProfileSettings.Data.m_eCharPoolUsage);
		TutSoldier = CharacterGenerator.CreateTSoldier('Soldier', default.DeadTutorialSoldier2Gender, default.DeadTutorialSoldier2Country);
		NewSoldierState.SetTAppearance(default.DeadTutorialSoldier2Appearance);
		NewSoldierState.SetCharacterName(class'XLocalizedData'.default.DeadTutorialSoldier2FirstName, class'XLocalizedData'.default.DeadTutorialSoldier2LastName, TutSoldier.strNickName);
		NewSoldierState.SetCountry(TutSoldier.nmCountry);
		NewSoldierState.SetXPForRank(1);
		NewSoldierState.StartingRank = 1;
		NewSoldierState.iNumMissions = 1;
		NewSoldierState.RandomizeStats();
		NewSoldierState.ApplyInventoryLoadout(StartState);
		NewSoldierState.SetHQLocation(eSoldierLoc_Barracks);
		NewSoldierState.SetCurrentStat(eStat_HP, 0.0f);
		NewSoldierState.m_KIADate = TutKIADate;
		NewSoldierState.m_strKIAOp = MissionSource.BattleOpName;
		NewSoldierState.m_strCauseOfDeath = default.DeadTutorialSoldier2CauseOfDeath;
		NewSoldierState.m_strEpitaph = default.DeadTutorialSoldier2Epitaph;

		for(i = 0; i < default.DeadTutorialSoldier2NumKills; i++)
		{
			NewSoldierState.SimGetKill(EmptyRef);
		}

		StartState.AddStateObject(NewSoldierState);
		XComHQ.DeadCrew.AddItem(NewSoldierState.GetReference());

		// Ramirez Bar Memorial Data
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_SERVICE_HOURS, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNITS_HEALED_HOURS, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_ATTACKS, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_DEALT_DAMAGE, 0, NewSoldierState.GetReference( ) );
		Analytics.AddValue( class'XComGameState_Analytics'.const.ANALYTICS_UNIT_ABILITIES_RECIEVED, 0, NewSoldierState.GetReference( ) );
	}
}