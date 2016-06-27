class GrimyClass_GTSUnlocks extends X2StrategyElement config(GrimyClassMod);

var config int GTS_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(GrimyIntimidationUnlock());

	return Templates;
}

static function X2SoldierAbilityUnlockTemplate GrimyIntimidationUnlock()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'GrimyIntimidationUnlock');
	
	Template.AllowedClasses.AddItem('Bruiser');
	Template.AbilityName = 'GrimyIntimidationPassive';
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_Ranger";
	
	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 5;
	Template.Requirements.RequiredSoldierClass = 'Bruiser';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GTS_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}