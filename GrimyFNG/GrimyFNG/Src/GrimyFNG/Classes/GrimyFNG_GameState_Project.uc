class GrimyFNG_GameState_Project extends XComGameState_HeadquartersProjectTrainRookie;

function OnProjectCompleted() {
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComHeadquartersCheatManager CheatMgr;

	History = `XCOMHISTORY;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("FNG Promotion");

	CompleteTrainFNG(NewGameState, self.GetReference());
	
	History.AddGameStateToHistory(NewGameState);

	CheatMgr = XComHeadquartersCheatManager(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController().CheatManager);
	if (CheatMgr == none || !CheatMgr.bGamesComDemo)
	{
		`HQPRES.UITrainingComplete(ProjectFocus);
	}
}

static function CompleteTrainFNG(XComGameState AddToGameState, StateObjectReference ProjectRef)
{
	local XComGameState_HeadquartersProjectTrainRookie ProjectState;
	local XComGameState_HeadquartersXCom XComHQ, NewXComHQ;
	local XComGameState_Unit UnitState;
	local XComGameState_StaffSlot StaffSlotState;
	local XComGameStateHistory History;
	local int FNGRank;

	History = `XCOMHISTORY;
	ProjectState = XComGameState_HeadquartersProjectTrainRookie(`XCOMHISTORY.GetGameStateForObjectID(ProjectRef.ObjectID));

	if (ProjectState != none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ != none)
		{
			NewXComHQ = XComGameState_HeadquartersXCom(AddToGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
			AddToGameState.AddStateObject(NewXComHQ);
			NewXComHQ.Projects.RemoveItem(ProjectState.GetReference());
			AddToGameState.RemoveStateObject(ProjectState.ObjectID);
		}

		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ProjectState.ProjectFocus.ObjectID));
		if (UnitState != none)
		{
			FNGRank = class'GrimyFNG_AcademyUnlocks'.static.GetFNGRank();
			// Set the soldier status back to active, and rank them up to their new class
			UnitState = XComGameState_Unit(AddToGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			UnitState.SetXPForRank(FNGRank + 1);
			UnitState.StartingRank = FNGRank + 1;
			UnitState.RankUpSoldier(AddToGameState, ProjectState.NewClassName); // The class template name was set when the project began
			UnitState.ApplySquaddieLoadout(AddToGameState, XComHQ);
			UnitState.ApplyBestGearLoadout(AddToGameState); // Make sure the squaddie has the best gear available
			UnitState.SetStatus(eStatus_Active);

			while ( UnitState.GetRank() <= FNGRank ) {
				UnitState.RankUpSoldier(AddToGameState);
			}

			AddToGameState.AddStateObject(UnitState);

			// Remove the soldier from the staff slot
			StaffSlotState = UnitState.GetStaffSlot();
			if (StaffSlotState != none)
			{
				StaffSlotState.EmptySlot(AddToGameState);
			}
		}
	}
}