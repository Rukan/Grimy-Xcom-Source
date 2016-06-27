class GrimyClass_MarkedAbilitySet extends X2Ability_AdventCaptain config (GrimyClassMod);

var config int DRAW_FIRE_DEFENSE_BOOST, DRAW_FIRE_DEFENSE_REDUCTION, DRAW_FIRE_COOLDOWN, DRAW_FIRE_DURATION, DRAW_FIRE_RADIUS, DRAW_FIRE_ARMOR;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(GrimyDrawFire('GrimyDrawFire',default.DRAW_FIRE_COOLDOWN,default.DRAW_FIRE_DEFENSE_BOOST,default.DRAW_FIRE_DEFENSE_REDUCTION,default.DRAW_FIRE_DURATION,default.DRAW_FIRE_RADIUS, default.DRAW_FIRE_ARMOR));

	return Templates;
}

static function X2AbilityTemplate GrimyDrawFire(name TemplateName, int ThisCooldown, int DefenseBoost, int DefenseReduction, int Duration, int Radius, int Armor) {
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCooldown Cooldown;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2AbilityTrigger_PlayerInput InputTrigger;
	local X2Effect_PersistentStatChange DefenseEffect;
	local X2AbilityMultiTarget_Radius MultiTarget;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = true;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventshieldbearer_energyshield";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Defensive;

	// This ability is a free action
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = ThisCooldown;
	Template.AbilityCooldown = Cooldown;

	//Can't use while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Add dead eye to guarantee
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	// Multi target
	MultiTarget = new class'X2AbilityMultiTarget_Radius';
	MultiTarget.fTargetRadius = Radius;
	MultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = MultiTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	// The Targets must be within the AOE, LOS, and friendly
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeCivilian = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);

	// Friendlies in the radius receives a shield receives a shield
	DefenseEffect = new class'X2Effect_PersistentStatChange';
	DefenseEffect.BuildPersistentEffect(Duration, false, true, , eGameRule_PlayerTurnEnd);
	DefenseEffect.AddPersistentStatChange(eStat_Defense, DefenseBoost);
	Template.AddMultiTargetEffect(DefenseEffect);

	DefenseEffect = new class'X2Effect_PersistentStatChange';
	DefenseEffect.BuildPersistentEffect(Duration, false, true, , eGameRule_PlayerTurnEnd);
	DefenseEffect.AddPersistentStatChange(eStat_Defense, DefenseReduction);
	Template.AddShooterEffect(DefenseEffect);

	// Armor Effect
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(Duration, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, Armor);
	Template.AddShooterEffect(PersistentStatChangeEffect);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(Duration, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorChance, 100);
	Template.AddShooterEffect(PersistentStatChangeEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TargetGettingMarked_BuildVisualization;
	
	return Template;
}