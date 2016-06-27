class GrimyATtrition_GTSUnlocks extends X2StrategyElement config(GrimyAttrition);

var config int GTS_COST, GTS_CLASS_REQ;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(GrimyDeepReservesUnlock());

	return Templates;
}

static function X2SoldierAbilityUnlockTemplate GrimyDeepReservesUnlock()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'GrimyDeepReservesUnlock');

	Template.bAllClasses = true;
	Template.AbilityName = 'GrimyAttrition_DeepReserves';
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_Vulture";
	
	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = default.GTS_CLASS_REQ;
	Template.Requirements.RequiredSoldierRankClassCombo = false;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.GTS_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}