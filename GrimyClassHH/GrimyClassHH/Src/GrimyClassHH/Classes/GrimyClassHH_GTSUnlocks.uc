class GrimyClassHH_GTSUnlocks extends X2StrategyElement config(GrimyClassHH);

var config int GTS_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(GrimyHexHunterUnlock());

	return Templates;
}

static function X2SoldierAbilityUnlockTemplate GrimyHexHunterUnlock()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'GrimyHexHunterUnlock');

	Template.AllowedClasses.AddItem('HeadHunter');
	Template.AbilityName = 'GrimyHexHunterBonus';
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_Sharpshooter";
	
	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 5;
	Template.Requirements.RequiredSoldierClass = 'HeadHunter';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GTS_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}