class MoreHotkeys_UITacticalHUD extends UITacticalHUD config(MoreHotkeys);

var config array<GrimyKeyInfo> ABILITY_KEYS;

simulated function bool OnUnrealCommand(int cmd, int arg) {
	local GrimyKeyInfo AbilityKey;
	`LOG("GRIMY LOG - UNREAL COMMAND DETECTED");

	foreach default.ABILITY_KEYS(AbilityKey) {
		if ( ActivateAbilityByHotkey(cmd) ) {
			break;
		}
	}

	return super.OnUnrealCommand(cmd,arg);
}

simulated function bool ActivateAbilityByHotKey(int KeyCode)
{
	local int AbilityIndex;

	`LOG("Activating Ability");
	AbilityIndex = m_kAbilityHUD.GetAbilityIndexByHotKey(KeyCode);
	if (AbilityIndex == INDEX_NONE)
	{
		`log("Ability Index Was Empty");
		return false;
	}

	m_kAbilityHUD.DirectConfirmAbility(AbilityIndex, true);
	return true;
}