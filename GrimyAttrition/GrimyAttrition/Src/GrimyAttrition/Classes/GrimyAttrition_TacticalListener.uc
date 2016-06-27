class GrimyAttrition_TacticalListener extends UIScreenListener config(GrimyAttrition);

struct GrimyPodData
{
	var name MissionName;
	var int Delay;
	var int Cooldown;
	var int Offset;
	var int BonusAmmo;
};

var config bool bShowETA;
var config int ETA_OffsetX, ETA_OffsetY;
var config int REINFORCEMENT_DELAY, REINFORCEMENT_COOLDOWN, REINFORCEMENT_TILE_OFFSET;
var config array<GrimyPodData> POD_DATA;
var config array<name> EXCLUDE_CHARS;
var int Cooldown, Delay, Offset;
var int ETA;

var localized string sReinforcements, sTurns;

event OnInit(UIScreen Screen)
{
	local UITacticalHUD					MyScreen;
	local X2EventManager				EventManager;
	local object						ThisObj;
	local XComGameState_BattleData		BattleData;
	local GeneratedMissionData			GeneratedMission;
	local X2MissionTemplate				MissionTemplate;
	local GrimyPodData					PodData;
	local UIText						ETAText;
	
	local XComGameState NewGameState;
	local GrimyAttrition_GameState AttritionState;

	MyScreen = UITacticalHUD(Screen);
	ThisObj = self;
	EventManager = `XEVENTMGR;
	EventManager.RegisterForEvent(ThisObj, 'PlayerTurnBegun', PlayerTurnBegin, ELD_OnStateSubmitted);

//	MyScreen.m_kInventory.m_kWeapon.Remove();
//	MyScreen.m_kInventory.m_kWeapon = MyScreen.m_kInventory.Spawn(class'GrimyAttrition_TacticalHUDWeapon', MyScreen.m_kInventory).InitWeapon();
//	MyScreen.m_kInventory.Update();

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData') );
	GeneratedMission = class'UIUtilities_Strategy'.static.GetXComHQ().GetGeneratedMissionData(BattleData.m_iMissionID);
	MissionTemplate = class'X2MissionTemplateManager'.static.GetMissionTemplateManager().FindMissionTemplate(GeneratedMission.Mission.MissionName);

	Cooldown = default.REINFORCEMENT_COOLDOWN;
	Delay = default.REINFORCEMENT_DELAY;
	Offset = default.REINFORCEMENT_TILE_OFFSET;

	foreach default.POD_DATA(PodData) {
		if ( MissionTemplate.DataName == PodData.MissionName ) {
			Cooldown = PodData.Cooldown;
			Delay = PodData.Delay;
			Offset = PodData.Offset;
			break;
		}
	}

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Completed Objective");
	AttritionState = GrimyAttrition_GameState(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'GrimyAttrition_GameState'));
	
	if ( AttritionState == none ) 
		AttritionState = GrimyAttrition_GameState(NewGameState.CreateStateObject(class'GrimyAttrition_GameState'));	
	else
		AttritionState = GrimyAttrition_GameState(NewGameState.CreateStateObject(class'GrimyAttrition_GameState', AttritionState.ObjectID));

	if ( AttritionState.OpName != BattleData.m_strOpName ) {
		AttritionState.ETA = Delay;
		AttritionState.OpName = BattleData.m_strOpName;
	}

	NewGameState.AddStateObject(AttritionState);
	`TACTICALRULES.SubmitGameState(NewGameState);

	if ( default.bShowETA ) {
		ETAText = MyScreen.Spawn(class'UIText',MyScreen).InitText('GrimyAttritionETA');
		ETAText.SetText(class'UIUtilities_Text'.static.GetColoredText(sReinforcements $ AttritionState.ETA/2 + 1 $ sTurns,eUIState_Warning));
		ETAText.SetPosition(default.ETA_OffsetX,default.ETA_OffsetY);
	}
}

