class GrimyClassRebalance_AbilitySet extends X2Ability_DefaultAbilitySet config(GrimyClassRebalance);

var config int Version;
var config int GUNSMACK_DAMAGE, GUNSMACK_SPREAD, GUNSMACK_CHANCE;
var config int FLUSH_AIM;
var config float FLUSH_DAMAGE;
var config bool FLUSH_ON_MISS;
var config float SITUATIONAL_AWARENESS_TIME;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;

	Templates.AddItem(GrimyGunSmackPassive('GrimyGunSmackPassive'));
	Templates.AddItem(GrimyGunSmack('GrimyGunSmack', GetGunsmackDamage(), GetGunsmackSpread(), GetGunsmackChance()));
	Templates.AddItem(GrimyFlush('GrimyFlush',GetFlushAim(),default.FLUSH_ON_MISS,"img:///UILibrary_PerkIcons.UIPerk_flush"));
	Templates.AddItem(GrimyFlushDamage('GrimyFlushDamage',GetFlushDamage()));
	Templates.AddItem(PurePassive('GrimyMayhem', "img:///UILibrary_PerkIcons.UIPerk_mayhem", true));
	Templates.AddItem(GrimyBonusTime('GrimySituationalAwareness'));

	return Templates;
}

//img:///UILibrary_PerkIcons.UIPerk_mayhem
//img:///UILibrary_PerkIcons.UIPerk_closecombatspecialist
//img:///UILibrary_PerkIcons.UIPerk_wholenineyards -> supply protocol
//img:///UILibrary_PerkIcons.UIPerk_spotter -> keep watch
//img:///UILibrary_PerkIcons.UIPerk_savior -> triage protocol
//img:///UILibrary_PerkIcons.UIPerk_readyforanything -> coordinate fire
//img:///UILibrary_PerkIcons.UIPerk_quadricepshypertrophy -> situational awareness
//img:///UILibrary_PerkIcons.UIPerk_sedation -> it's a needle? maybe some use
//+BONUS_AMMO_ABILITIES=(AbilityName=GrimyCollateral, ammo = 4, bPrimary = true)
//+BONUS_AMMO_ABILITIES=(AbilityName=GrimyMayhem, ammo = 4, bPrimary = true)

static function int GetGunsmackDamage() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.GUNSMACK_DAMAGE > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.GUNSMACK_DAMAGE;
	else
		return default.GUNSMACK_DAMAGE;
}

static function int GetGunsmackSpread() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.GUNSMACK_SPREAD > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.GUNSMACK_SPREAD;
	else
		return default.GUNSMACK_SPREAD;
}

static function int GetGunsmackChance() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.GUNSMACK_CHANCE > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.GUNSMACK_CHANCE;
	else
		return default.GUNSMACK_CHANCE;
}

static function int GetFlushAim() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.FLUSH_AIM > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.FLUSH_AIM;
	else
		return default.FLUSH_AIM;
}

static function float GetFlushDamage() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.FLUSH_DAMAGE != 0.0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.FLUSH_DAMAGE;
	else
		return default.FLUSH_DAMAGE;
}

static function X2DataTemplate GrimyBonusTime(name TemplateName) {
	local X2AbilityTemplate									Template;
	local GrimyClassRebalance_Effect_BonusTime				BonusTimeEffect;

	Template = PurePassive(TemplateName, "img:///UILibrary_PerkIcons.UIPerk_quadricepshypertrophy", true);

	BonusTimeEffect = new class'GrimyClassRebalance_Effect_BonusTime';
	BonusTimeEffect.BuildPersistentEffect(1, true, true, , eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(BonusTimeEffect);

	return Template;
}

static function X2AbilityTemplate GrimyFlush(name TemplateName, int akAimBonus, bool akFlushOnMiss, string akIconImage) {
	local X2AbilityTemplate						Template;
	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2AbilityCost_Ammo					AmmoCost;
	local GrimyClassRebalance_Effect_Scamper	ScamperEffect;
	local X2AbilityToHitCalc_StandardAim		ToHitCalc;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);

	Template.AdditionalAbilities.AddItem('GrimyFlushDamage');

	ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[0]);
	ActionPointCost.iNumPoints = 0;
	ActionPointCost.bAddWeaponTypicalCost = true;
	Template.AbilityCosts[0] = ActionPointCost;
	
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 2;
	Template.AbilityCosts[1] = AmmoCost;
	
	ToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	ToHitCalc.BuiltInHitMod = akAimBonus;
	Template.AbilityToHitCalc = ToHitCalc;
	Template.AbilityToHitOwnerOnMissCalc = ToHitCalc;

	Template.IconImage = akIconImage;

	ScamperEffect = new class'GrimyClassRebalance_Effect_Scamper';
	ScamperEffect.bApplyOnMiss = akFlushOnMiss;
	Template.AddTargetEffect(ScamperEffect);

	return Template;
}

static function X2AbilityTemplate GrimyFlushDamage(name TemplateName, float akDamageMult)
{
	local X2AbilityTemplate							Template;
	local GrimyClassRebalance_Effect_FlushDamage	DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassRebalance_Effect_FlushDamage';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.DamageMultiplier = akDamageMult;
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false,,Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2DataTemplate GrimyGunSmackPassive(name TemplateName) {
	local X2AbilityTemplate									Template;

	Template = PurePassive(TemplateName, "img:///UILibrary_PerkIcons.UIPerk_muton_punch",,,false);
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.AdditionalAbilities.AddItem('GrimyGunSmack');

	return Template;
}


static function X2AbilityTemplate GrimyGunSmack(name TemplateName, int akDamage, int akSpread, int akStunChance) {
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	//local X2Condition_UnitEffects           UnitEffectsCondition;
	local X2Condition_UnitProperty			UnitPropertyCondition;
	local X2Effect_Stunned				    StunnedEffect;
	local array<name>                       SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.bDontDisplayInAbilitySummary = false;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.CustomFireAnim = 'FF_Melee';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_muton_punch";
	Template.AbilityConfirmSound = "TacticalUI_SwordConfirm";

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityTargetStyle = new class'X2AbilityTarget_MovingMelee';
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	//UnitPropertyCondition = new class'X2Condition_UnitProperty';
	//UnitPropertyCondition.ExcludeFriendlyToSource = true;
	//Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Damage Effect
	//
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.EffectDamageValue.Damage = akDamage;
	WeaponDamageEffect.EffectDamageValue.Spread = akSpread;
	WeaponDamageEffect.EffectDamageValue.DamageType = '';
	Template.AddTargetEffect(WeaponDamageEffect);

	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, akStunChance);
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeRobotic = true;
	StunnedEffect.TargetConditions.Additem(UnitPropertyCondition);
	Template.AddTargetEffect(StunnedEffect);

	Template.bAllowBonusWeaponEffects = false;
	Template.bSkipMoveStop = true;
	
	// Voice events
	//
	Template.SourceMissSpeech = 'SwordMiss';

	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;

	return Template;
}