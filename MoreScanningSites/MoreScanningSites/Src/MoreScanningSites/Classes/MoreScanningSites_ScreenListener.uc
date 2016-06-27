class MoreScanningSites_ScreenListener extends UIScreenListener config(MoreScanningSites);

struct SCAN_MOD
{
	var name POIName;
	var int DayMod;
	var name MissionName;
};

var config int NUM_SCANNING_SITES, MISSION_SITE_RATE;
var config array<SCAN_MOD> SCAN_TIMES;

event OnInit(UIScreen Screen)
{
	local XComGameState_HeadquartersResistance	ResistanceHQ;
	local int i, NumNewSites;
	
	ResistanceHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();

	MakePOIsAvailable();

	NumNewSites = default.NUM_SCANNING_SITES - ResistanceHQ.ActivePOIs.length;
	for ( i = 0; i < NumNewSites; i++ ) {
		SpawnPOI(ResistanceHQ);
	}
}

function MakePOIsAvailable() {
	local XComGameState_HeadquartersResistance	ResistanceHQ;
	local StateObjectReference					POIRef;
	local XComGameState_PointOfInterest			POIState;
	local XComGameState							NewGameState;
	
	ResistanceHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Making POIs Available");
	foreach ResistanceHQ.ActivePOIs(POIRef) {
		POIState = XComGameState_PointOfInterest(NewGameState.CreateStateObject(class'XComGameState_PointOfInterest', POIRef.ObjectID));
		if ( !POIState.bAvailable ) {
			POIState.bAvailable = true;
			POIState.bTriggerAppearedPopup = true;
			POIState.bNeedsAppearedPopup = true;
		}
		NewGameState.AddStateObject(POIState);
	}
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
}

function SpawnPOI(XComGameState_HeadquartersResistance ResHQ) {
	local XComGameState						NewGameState;
	local XComGameState_PointOfInterest		POIState;
	local StateObjectReference				POIRef, RewardRef;
	local int								NewScanningTime, POIIndex;;
	local SCAN_MOD							MyScanMod;

	// CHOOSE A POI
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("POI Complete: Spawn another POI");
	POIRef = DrawFromDeck();
	
	if ( POIRef.ObjectID == 0 ) {
		`LOG("GRIMY LOG SCANNING SITE ZERO OBJECT ID");
		return ;
	}
	//POIRef = ResHQ.ChoosePOI(NewGameState, true);
	//`LOG("GRIMY LOG RESHQ LOG: " $ POIRef.ObjectID);

	// SPAWN THE POI
	POIState = XComGameState_PointOfInterest(NewGameState.CreateStateObject(class'XComGameState_PointOfInterest', POIRef.ObjectID));
	ResHQ.ActivatePOI(NewGameState, POIState.GetReference());
	POIState.Spawn(NewGameState);

	// UPDATE THE SCANNING TIME FOR HTIS POI
	NewScanningTime = POIState.GetNumScanHoursRemaining()/24;
	POIIndex = default.SCAN_TIMES.Find('POIName',POIState.GetMyTemplateName());
	if ( POIIndex == INDEX_NONE ) {
		//`LOG("POI INDEX INVALID");
		return;
	}
	MyScanMod = default.SCAN_TIMES[POIIndex];
	NewScanningTime += MyScanMod.DayMod;
	
	POIState.SetScanHoursRemaining(NewScanningTime,NewScanningTime);

	// UPDATE THE REWARD FOR THIS POI
	if ( default.MISSION_SITE_RATE > `SYNC_RAND(100) && MyScanMod.MissionName != '' ) {
		foreach POIState.RewardRefs(RewardRef) {
			NewGameState.RemoveStateObject(RewardRef.ObjectID);
		}
		GenerateRewards(NewGameState,POIState, MyScanMod.MissionName);
	}
	POIState.bAvailable = true;

	NewGameState.AddStateObject(POIState);
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
}

function StateObjectReference DrawFromDeck() {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersResistance	ResistanceHQ;
	local array<StateObjectReference> POIDeck;
	local XComGameState_PointOfInterest POIState;
	
	History = `XCOMHISTORY;
	
	ResistanceHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	foreach History.IterateByClassType(class'XComGameState_PointOfInterest', POIState) {
		if ( ResistanceHQ.ActivePOIs.Find('ObjectID',POIState.ObjectID) == INDEX_NONE ) {
			if ( default.SCAN_TIMES.Find('POIName', POIState.GetMyTemplateName()) != INDEX_NONE ) {
				POIDeck.AddItem(POIState.GetReference());
			}
		}
	}
	return POIDeck[`SYNC_RAND(POIDeck.length)];
}

function GenerateRewards(XComGameState NewGameState, XComGameState_PointOfInterest POIState, name RewardName)
{
	local X2StrategyElementTemplateManager StratMgr;
	local XComGameState_Reward RewardState;
	local X2RewardTemplate RewardTemplate;
	
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	POIState.RewardRefs.Length = 0; // Reset the rewards
	
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate(RewardName));

	RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(RewardState);
	RewardState.GenerateReward(NewGameState, 1.0, POIState.ResistanceRegion);
	POIState.RewardRefs.AddItem(RewardState.GetReference());
}



defaultproperties
{
	ScreenClass = class'UIStrategyMap'
}