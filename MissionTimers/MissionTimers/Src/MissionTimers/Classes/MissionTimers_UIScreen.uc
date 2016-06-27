class MissionTimers_UIScreen extends UIScreen config(MissionTimers);

var config int Version;
var config int TURN_TIME;
var UISpecialMissionHUD SpecialHUD;

simulated function OnInit() {
	local X2EventManager  EventManager;
	local Object ThisObj;
	local XComGameState_TimerData	Timer;

	super.OnInit();

	EventManager = `XEVENTMGR;
	ThisObj = self;
	SpecialHUD = `PRES.GetSpecialMissionHUD();
	EventManager.RegisterForEvent(ThisObj, 'PlayerTurnBegun', PlayerTurnBegin, ELD_OnStateSubmitted);
	EventManager.RegisterForEvent(ThisObj, 'PlayerTurnEnded', PlayerTurnEnd, ELD_OnStateSubmitted);

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));
	if ( Timer == none ) {
		class'XComGameState_TimerData'.static.CreateRealtimeGameTimer(GetTurnTime(),,,,EGSTRT_PerTurn);
	}
	else {
		Timer.TotalPauseTime = 0.0;
		Timer.SetRealTimeTimer(GetTurnTime());
	}
	//UpdateTurnCounter();
}

function int GetTurnTime() {
	if ( class'MissionTimers_MCMListener'.default.TURN_TIME > 0 )
		return class'MissionTimers_MCMListener'.default.TURN_TIME;
	else
		return default.TURN_TIME;
}

simulated function OnRemoved() {
	local XComGameState_TimerData Timer;
	local XComGameState NewGameState;
	local Object ThisObj;

	super.OnRemoved();

	ThisObj = self;
	`XEVENTMGR.UnRegisterFromAllEvents(ThisObj);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Cleaning up timer");
	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));
	NewGameState.RemoveStateObject(Timer.ObjectID);

	`XCOMHISTORY.AddGameStateToHistory(NewGameState);
}

function EventListenerReturn PlayerTurnBegin(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	local XComGameState_TimerData Timer;

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));
	Timer.TotalPauseTime = 0.0;
	Timer.SetRealTimeTimer(GetTurnTime());
	//UpdateTurnCounter();
	return ELR_NoInterrupt;
}

function EventListenerReturn PlayerTurnEnd(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	local XComGameState_TimerData Timer;

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));
	Timer.TotalPauseTime = 0.0;
	Timer.SetRealTimeTimer(GetTurnTime());
	//UpdateTurnCounter();
	return ELR_NoInterrupt;
}

/*
function UpdateTurnCounter() {
	local XComGameStateHistory	History;
	local XComGameState_UITimer UiTimer;

	History = `XCOMHISTORY;
	UiTimer = XComGameState_UITimer(History.GetSingleGameStateObjectForClass(class 'XComGameState_UITimer', true));
	
	`LOG("GRIMY LOG - IS UI TIMER NONE? " $ UiTimer == none);
	`LOG("GRIMY LOG - SHOULD SHOW " $ UiTimer.ShouldShow);
	//SpecialHUD.m_kGenericTurnCounter.SetLabel(Label);
	if ( UiTimer != none && UiTimer.ShouldShow ) {
		//SpecialHUD.m_kGenericTurnCounter.SetSubLabel(SubLabel $ string(UiTimer.TimerValue));
		SpecialHUD.m_kTurnCounter2.SetUIState(UiTimer.UiState);
		SpecialHUD.m_kTurnCounter2.SetLabel(Label);
		SpecialHUD.m_kTurnCounter2.SetSubLabel(SubLabel);
		SpecialHUD.m_kTurnCounter2.SetCounter(string(UiTimer.TimerValue));
	}
}
*/

function Tick(float DeltaTime) {
	local XComGameState_TimerData	Timer;

	Super.Tick(DeltaTime);
	
	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));

	if ( Timer != none ) {
		if ( Timer.HasTimeExpired() ) {
			// && XGPlayer(`XCOMHISTORY.GetVisualizer(RuleSet.GetCachedUnitActionPlayerRef().ObjectID)).m_eTeam != eTeam_Alien
			XComTacticalController(PC).PerformEndTurn(ePlayerEndTurnType_PlayerInput);
		}

		if ( ( class'XComGameStateVisualizationMgr'.static.VisualizerBusy() && !`Pres.UIIsBusy() ) ) {
			Timer.bStopTime = true;
			Timer.AddPauseTime(DeltaTime);
		}
		else if (Timer.bStopTime) {
			Timer.bStopTime = false;
		}
	}
}