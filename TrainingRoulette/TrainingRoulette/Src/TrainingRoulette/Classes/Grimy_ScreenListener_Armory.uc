class Grimy_ScreenListener_Armory extends UIScreenListener;

event OnInit(UIScreen Screen) {
	if ( Screen.IsA('UIFacility_Armory') || Screen.IsA('UITacticalHUD') ) {
		class'Grimy_Utility_TrainingRoulette'.static.UpdateBarracks();
	}
}

/*
event OnReceiveFocus(UIScreen Screen) {
	if ( Screen.IsA('UIFacility_Armory') ) {
		class'Grimy_Utility_TrainingRoulette'.static.UpdateBarracks();
	}
}

defaultproperties
{
	//ScreenClass = class'UIFacility_Armory'
	//ScreenClass = class'UIFacility_Armory'
	// ScreenClass = class'UIAvengerHUD'
	// ScreenClass = class'UITacticalHUD'
}*/