class GrimyClassAN_GTSUnlocks extends X2StrategyElement config(GrimyClassAN);

var config int GTS_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(GrimyShellShockUnlock());

	return Templates;
}

static function X2SoldierAbilityUnlockTemplate GrimyShellShockUnlock()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'GrimyShellShockUnlock');
	
	Template.AllowedClasses.AddItem('Anarchist');
	Template.AbilityName = 'GrimyShellShock';
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_Grenadier";
	
	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 5;
	Template.Requirements.RequiredSoldierClass = 'Anarchist';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GTS_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}