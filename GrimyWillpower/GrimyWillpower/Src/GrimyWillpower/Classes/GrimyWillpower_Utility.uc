class GrimyWillpower_Utility extends object;

function InitializeWillpowerComponent(XComGameState_Unit UnitState ) {
	local XComGameState					NewGameState;
	local XComGameState_Unit			NewUnitState;
	local GrimyWillpower_GameComponent	ComponentState;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Updating Willpower Component");
	
	NewUnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	
	ComponentState = GrimyWillpower_GameComponent(UnitState.FindComponentObject(class'GrimyWillpower_GameComponent'));
	if ( ComponentState == none ) {
		ComponentState = GrimyWillpower_GameComponent(NewGameState.CreateStateObject(class'GrimyWillpower_GameComponent'));
		ComponentState.UnitID = UnitState.ObjectID;
		NewUnitState.AddComponentObject(ComponentState);
	}
	else {
		ComponentState = GrimyWillpower_GameComponent(NewGameState.CreateStateObject(class'GrimyWillpower_GameComponent', Soldier.ObjectID));
	}

	ComponentState.LowestWillpower = UnitState.GetMaxStat(eStat_Will);
	
	NewGameState.AddStateObject(ComponentState);
	NewGameState.AddStateObject(NewUnitState);

	`XCOMHISTORY.AddGameStateToHistory(NewGameState);
}