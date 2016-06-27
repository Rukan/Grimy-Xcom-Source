class GrimyAttrition_Abilities extends X2Ability dependson (XComGameStateContext_Ability) config(GrimyAttrition);

var config int DEEP_RESERVES_BONUS, BASE_UPGRADE_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(GrimyBonusReserves('GrimyAttrition_DeepReserves', default.DEEP_RESERVES_BONUS));
	Templates.AddItem(GrimyBonusReserves('GrimyAttrition_BscReserves', default.BASE_UPGRADE_BONUS));
	Templates.AddItem(GrimyBonusReserves('GrimyAttrition_AdvReserves', default.BASE_UPGRADE_BONUS+1));
	Templates.AddItem(GrimyBonusReserves('GrimyAttrition_SupReserves', default.BASE_UPGRADE_BONUS+2));

	return Templates;
}

static function X2AbilityTemplate GrimyBonusReserves(name TemplateName, int Bonus, optional bool ForPrimary = true)
{
	local X2AbilityTemplate									Template;
	local GrimyAttrition_BonusReserves						AmmoEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	InitializeAbilityTemplate(Template);

	// This will tick once during application at the start of the player's turn and increase ammo of the specified items by the specified amounts
	AmmoEffect = new class'GrimyAttrition_BonusReserves';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	AmmoEffect.AmmoCount = Bonus;
	AmmoEffect.ForPrimary = ForPrimary;
	Template.AddTargetEffect(AmmoEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

// #######################################################################################
// -------------------- Utility Functions ---------------------------------------------
// #######################################################################################
static function InitializeAbilityTemplate(X2AbilityTemplate Template)
{
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;
}