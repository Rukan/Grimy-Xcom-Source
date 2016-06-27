class Grimy_CutContentAmmo_Ability extends X2Ability dependson (XComGameStateContext_Ability) config(CutContentAmmo);

var config int FALCON_BONUS_DAMAGE;
var config int FALCON_DODGE_PIERCING;

var config int FLECHETTE_BONUS_DAMAGE_PER_TIER;
var config int FLECHETTE_BONUS_DAMAGE_NO_TIER;

var config int NEEDLE_BONUS_DAMAGE_PER_TIER;
var config int NEEDLE_BONUS_DAMAGE_NO_TIER;

var config int STILETTO_BONUS_DAMAGE_PER_TIER;
var config int STILETTO_BONUS_DAMAGE_NO_TIER;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(GrimyFalconRounds());
	Templates.AddItem(GrimyFlechetteRounds());
	Templates.AddItem(GrimyNeedleRounds());
	Templates.AddItem(GrimyStilettoRounds());
	Templates.AddItem(GrimyRedscreenRounds());

	return Templates;
}

static function X2AbilityTemplate GrimyFalconRounds()
{
	local X2AbilityTemplate             Template;
	local Grimy_Effect_FalconRounds     Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyFalconRounds');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'Grimy_Effect_FalconRounds';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Effect.BonusDamage = default.FALCON_BONUS_DAMAGE;
	Effect.DodgePiercing = default.FALCON_DODGE_PIERCING;
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyFlechetteRounds()
{
	local X2AbilityTemplate             Template;
	local Grimy_Effect_FlechetteRounds  Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyFlechetteRounds');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'Grimy_Effect_FlechetteRounds';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Effect.BonusDamagePerTier = default.FLECHETTE_BONUS_DAMAGE_PER_TIER;
	Effect.BonusDamageNoTier = default.FLECHETTE_BONUS_DAMAGE_NO_TIER;
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyNeedleRounds()
{
	local X2AbilityTemplate             Template;
	local Grimy_Effect_NeedleRounds     Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyNeedleRounds');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'Grimy_Effect_NeedleRounds';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Effect.BonusDamagePerTier = default.NEEDLE_BONUS_DAMAGE_PER_TIER;
	Effect.BonusDamageNoTier = default.NEEDLE_BONUS_DAMAGE_NO_TIER;
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyStilettoRounds()
{
	local X2AbilityTemplate             Template;
	local Grimy_Effect_StilettoRounds   Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyStilettoRounds');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'Grimy_Effect_StilettoRounds';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Effect.BonusDamagePerTier = default.STILETTO_BONUS_DAMAGE_PER_TIER;
	Effect.BonusDamageNoTier = default.STILETTO_BONUS_DAMAGE_NO_TIER;
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyRedscreenRounds()
{
	local X2AbilityTemplate					Template;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyRedscreenRounds');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}