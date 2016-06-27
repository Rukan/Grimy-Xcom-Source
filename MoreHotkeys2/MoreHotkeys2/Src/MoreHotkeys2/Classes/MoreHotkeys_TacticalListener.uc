class MoreHotkeys_TacticalListener extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local MoreHotkeys_TacticalInput		TacticalInput;

	TacticalInput = MoreHotkeys_TacticalInput(XComTacticalController(Screen.PC).PlayerInput);
	TacticalInput.CacheUI(UITacticalHUD(Screen));
	TacticalInput.F1ItemCard.Hide();
	TacticalInput.AbilityText.Hide();
	TacticalInput.StatText.Hide();
}

defaultproperties
{
	ScreenClass=class'UITacticalHUD';
}