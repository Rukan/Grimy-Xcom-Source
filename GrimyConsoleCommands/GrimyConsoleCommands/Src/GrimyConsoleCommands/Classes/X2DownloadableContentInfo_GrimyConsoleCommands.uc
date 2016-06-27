class X2DownloadableContentInfo_GrimyConsoleCommands extends X2DownloadableContentInfo;

exec function LevelUpSoldier(string SoldierName, optional int Ranks = 1) {
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local int idx, i, RankUps, NewRank;
	local name SoldierClassName;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Rankup Soliers Cheat");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);

	for(idx = 0; idx < XComHQ.Crew.Length; idx++)
	{
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[idx].ObjectID));

		if(UnitState != none && UnitState.GetMyTemplateName() == 'Soldier' && UnitState.GetRank() < (class'X2ExperienceConfig'.static.GetMaxRank() - 1) && UnitState.GetFullName() == SoldierName)
		{
			UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			NewGameState.AddStateObject(UnitState);
			NewRank = UnitState.GetRank() + Ranks;

			if(NewRank >= class'X2ExperienceConfig'.static.GetMaxRank())
			{
				NewRank = (class'X2ExperienceConfig'.static.GetMaxRank());
			}

			RankUps = NewRank - UnitState.GetRank();

			for(i = 0; i < RankUps; i++)
			{
				SoldierClassName = '';
				if(UnitState.GetRank() == 0)
				{
					SoldierClassName = XComHQ.SelectNextSoldierClass();
				}

				UnitState.RankUpSoldier(NewGameState, SoldierClassName);

				if(UnitState.GetRank() == 1)
				{
					UnitState.ApplySquaddieLoadout(NewGameState, XComHQ);
					UnitState.ApplyBestGearLoadout(NewGameState); // Make sure the squaddie has the best gear available
				}
			}

			UnitState.StartingRank = NewRank;
			UnitState.SetXPForRank(NewRank);

			break;
		}
	}

	if( NewGameState.GetNumGameStateObjects() > 0 )
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

exec function DeleteSoldierAWCAbilities(string UnitName) {
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local int idx;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Turn Solier Into Class Cheat");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);

	for (idx = 0; idx < XComHQ.Crew.Length; idx++) {
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[idx].ObjectID));
				
		if (UnitState.GetFullName() == UnitName) {
			UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			NewGameState.AddStateObject(UnitState);

			UnitState.AWCAbilities.length = 0;;
			break;
		}
	}

	if (NewGameState.GetNumGameStateObjects() > 0) {
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else {
		History.CleanupPendingGameState(NewGameState);
	}
}

exec function GiveSoldierAWCAbility(string UnitName, name AbilityName, optional int Slot = 1) {
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local int idx;

	local ClassAgnosticAbility AWCAbility;
	local SoldierClassAbilityType AbilityType;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Turn Solier Into Class Cheat");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);

	for (idx = 0; idx < XComHQ.Crew.Length; idx++) {
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[idx].ObjectID));
				
		if (UnitState.GetFullName() == UnitName) {
			UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			NewGameState.AddStateObject(UnitState);

			AbilityType.AbilityName = AbilityName;
			Switch (Slot) {
				case 0:
					AbilityType.ApplyToWeaponSlot = eInvSlot_Unknown;
					break;
				case 1:
					AbilityType.ApplyToWeaponSlot = eInvSlot_PrimaryWeapon;
					break;
				case 2:
					AbilityType.ApplyToWeaponSlot = eInvSlot_SecondaryWeapon;
					break;
				case 3:
					AbilityType.ApplyToWeaponSlot = eInvSlot_TertiaryWeapon;
					break;
				case 4:
					AbilityType.ApplyToWeaponSlot = eInvSlot_QuaternaryWeapon;
					break;
				case 5:
					AbilityType.ApplyToWeaponSlot = eInvSlot_QuaternaryWeapon;
					break;
				case 6:
					AbilityType.ApplyToWeaponSlot = eInvSlot_QuaternaryWeapon;
					break;
				case 7:
					AbilityType.ApplyToWeaponSlot = eInvSlot_QuaternaryWeapon;
					break;
				case 8:
					AbilityType.ApplyToWeaponSlot = eInvSlot_QuaternaryWeapon;
					break;
				default:
					AbilityType.ApplyToWeaponSlot = eInvSlot_PrimaryWeapon;
					break;
			}
			AWCAbility.AbilityType = AbilityType;
			AWCAbility.bUnlocked = true;
			AWCAbility.iRank = 0;
			UnitState.AWCAbilities.AddItem(AWCAbility);
			break;
		}
	}

	if (NewGameState.GetNumGameStateObjects() > 0) {
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else {
		History.CleanupPendingGameState(NewGameState);
	}
}