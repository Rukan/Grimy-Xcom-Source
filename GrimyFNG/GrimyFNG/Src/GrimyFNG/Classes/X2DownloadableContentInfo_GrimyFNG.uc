class X2DownloadableContentInfo_GrimyFNG extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local array<X2DataTemplate>					DifficultyTemplates;
	local X2DataTemplate						DifficultyTemplate;

	class'GrimyFNG_AcademyUnlocks'.static.UpdateOTS();

	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StrategyManager.FindDataTemplateAllDifficulties('OTSStaffSlot',DifficultyTemplates);	
	foreach DifficultyTemplates(DifficultyTemplate) {
		X2StaffSlotTemplate(DifficultyTemplate).FillFn = GrimyFillOTSSlot;
	}
}

static function GrimyFillOTSSlot(XComGameState NewGameState, StateObjectReference SlotRef, StaffUnitInfo UnitInfo)
{
	local XComGameState_Unit NewUnitState;
	local XComGameState_StaffSlot NewSlotState;
	local XComGameState_HeadquartersXCom NewXComHQ;
	local GrimyFNG_GameState_Project ProjectState;
	local StateObjectReference EmptyRef;
	local int SquadIndex;

	class'X2StrategyElement_DefaultStaffSlots'.static.FillSlot(NewGameState, SlotRef, UnitInfo, NewSlotState, NewUnitState);
	NewXComHQ = class'X2StrategyElement_DefaultStaffSlots'.static.GetNewXComHQState(NewGameState);
	
	ProjectState = GrimyFNG_GameState_Project(NewGameState.CreateStateObject(class'GrimyFNG_GameState_Project'));
	NewGameState.AddStateObject(ProjectState);
	ProjectState.SetProjectFocus(UnitInfo.UnitRef, NewGameState, NewSlotState.Facility);

	NewUnitState.SetStatus(eStatus_Training);
	NewXComHQ.Projects.AddItem(ProjectState.GetReference());
	
	// If the unit undergoing training is in the squad, remove them
	SquadIndex = NewXComHQ.Squad.Find('ObjectID', UnitInfo.UnitRef.ObjectID);
	if (SquadIndex != INDEX_NONE)
	{
		// Remove their gear
		NewUnitState.MakeItemsAvailable(NewGameState, false);

		// Remove them from the squad
		NewXComHQ.Squad[SquadIndex] = EmptyRef;
	}
}