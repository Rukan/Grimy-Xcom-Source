class GrimyClassHH_HeadhunterMarkedSet extends X2Ability_AdventCaptain config(GrimyClassHH);

var config int MARKED_COOLDOWN, PREPARATION_COOLDOWN;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>			Templates;

	// LIEUTENANT
	Templates.AddItem(GrimyPreparation('GrimyPreparation',"img:///UILibrary_PerkIcons.UIPerk_timeshift",default.PREPARATION_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY, 0, true));

	// LOOT
	Templates.AddItem(GrimyPreparation('GrimyPreparationBsc',"img:///UILibrary_PerkIcons.UIPerk_timeshift", 0, class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY, 1));
	Templates.AddItem(GrimyPreparation('GrimyPreparationAdv',"img:///UILibrary_PerkIcons.UIPerk_timeshift", 0, class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY, 2));
	Templates.AddItem(GrimyPreparation('GrimyPreparationSup',"img:///UILibrary_PerkIcons.UIPerk_timeshift", 0, class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY, 3));

	return Templates;
}

static function X2AbilityTemplate GrimyPreparation(name TemplateName, string IconImage, int BonusCooldown, int HUDPriority, optional int BonusCharges = 0 , optional bool CrossClass = false) {
	local X2AbilityTemplate					Template;
	local X2AbilityCooldown					Cooldown;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;
	local X2Effect_TurnStartActionPoints	ThreeActionPoints;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = CrossClass;
	Template.IconImage = IconImage;

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Defensive;

	if ( BonusCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = BonusCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	if ( BonusCharges > 0 )
	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	Template.AbilityCosts.AddItem(ActionPointCost);	

	//Can't use while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Add dead eye to guarantee
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	ThreeActionPoints = new class'X2Effect_TurnStartActionPoints';
	ThreeActionPoints.ActionPointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
	ThreeActionPoints.NumActionPoints = 1;
	ThreeActionPoints.BuildPersistentEffect(1,false,true,,eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(ThreeActionPoints);

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_PlayerInput');
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TargetGettingMarked_BuildVisualization;

	return Template;
}