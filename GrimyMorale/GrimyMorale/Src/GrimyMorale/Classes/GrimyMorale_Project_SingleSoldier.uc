class GrimyMorale_Project_SingleSoldier extends XComGameState_HeadquartersProject config(GrimyMorale);

var config int POINTS_PER_BLOCK;
var config int MORALE_RATE;

var int PointsPerBlock;
var TDateTime TrueStart; // An unmodified start time that won't change based on pausing or starts & stops.  Used for analytics computations

//---------------------------------------------------------------------------------------
// Call when you start a new project, NewGameState should be none if not coming from tactical
function SetProjectFocus(StateObjectReference FocusRef, optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;
	local XComGameState_GameTime TimeState;

	History = `XCOMHISTORY;
	ProjectFocus = FocusRef;
	bIncremental = true;

	if(NewGameState != none)
	{
		UnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ProjectFocus.ObjectID));
	}
	else
	{
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(ProjectFocus.ObjectID));
	}
	
	BlocksRemaining = UnitState.GetBaseStat(eStat_Will) - UnitState.GetCurrentStat(eStat_Will);
	PointsPerBlock = default.POINTS_PER_BLOCK;

	// Get rid of possible differences caused by rounding
	BlockPointsRemaining = PointsPerBlock;
	ProjectPointsRemaining = PointsPerBlock * BlocksRemaining;
	InitialProjectPoints = ProjectPointsRemaining;

	UpdateWorkPerHour(NewGameState);
	TimeState = XComGameState_GameTime(History.GetSingleGameStateObjectForClass(class'XComGameState_GameTime'));
	StartDateTime = TimeState.CurrentTime;

	if (TrueStart.m_fTime == 0.0f)
	{
		TrueStart = StartDateTime;
	}

	if(`STRATEGYRULES != none)
	{
		if(class'X2StrategyGameRulesetDataStructures'.static.LessThan(TimeState.CurrentTime, `STRATEGYRULES.GameTime))
		{
			StartDateTime = `STRATEGYRULES.GameTime;
		}
	}
	
	if(MakingProgress())
	{
		SetProjectedCompletionDateTime(StartDateTime);
	}
	else
	{
		// Set completion time to unreachable future
		CompletionDateTime.m_iYear = 9999;
		BlockCompletionDateTime.m_iYear = 9999;
	}
}

//---------------------------------------------------------------------------------------
function int CalculateWorkPerHour(optional XComGameState StartState = none, optional bool bAssumeActive = false)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	return max(XComHQ.HealingRate, XComHQ.XComHeadquarters_BaseHealRate);
}

//---------------------------------------------------------------------------------------
// Heal the unit by one block, and check if the healing is complete
function OnBlockCompleted()
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;
	local GrimyMorale_Project_SingleSoldier HealProject;

	History = `XCOMHISTORY;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Unit Morale - 1 Block");
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(ProjectFocus.ObjectID));

	if(UnitState != none)
	{
		UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
		UnitState.SetCurrentStat(eStat_Will, UnitState.GetCurrentStat(eStat_Will) + 1);
		NewGameState.AddStateObject(UnitState);

		HealProject = GrimyMorale_Project_SingleSoldier(NewGameState.CreateStateObject(class' GrimyMorale_Project_SingleSoldier', self.ObjectID));
		NewGameState.AddStateObject(HealProject);

		HealProject.BlocksRemaining = UnitState.GetBaseStat(eStat_Will) - UnitState.GetCurrentStat(eStat_Will);

		if(HealProject.BlocksRemaining > 0)
		{
			HealProject.BlockPointsRemaining = HealProject.PointsPerBlock;
			HealProject.ProjectPointsRemaining = HealProject.BlocksRemaining * HealProject.BlockPointsRemaining;
			HealProject.UpdateWorkPerHour();
			HealProject.StartDateTime = `STRATEGYRULES.GameTime;

			if(HealProject.MakingProgress())
			{
				HealProject.SetProjectedCompletionDateTime(HealProject.StartDateTime);
			}
			else
			{
				// Set completion time to unreachable future
				HealProject.CompletionDateTime.m_iYear = 9999;
				HealProject.BlockCompletionDateTime.m_iYear = 9999;
			}
		}

		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

//---------------------------------------------------------------------------------------
// Remove the project and the engineer from the room's repair slot
function OnProjectCompleted()
{
	//local HeadquartersOrderInputContext OrderInput;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState; 
	local XComHeadquartersCheatManager CheatMgr;
		
	History = `XCOMHISTORY;
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(ProjectFocus.ObjectID));

	CheatMgr = XComHeadquartersCheatManager(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController().CheatManager);
	if (CheatMgr == none || !CheatMgr.bGamesComDemo)
	{
		`HQPRES.Notify(Repl(ProjectCompleteNotification, "%UNIT", UnitState.GetName(eNameType_RankFull)), class'UIUtilities_Image'.const.EventQueue_Staff);
	}
}

//---------------------------------------------------------------------------------------
DefaultProperties
{
}
