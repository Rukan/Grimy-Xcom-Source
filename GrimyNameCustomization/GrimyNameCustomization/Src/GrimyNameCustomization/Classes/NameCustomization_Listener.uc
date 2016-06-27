class NameCustomization_Listener extends UIScreenListener;

var UIButton ButtonFirst, ButtonLast, ButtonNickname;

event OnInit(UIScreen Screen) {
	UpdateUI(UICustomize_Info(Screen));
}

event OnRefresh(UIScreen Screen) {
	UpdateUI(UICustomize_Info(Screen_);
}

function UpdateUI(UICustomize_Info Screen) {
	ButtonFirst = Screen.Spawn(class'UIButton');
}

defaultproperties
{
	ScreenClass = class'UICustomize_Info';
}