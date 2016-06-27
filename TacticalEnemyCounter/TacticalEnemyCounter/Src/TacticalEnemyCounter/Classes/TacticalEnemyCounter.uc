class TacticalEnemyCounter extends UIScreenListener config(TacticalEnemyCounter);

var config bool bSHOW_WITHOUT_SHADOWCHAMBER;

event OnInit(UIScreen Screen)
{
	local XGAIPlayer EnemyPlayer;
	local array<XComGameState_Unit> AllEnemies;
	local UIText EnemyCount

	EnemyPlayer = `BATTLE.GetEnemyPlayer(`BATTLE.GetAIPlayer());
	if( EnemyPlayer != None )
	{
		EnemyPlayer.GetAliveUnits(AllEnemies);
	}

	EnemyCount = Screen.Spawn(class'UIText', Screen);
	EnemyCount.SetText("Enemy Count: " $ AllEnemies.length);
	EnemyCount.AnchorTopLeft();
	EnemyCount.SetY(330);
	EnemyCount.SetX(35);
}

defaultproperties
{
	ScreenClass=class'UISquadSelect'
}