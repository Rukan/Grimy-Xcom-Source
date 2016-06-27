class MissionTimers_Effect_BonusTime extends X2Effect_Persistent;

var int UpgradeIndex;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;

	switch ( UpgradeIndex ) {
		case 0:
			EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnBegun', class'MissionTimers_Effect_BonusTime'.static.PlayerTurnBegin_Bsc, ELD_OnStateSubmitted, 49);
			EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnEnded', class'MissionTimers_Effect_BonusTime'.static.PlayerTurnEnd_Bsc, ELD_OnStateSubmitted, 49);
			break;
		case 1:
			EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnBegun', class'MissionTimers_Effect_BonusTime'.static.PlayerTurnBegin_Adv, ELD_OnStateSubmitted, 49);
			EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnEnded', class'MissionTimers_Effect_BonusTime'.static.PlayerTurnEnd_Adv, ELD_OnStateSubmitted, 49);
			break;
		case 2:
			EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnBegun', class'MissionTimers_Effect_BonusTime'.static.PlayerTurnBegin_Sup, ELD_OnStateSubmitted, 49);
			EventMgr.RegisterForEvent(EffectObj, 'PlayerTurnEnded', class'MissionTimers_Effect_BonusTime'.static.PlayerTurnEnd_Sup, ELD_OnStateSubmitted, 49);
			break;
	}
}

static function EventListenerReturn PlayerTurnBegin_Bsc(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime_Bsc();
	return ELR_NoInterrupt;
}

static function EventListenerReturn PlayerTurnEnd_Bsc(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime_Bsc();
	return ELR_NoInterrupt;
}

static function EventListenerReturn PlayerTurnBegin_Adv(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime_Adv();
	return ELR_NoInterrupt;
}

static function EventListenerReturn PlayerTurnEnd_Adv(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime_Adv();
	return ELR_NoInterrupt;
}

static function EventListenerReturn PlayerTurnBegin_Sup(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime_Sup();
	return ELR_NoInterrupt;
}

static function EventListenerReturn PlayerTurnEnd_Sup(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	AddBonusTime_Sup();
	return ELR_NoInterrupt;
}

static function AddBonusTime_Bsc() {
	local XComGameState_TimerData	Timer;

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));

	if ( Timer != none ) {
		Timer.AddPauseTime(class'MissionTimers_Abilities'.default.UPGRADE_BONUS_BSC);
	}
}

static function AddBonusTime_Adv() {
	local XComGameState_TimerData	Timer;

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));

	if ( Timer != none ) {
		Timer.AddPauseTime(class'MissionTimers_Abilities'.default.UPGRADE_BONUS_ADV);
	}
}

static function AddBonusTime_Sup() {
	local XComGameState_TimerData	Timer;

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));

	if ( Timer != none ) {
		Timer.AddPauseTime(class'MissionTimers_Abilities'.default.UPGRADE_BONUS_SUP);
	}
}