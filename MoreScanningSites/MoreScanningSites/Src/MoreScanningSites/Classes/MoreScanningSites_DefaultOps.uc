class MoreScanningSites_DefaultOps extends X2StrategyElement_DefaultRewards config(MoreScanningSites);

var config bool COUNTER_DARK_EVENTS;
var config float DURATION_MULT, SUPPLIES_REWARD_SCALAR, INTEL_REWARD_SCALAR, ALLOYSELERIUM_REWARD_SCALAR;
var config string FLAVOR_TEXT;
var config int DIFFICULTY_MOD;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>					Templates;

	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Supplies',GrimyOpReward_Supplies));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Intel',GrimyOpReward_Intel));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Alloys',GrimyOpReward_Alloys));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_AlloysElerium',GrimyOpReward_AlloysElerium));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Scientist',GrimyOpReward_Scientist));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Engineer',GrimyOpReward_Engineer));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Rookies',GrimyOpReward_Rookies));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_Soldier',GrimyOpReward_Soldier));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_AvengerPower',GrimyOpReward_AvengerPower));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_AvengerResComms',GrimyOpReward_AvengerResComms));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_IncreaseIncome',GrimyOpReward_IncreaseIncome));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_ReducedContact',GrimyOpReward_ReducedContact));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_LootTable',GrimyOpReward_LootTable));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_HeavyWeapon',GrimyOpReward_HeavyWeapon));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_GrenadeAmmo',GrimyOpReward_GrenadeAmmo));
	Templates.AddItem(GrimyCreateOpTemplate('GrimyOp_FacilityLead',GrimyOpReward_FacilityLead));

	return Templates;
}

delegate GiveRewardDelegate(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder=false, optional int OrderHours=-1);

static function X2DataTemplate GrimyCreateOpTemplate(name TemplateName, delegate <GiveRewardDelegate> RewardFn)
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, TemplateName);

	Template.GiveRewardFn = RewardFn;
	Template.GetRewardStringFn = GetMissionRewardString;

	return Template;
}

function GrimyOpReward_Supplies(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Supplies'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, default.SUPPLIES_REWARD_SCALAR, RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	//if ( class'X2StrategyGameRulesetDataStructures'.static.DifferenceInDays(class'XComGameState_GeoscapeEntity'.static.GetCurrentTime(), StartDate) > default.GUERILLA_OPS_DELAY ) {
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}

	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_Intel(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Intel'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, default.INTEL_REWARD_SCALAR , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}

	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_Alloys(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Alloys'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_AlloysElerium(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Alloys'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, default.ALLOYSELERIUM_REWARD_SCALAR, RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Elerium'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, default.ALLOYSELERIUM_REWARD_SCALAR, RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_Engineer(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Engineer'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_Scientist(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Scientist'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_Rookies(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local int NumInstances, i;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	NumInstances = `SYNC_RAND(3) + 2;
	for ( i=0; i<NumInstances; i++ ) {
		RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Rookie'));
		MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(MissionRewardState);
		MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
		MissionRewards.AddItem(MissionRewardState);
	}

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_Soldier(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Soldier'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_AvengerPower(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_AvengerPower'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_AvengerResComms(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_AvengerResComms'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_IncreaseIncome(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_IncreaseIncome'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_ReducedContact(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_ReducedContact'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_LootTable(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_LootTable'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_HeavyWeapon(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_HeavyWeapon'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_FacilityLead(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_FacilityLead'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}

function GrimyOpReward_GrenadeAmmo(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionSite MissionState, DarkEventMissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_DarkEvent DarkEventState;
	//local XComGameState_MissionCalendar CalendarState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> DarkEvents, PossibleDarkEvents;
	local array<int> OnMissionDarkEventIDs;
	local StateObjectReference DarkEventRef;
	local float MissionDuration;
	local TDateTime StartDate;
	//local array<name> ExcludeList;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	
	//CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Grenade'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);
	
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Ammo'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(MissionRewardState);
	MissionRewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	
	// Define the Start Date
	class'X2StrategyGameRulesetDataStructures'.static.SetTime(StartDate, 0, 0, 0, class'X2StrategyGameRulesetDataStructures'.default.START_MONTH, class'X2StrategyGameRulesetDataStructures'.default.START_DAY, class'X2StrategyGameRulesetDataStructures'.default.START_YEAR);
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_GuerillaOp'));
	
	MissionDuration = (default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * default.DURATION_MULT;
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);
	MissionState.FlavorText = default.FLAVOR_TEXT;
	if ( default.DIFFICULTY_MOD != 0 ) {
		MissionState.ManualDifficultySetting =  MissionSource.GetMissionDifficultyFn(MissionState) + default.DIFFICULTY_MOD;
		if ( MissionState.ManualDifficultySetting <= 0 ) {
			MissionState.ManualDifficultySetting = 1;
		}
	}
	
	if ( default.COUNTER_DARK_EVENTS ) {
		// Find out if there are any missions on the board which are paired with Dark Events
		foreach History.IterateByClassType(class'XComGameState_MissionSite', DarkEventMissionState)
		{
			if (DarkEventMissionState.DarkEvent.ObjectID != 0)
			{
				OnMissionDarkEventIDs.AddItem(DarkEventMissionState.DarkEvent.ObjectID);
			}
		}

		// See if there are any Dark Events left over after comparing the mission Dark Event list with the Alien HQ Chosen Events
		DarkEvents = AlienHQ.ChosenDarkEvents;
		foreach DarkEvents(DarkEventRef)
		{		
			if (OnMissionDarkEventIDs.Find(DarkEventRef.ObjectID) == INDEX_NONE)
			{
				PossibleDarkEvents.AddItem(DarkEventRef);
			}
		}

		// If there are Dark Events that this mission can counter, pick a random one and ensure it won't activate before the mission expires
		if (PossibleDarkEvents.Length > 0)
		{
			DarkEventRef = PossibleDarkEvents[`SYNC_RAND_STATIC(PossibleDarkEvents.Length)];		
			DarkEventState = XComGameState_DarkEvent(History.GetGameStateForObjectID(DarkEventRef.ObjectID));
			if (DarkEventState.TimeRemaining < MissionDuration)
			{
				DarkEventState = XComGameState_DarkEvent(NewGameState.CreateStateObject(class'XComGameState_DarkEvent', DarkEventState.ObjectID));
				NewGameState.AddStateObject(DarkEventState);
				DarkEventState.ExtendActivationTimer(default.MissionMaxDuration);
			}

			MissionState.DarkEvent = DarkEventRef;
		}
	}

	RewardState.RewardObjectReference = MissionState.GetReference();
}
