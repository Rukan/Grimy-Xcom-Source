class Grimy_AcademyListener extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local X2StrategyElementTemplateManager		StrategyManager;
	local X2FacilityTemplate					OTSTemplate;
	local array<name>							UnlockNames;
	local name									UnlockName;
	local X2SoldierAbilityUnlockTemplate		AcademyUnlock;

	// Add Strategy Unlocks
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	OTSTemplate = X2FacilityTemplate(StrategyManager.FindStrategyElementTemplate('OfficerTrainingSchool'));
	UnlockNames = OTSTemplate.SoldierUnlockTemplates;
	foreach UnlockNames(UnlockName) {
		AcademyUnlock = X2SoldierAbilityUnlockTemplate(StrategyManager.FindStrategyElementTemplate(UnlockName));
		AcademyUnlock.Requirements.RequiredSoldierClass = '';
		AcademyUnlock.Requirements.RequiredSoldierRankClassCombo = false;
	}
}

defaultproperties
{
	ScreenClass = class'UIFacility_Academy';
}