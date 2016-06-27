class GrimyClassFury_Cooldown_PerPlayer extends X2AbilityCooldown_LocalAndGlobal;

// X2AbilityCooldown::iNumTurns is what non-AI controlled units use as the cooldown
var int iNumTurnsForAI;     // If this unit is controlled by the AI then it uses this value as its cooldown
var bool bAITurns;
var name AltAbility;
var int AltTurns;

simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
	local XComGameState_Unit UnitState;
	local XComGameState_Player PlayerState;
	local int NumTurns;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	UnitState = XComGameState_Unit(AffectState);
	PlayerState = XComGameState_Player(History.GetGameStateForObjectID(UnitState.ControllingPlayer.ObjectID));

	NumTurns = iNumTurns;
	if( bAITurns && PlayerState.IsAIPlayer() )
	{
		// If the player state is AI (alien or civilian) then use the iNumTurnsForAI value
		// Player units don't use Global cooldowns
		NumTurns = iNumTurnsForAI;
	}
	else if ( UnitState.FindAbility(AltAbility).ObjectID > 0 ) {
		NumTurns = AltTurns;
	}

	return NumTurns;
}

defaultproperties
{
	bAITurns=false
}