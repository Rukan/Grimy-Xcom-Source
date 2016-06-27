class MissionTimers_TacticalListener extends UIScreenListener;

var MissionTimers_UIScreen TimerScreen;

event OnInit(UIScreen Screen)
{
	local XComPresentationLayer Pres;
	
	Pres = `PRES;
	TimerScreen = Pres.Spawn( class'MissionTimers_UIScreen', Pres );
	TimerScreen.InitScreen( XComPlayerController(Pres.Owner), screen.movie );
	TimerScreen.OnInit();
	screen.movie.LoadScreen(TimerScreen);
	Pres.OnMovieInitialized();
	Pres.ScreenStack.Push( TimerScreen );
	Pres.ScreenStack.ForceStackOrder( screen.movie );
}

event OnRemoved(UIScreen Screen) {
	`PRES.ScreenStack.PopFirstInstanceOfClass(class'MissionTimers_UIScreen');
	TimerScreen.CloseScreen();
}


defaultproperties
{
	ScreenClass=class'UITacticalHUD';
}