class GrimyLoot_ContinentBonuses extends X2StrategyElement_DefaultContinentBonuses config(GrimyContinentBonuses);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Bonuses;

	Bonuses.AddItem(CreateSignalFlareTemplate());
	Bonuses.AddItem(CreateXenobiologyTemplate());
	Bonuses.AddItem(CreateHelpingHandTemplate());
	Bonuses.AddItem(CreateSafeCrackerTemplate());
	Bonuses.AddItem(CreateProwlersProfitTemplate());

	return Bonuses;
}

static function X2DataTemplate CreateSafeCrackerTemplate()
{
	local X2GameplayMutatorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GameplayMutatorTemplate', Template, 'ContinentBonus_SafeCracker');
	Template.Category = "ContinentBonus";
	Template.OnActivatedFn = ActivateSafeCracker;
	Template.OnDeactivatedFn = DeactivateSafeCracker;

	return Template;
}

static function ActivateSafeCracker(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
{
	local X2StrategyElementTemplateManager	StratMgr;
	local X2TechTemplate					TechTemplate;

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyRareLockbox'));
	TechTemplate.PointsToComplete *= 0.5;
	TechTemplate.RepeatPointsIncrease *= 0.5;

	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyEpicLockbox'));
	TechTemplate.PointsToComplete *= 0.5;
	TechTemplate.RepeatPointsIncrease *= 0.5;

	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyLegendaryLockbox'));
	TechTemplate.PointsToComplete *= 0.5;
	TechTemplate.RepeatPointsIncrease *= 0.5;
}

static function DeactivateSafeCracker(XComGameState NewGameState, StateObjectReference InRef)
{
	local X2StrategyElementTemplateManager	StratMgr;
	local X2TechTemplate					TechTemplate;

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyRareLockbox'));
	TechTemplate.PointsToComplete *= 2;
	TechTemplate.RepeatPointsIncrease *= 2;

	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyEpicLockbox'));
	TechTemplate.PointsToComplete *= 2;
	TechTemplate.RepeatPointsIncrease *= 2;

	TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('Tech_IdentifyLegendaryLockbox'));
	TechTemplate.PointsToComplete *= 2;
	TechTemplate.RepeatPointsIncrease *= 2;
}

static function X2DataTemplate CreateProwlersProfitTemplate()
{
	local X2GameplayMutatorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GameplayMutatorTemplate', Template, 'ContinentBonus_ProwlersProfit');
	Template.Category = "ContinentBonus";
	Template.OnActivatedFn = ActivateProwlersProfit;
	Template.OnDeactivatedFn = DeactivateProwlersProfit;

	return Template;
}

static function ActivateProwlersProfit(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
{

}

static function DeactivateProwlersProfit(XComGameState NewGameState, StateObjectReference InRef)
{

}