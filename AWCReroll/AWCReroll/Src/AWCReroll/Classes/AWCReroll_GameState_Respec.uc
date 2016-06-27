class AWCReroll_GameState_Respec extends XComGameState_HeadquartersProjectRespecSoldier;

function OnProjectCompleted() {
	local XComGameStateHistory History;
	local XComGameState NewGameState;

	History = `XCOMHISTORY;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("AWC Soldier Respec");

	CompleteRespecSoldier(NewGameState, self.GetReference());

	History.AddGameStateToHistory(NewGameState);

	`HQPRES.UITrainingComplete(ProjectFocus);
}

function CompleteRespecSoldier(XComGameState AddToGameState, StateObjectReference ProjectRef)
{
	local XComGameState_HeadquartersProjectRespecSoldier ProjectState;
	local XComGameState_HeadquartersXCom XComHQ, NewXComHQ;
	local XComGameState_Unit UnitState;
	local XComGameState_StaffSlot StaffSlotState;
	local XComGameStateHistory History;
	local int i, AWCIndex;
	local array<SoldierClassAbilityType> EligibleAbilities;

	local X2AbilityTemplateManager		AbilityManager;
	local X2AbilityTemplate				AbilityTemplate;

	History = `XCOMHISTORY;
	ProjectState = XComGameState_HeadquartersProjectRespecSoldier(`XCOMHISTORY.GetGameStateForObjectID(ProjectRef.ObjectID));

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

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
			// Set the soldier status back to active, and rank them up to their new class
			UnitState = XComGameState_Unit(AddToGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			UnitState.ResetSoldierAbilities(); // First clear all of the current abilities
			for (i = 0; i < UnitState.GetSoldierClassTemplate().GetAbilityTree(0).Length; ++i) // Then give them their squaddie ability back
			{
				UnitState.BuySoldierProgressionAbility(AddToGameState, 0, i);
			}

			// AWC Reroll Change
			EligibleAbilities = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager().GetCrossClassAbilities(UnitState.GetSoldierClassTemplate());
			for(AWCIndex = 0; AWCIndex < UnitState.AWCAbilities.Length; AWCIndex++)
			{
				AbilityTemplate = AbilityManager.FindAbilityTemplate(UnitState.AWCAbilities[AWCIndex].AbilityType.AbilityName);
				if ( AbilityTemplate != none && AbilityTemplate.bCrossClassEligible ) { 
					UnitState.AWCAbilities[AWCIndex].AbilityType = EligibleAbilities[`SYNC_RAND_STATIC(EligibleAbilities.Length)];
					if ( UnitState.AWCAbilities[AWCIndex].iRank <= UnitState.GetSoldierRank() )
					{
						UnitState.AWCAbilities[AWCIndex].bUnlocked = true;
						UnitState.bRolledforAWCAbility= true;
					}
				}
			}

			UnitState.SetStatus(eStatus_Active);
			//UnitState.EquipOldItems(AddToGameState);
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