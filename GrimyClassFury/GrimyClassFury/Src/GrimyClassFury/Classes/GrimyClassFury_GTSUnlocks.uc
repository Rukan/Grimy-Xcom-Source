class GrimyClassFury_GTSUnlocks extends X2StrategyElement config(GrimyClassFury);

var config int GTS_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(GrimySpeedsterUnlock());

	return Templates;
}

static function X2SoldierAbilityUnlockTemplate GrimySpeedsterUnlock()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'GrimySpeedsterUnlock');

	Template.AllowedClasses.AddItem('Fury');
	Template.AbilityName = 'GrimySpeedster';
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_Specialist";
	
	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 5;
	Template.Requirements.RequiredSoldierClass = 'Fury';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GTS_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}