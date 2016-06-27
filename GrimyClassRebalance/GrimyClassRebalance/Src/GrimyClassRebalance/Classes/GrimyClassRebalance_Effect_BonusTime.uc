class GrimyClassRebalance_Effect_BonusTime extends X2Effect_Persistent;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;

	EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnBegun', class'GrimyClassRebalance_Effect_BonusTime'.static.PlayerTurnBegin, ELD_OnStateSubmitted, 49);
	EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnEnded', class'GrimyClassRebalance_Effect_BonusTime'.static.PlayerTurnEnd, ELD_OnStateSubmitted, 49);
}

static function EventListenerReturn PlayerTurnBegin(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime();
	return ELR_NoInterrupt;
}

static function EventListenerReturn PlayerTurnEnd(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime();
	return ELR_NoInterrupt;
}

static function AddBonusTime() {
	local XComGameState_TimerData	Timer;

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));

	if ( Timer != none ) {
		Timer.AddPauseTime(class'GrimyClassRebalance_AbilitySet'.default.SITUATIONAL_AWARENESS_TIME);
	}
}