static function int GetBonusAmmo() {
	local XComGameState_BattleData		BattleData;
	local GeneratedMissionData			GeneratedMission;
	local X2MissionTemplate				MissionTemplate;
	local GrimyPodData					PodData;

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData') );
	GeneratedMission = class'UIUtilities_Strategy'.static.GetXComHQ().GetGeneratedMissionData(BattleData.m_iMissionID);
	MissionTemplate = class'X2MissionTemplateManager'.static.GetMissionTemplateManager().FindMissionTemplate(GeneratedMission.Mission.MissionName);

	foreach default.POD_DATA(PodData) {
		if ( MissionTemplate.DataName == PodData.MissionName ) {
			return PodData.BonusAmmo;
		}
	}
}

event OnRemoved(UIScreen Screen)
{
	local Object ThisObj;

	ThisObj = self;
	`XEVENTMGR.UnRegisterFromAllEvents(ThisObj);
}

function EventListenerReturn PlayerTurnBegin(Object EventData, Object EventSource, XComGameState GameState, Name EventID) {
	local XComGameStateHistory				History;
	local XComGameState_HeadquartersXCom	XComHQ;
	local XComGameState_MissionSite			MissionSite;
	local int								NewETA;
	
	local XComGameState NewGameState;
	local GrimyAttrition_GameState AttritionState;

	History = `XCOMHISTORY;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Completed Objective");
	AttritionState = GrimyAttrition_GameState(History.GetSingleGameStateObjectForClass(class'GrimyAttrition_GameState'));
	AttritionState = GrimyAttrition_GameState(NewGameState.CreateStateObject(class'GrimyAttrition_GameState', AttritionState.ObjectID));
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom') );
	MissionSite = XComGameState_MissionSite(History.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID) );
	
	NewETA = AttritionState.ETA - 1;
	if ( NewETA == 0 ) {
		class'XComGameState_AIReinforcementSpawner'.static.InitiateReinforcements(GetReinforcementName(MissionSite), , false , , Offset); //, NewGameState);
		NewETA = Cooldown;
	}

	if ( default.bShowETA ) {
		UIText(`PRES.GetTacticalHUD().GetChild('GrimyAttritionETA')).SetText(class'UIUtilities_Text'.static.GetColoredText(sReinforcements $ NewETA/2 + 1 $ sTurns,eUIState_Warning));
	}

	AttritionState.ETA = NewETA;
	
	NewGameState.AddStateObject(AttritionState);
	`TACTICALRULES.SubmitGameState(NewGameState);

	// we have to manually increment this turn counter since it doesn't seem to work in single player
	return ELR_NoInterrupt;
}

function name GetReinforcementName(XComGameState_MissionSite MissionSite) {
	local name RetName;
	RetName = MissionSite.SelectedMissionData.SelectedEncounters[`SYNC_RAND(MissionSite.SelectedMissionData.SelectedEncounters.length)].SelectedEncounterName;
	if ( default.EXCLUDE_CHARS.find(RetName) == INDEX_NONE ) {
		return RetName;
	}
	else {
		return GetReinforcementName(MissionSite);
	}
}

function DistributeBonusLoot() {
	local XComGameStateHistory History;
    local XComGameState_Unit Unit, NewUnitState;
	local XComGameState NewGameState;

	local LootResults NewLoot;

	History = `XCOMHISTORY;
	
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add New Loot");
	foreach History.IterateByClassType(class'XComGameState_Unit', Unit)
    {
		// I need to add a component to mark a unit has had its loot applied to it.
		// I'm going to need to brainstorm new loot rewards, because supplies aren't going to cut it.
		// look into OnUnitMoveFinished
		if ( Unit.GetTeam() == eTeam_Alien && !Unit.bRemovedFromPlay && Unit.IsAlive() )
		{
			if ( Unit.PendingLoot.LootToBeCreated.length <= 0 && Unit.PendingLoot.AvailableLoot.length <= 0 ) {
				NewLoot.bRolledForLoot = Unit.PendingLoot.bRolledForLoot;
				NewLoot.LootToBeCreated.length = 0;
				NewLoot.LootToBeCreated.additem('Supplies');
				NewLoot.AvailableLoot.length = 0;

				NewUnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', Unit.ObjectID));
				NewUnitState.SetLoot(NewLoot);
				NewGameState.AddStateObject(NewUnitState);
			}
		}
	}

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
}


defaultproperties
{
	ScreenClass=class'UITacticalHUD';
}