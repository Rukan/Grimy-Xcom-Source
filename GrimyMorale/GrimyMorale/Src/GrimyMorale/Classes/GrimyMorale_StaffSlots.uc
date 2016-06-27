class GrimyMorale_StaffSlots extends X2StrategyElement_DefaultStaffSlots;

//---------------------------------------------------------------------------------------
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> StaffSlots;

	StaffSlots.AddItem(CreateBarSlotTemplate());

	return StaffSlots;
}

static function X2DataTemplate CreateBarSlotTemplate()
{
	local X2StaffSlotTemplate Template;

	`CREATE_X2TEMPLATE(class'X2StaffSlotTemplate', Template, 'GrimyBarSlot');
	Template.bSoldierSlot = true;
	Template.bRequireConfirmToEmpty = true;
	Template.FillFn = FillBarSoldierSlot; // here
	Template.EmptyFn = EmptySlotDefault;
	Template.EmptyStopProjectFn = EmptyStopBarSlot; // here
	Template.ShouldDisplayToDoWarningFn = ShouldDisplayAWCSoldierToDoWarning;
	Template.GetContributionFromSkillFn = GetContributionDefault; 
	Template.GetAvengerBonusAmountFn = GetAvengerBonusDefault;
	Template.GetNameDisplayStringFn = GetNameDisplayStringDefault;
	Template.GetSkillDisplayStringFn = GetAWCSoldierSkillDisplayString;
	Template.GetBonusDisplayStringFn = GetBarSoldierBonusDisplayString; // here
	Template.GetLocationDisplayStringFn = GetLocationDisplayStringDefault;
	Template.IsUnitValidForSlotFn = IsUnitValidForBarSlot; // here
	Template.IsStaffSlotBusyFn = IsStaffSlotBusyDefault;
	Template.MatineeSlotName = "Soldier";

	return Template;
}

static function string GetBarSoldierBonusDisplayString(XComGameState_StaffSlot SlotState, optional bool bPreview)
{
	local XComGameState_Unit UnitState;

	if (SlotState.IsSlotFilled())
		UnitState = SlotState.GetAssignedStaff();

	if ( UnitState == none ) { return ""; }

	return UnitState.GetCurrentStat(eStat_Will) $ "/" $ UnitState.GetBaseStat(eStat_Will) $ SlotState.GetMyTemplate().BonusText;
}

static function FillBarSoldierSlot(XComGameState NewGameState, StateObjectReference SlotRef, StaffUnitInfo UnitInfo)
{
	local XComGameState_Unit NewUnitState;
	local XComGameState_StaffSlot NewSlotState;
	local XComGameState_HeadquartersXCom NewXComHQ;
	local XComGameState_HeadquartersProjectRespecSoldier ProjectState;
	local StateObjectReference EmptyRef;
	local int SquadIndex;

	FillSlot(NewGameState, SlotRef, UnitInfo, NewSlotState, NewUnitState);
	NewXComHQ = GetNewXComHQState(NewGameState);

	// change this
	ProjectState = XComGameState_HeadquartersProjectRespecSoldier(NewGameState.CreateStateObject(class'XComGameState_HeadquartersProjectRespecSoldier'));
	NewGameState.AddStateObject(ProjectState);
	ProjectState.SetProjectFocus(UnitInfo.UnitRef, NewGameState, NewSlotState.Facility);

	NewUnitState.SetStatus(eStatus_Healing);
	NewXComHQ.Projects.AddItem(ProjectState.GetReference());

	// If the unit undergoing training is in the squad, remove them
	SquadIndex = NewXComHQ.Squad.Find('ObjectID', UnitInfo.UnitRef.ObjectID);
	if (SquadIndex != INDEX_NONE)
	{
		// Remove them from the squad
		NewXComHQ.Squad[SquadIndex] = EmptyRef;
	}
}

static function EmptyStopBarSlot(StateObjectReference SlotRef)
{
	local HeadquartersOrderInputContext OrderInput;
	local XComGameState_StaffSlot SlotState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_HeadquartersProjectRespecSoldier RespecSoldierProject;

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	SlotState = XComGameState_StaffSlot(`XCOMHISTORY.GetGameStateForObjectID(SlotRef.ObjectID));

	RespecSoldierProject = XComHQ.GetRespecSoldierProject(SlotState.GetAssignedStaffRef());
	if (RespecSoldierProject != none)
	{
		OrderInput.OrderType = eHeadquartersOrderType_CancelRespecSoldier;
		OrderInput.AcquireObjectReference = RespecSoldierProject.GetReference();
		
		class'XComGameStateContext_HeadquartersOrder'.static.IssueHeadquartersOrder(OrderInput);
	}
}

static function bool IsUnitValidForBarSlot(XComGameState_StaffSlot SlotState, StaffUnitInfo UnitInfo)
{
	local XComGameState_Unit Unit;

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitInfo.UnitRef.ObjectID));

	if (Unit.IsASoldier()
		&& !Unit.IsTraining()
		&& !Unit.IsPsiTraining()
		&& Unit.GetCurrentStat(eStat_Will) < Unit.GetBaseStat(eStat_Will))
	{
		return true;
	}

	return false;
}