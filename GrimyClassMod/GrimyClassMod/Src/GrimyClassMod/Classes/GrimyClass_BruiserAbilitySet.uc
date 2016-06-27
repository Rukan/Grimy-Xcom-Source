class GrimyClass_BruiserAbilitySet extends X2Ability config (GrimyClassMod);

var config int GUNPOINT_COOLDOWN, GUNPOINT_AIM, GUNPOINT_DAMAGE, GUNPOINT_SPREAD, GUNPOINT_STUN_DURATION, GUNPOINT_STUN_CHANCE;
var config int FLASHPOINT_DAMAGE, FLASHBANG_AMMO_BONUS, RETURN_FIRE_COUNT;
var config int BOLSTER_ARMOR, BOLSTER_ARMOR_DURATION;
var config bool GUNPOINT_GENERATES_HIGH_COVER;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(GrimyGunPoint('GrimyGunPoint', "img:///UILibrary_PerkIcons.UIPerk_bullrush", default.GUNPOINT_COOLDOWN, default.GUNPOINT_DAMAGE, default.GUNPOINT_Spread, default.BOLSTER_ARMOR, default.BOLSTER_ARMOR_Duration));
	Templates.AddItem(GrimyGunPoint('GrimyGunPointBsc', "img:///UILibrary_PerkIcons.UIPerk_bullrush", 0, default.GUNPOINT_DAMAGE, default.GUNPOINT_Spread, default.BOLSTER_ARMOR, default.BOLSTER_ARMOR_Duration, 1));
	Templates.AddItem(GrimyGunPoint('GrimyGunPointAdv', "img:///UILibrary_PerkIcons.UIPerk_bullrush", 0, default.GUNPOINT_DAMAGE, default.GUNPOINT_Spread, default.BOLSTER_ARMOR, default.BOLSTER_ARMOR_Duration, 2));
	Templates.AddItem(GrimyGunPoint('GrimyGunPointSup', "img:///UILibrary_PerkIcons.UIPerk_bullrush", 0, default.GUNPOINT_DAMAGE, default.GUNPOINT_Spread, default.BOLSTER_ARMOR, default.BOLSTER_ARMOR_Duration, 3));
	//Templates.AddItem(PurePassive('GrimySurvival', "img:///UILibrary_PerkIcons.UIPerk_battlefatigue"));
	//Templates.AddItem(PurePassive('GrimySpotter', "img:///UILibrary_PerkIcons.UIPerk_advent_marktarget"));
	Templates.Additem(GrimyReturnFire('GrimySurvival', "img:///UILibrary_PerkIcons.UIPerk_battlefatigue"));
	Templates.AddItem(GrimyReturnFire('GrimySpotter', "img:///UILibrary_PerkIcons.UIPerk_advent_marktarget"));
	Templates.AddItem(PurePassive('GrimyBolsterPassive', "img:///UILibrary_PerkIcons.UIPerk_body_shield"));
	Templates.AddItem(PurePassive('GrimyNeedlePointPassive', "img:///UILibrary_PerkIcons.UIPerk_ammo_fletchette"));
	Templates.AddItem(GrimyFlashpoint('GrimyFlashpoint', "img:///UILibrary_PerkIcons.UIPerk_ace_hole", default.FLASHPOINT_DAMAGE, default.FLASHBANG_AMMO_BONUS));
	Templates.AddItem(PurePassive('GrimyIntimidationPassive', "img:///UILibrary_PerkIcons.UIPerk_intimidate"));

	Templates.AddItem(GrimyEnrage('GrimyEnrage', "img:///UILibrary_PerkIcons.UIPerk_beserker_rage"));

	return Templates;
}

static function X2AbilityTemplate GrimyReturnFire(name TemplateName, string IconImage) {
	local X2AbilityTemplate						Template;
	local GrimyClass_Effect_CoveringFire                   FireEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = false;
	Template.IconImage = IconImage;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_UnitPostBeginPlay');

	FireEffect = new class'GrimyClass_Effect_CoveringFire';
	FireEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	FireEffect.MaxPointsPerTurn = default.RETURN_FIRE_COUNT;
	FireEffect.bPreEmptiveFire = true;
	FireEffect.bOncePerTarget = true;
	FireEffect.GameStateEffectClass = class'GrimyClass_EffectState';
	FireEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	Template.AddTargetEffect(FireEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	Template.bCrossClassEligible = false;       //  this can only work with pistols, which only sharpshooters have

	return Template;
}

static function X2DataTemplate GrimyGunPoint(name TemplateName, string IconImage, int ThisCooldown, int Damage, int Spread, int Armor, int ArmorDuration, optional int BonusCharges = 0) {
	local X2AbilityTemplate                 Template;
	local GrimyClass_Cost_ActionPoints		ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee  StandardMelee;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local X2Condition_UnitEffects           UnitEffectsCondition;
	local X2Effect_Stunned				    StunnedEffect;
	local X2AbilityCooldown					Cooldown;

	local X2Effect_GenerateCover			CoverEffect;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect, PoisonEffect;
	local X2Condition_AbilityProperty		AbilityCondition;
	
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.bDontDisplayInAbilitySummary = false;

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.CustomFireAnim = 'FF_Melee';
	Template.IconImage = IconImage;
	Template.AbilityConfirmSound = "TacticalUI_SwordConfirm";

	// Action Points
	ActionPointCost = new class'GrimyClass_Cost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.BonusPoint = 'GrimyGunpoint';
	Template.AbilityCosts.AddItem(ActionPointCost);

	// Cooldown
	if ( ThisCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = ThisCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	if ( BonusCharges > 0 )
	{
		Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		Template.HideErrors.AddItem('AA_CannotAfford_Charges');
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}
	
	StandardMelee = new class'X2AbilityToHitCalc_StandardMelee';
	StandardMelee.BuiltInHitMod = default.GUNPOINT_AIM;
	Template.AbilityToHitCalc = StandardMelee;

	Template.AbilityTargetStyle = new class'X2AbilityTarget_MovingMelee';
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	// Target Conditions
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(new class'GrimyClass_ConditionCover');
	Template.AbilityTargetConditions.AddItem(new class'X2Condition_UnitProperty');

	// Shooter Conditions
	UnitEffectsCondition = new class'X2Condition_UnitEffects';
	UnitEffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BoundName, 'AA_UnitIsBound');
	UnitEffectsCondition.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_CarryingUnit');
	Template.AbilityShooterConditions.AddItem(UnitEffectsCondition);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.EffectDamageValue.Damage = Damage;
	WeaponDamageEffect.EffectDamageValue.Spread = Spread;
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Melee';
	Template.AddTargetEffect(WeaponDamageEffect);

	// Stunned effect
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.GUNPOINT_STUN_DURATION, default.GUNPOINT_STUN_CHANCE);
	StunnedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(StunnedEffect);

	// Cover Effect
	CoverEffect = new class'X2Effect_GenerateCover';
	if ( !default.GUNPOINT_GENERATES_HIGH_COVER ) {	CoverEffect.CoverType = CoverForce_Low; }
	CoverEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	CoverEffect.bRemoveWhenTargetDies = true;
	Template.AddTargetEffect(CoverEffect);

	// Poison Effect
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyNeedlePointPassive');
	PoisonEffect = class'X2StatusEffects'.static.CreatePoisonedStatusEffect();
	X2Effect_ApplyWeaponDamage(PoisonEffect.ApplyOnTick[0]).EffectDamageValue.Damage = 2;
	PoisonEffect.EffectTickedFn = none;
	PoisonEffect.TargetConditions.AddItem(AbilityCondition);
	X2Effect_ApplyWeaponDamage(PoisonEffect.ApplyOnTick[0]).bAllowFreeKill = false;
	Template.AddTargetEffect(PoisonEffect);

	// Armor Effect
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyBolsterPassive');

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(ArmorDuration, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, Armor);
	PersistentStatChangeEffect.TargetConditions.AddItem(AbilityCondition);
	Template.AddShooterEffect(PersistentStatChangeEffect);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(ArmorDuration, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorChance, 100);
	PersistentStatChangeEffect.TargetConditions.AddItem(AbilityCondition);
	Template.AddShooterEffect(PersistentStatChangeEffect);

	Template.bAllowBonusWeaponEffects = true;
	Template.bSkipMoveStop = true;
	
	// Voice events
	Template.SourceMissSpeech = 'SwordMiss';

	Template.BuildNewGameStateFn = BruiserMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;

	return Template;
}

// Updates the bruiser to take cover
static function XComGameState BruiserMoveEndAbility_BuildGameState(XComGameStateContext Context) {
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateContext_Ability AbilityContext;
	local X2EventManager EventManager;
	
	EventManager = `XEVENTMGR;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);

	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());

	// finalize the movement portion of the ability
	class'X2Ability_DefaultAbilitySet'.static.MoveAbility_FillOutGameState(NewGameState, false); //Do not apply costs at this time.

	// build the "fire" animation for the slash
	TypicalAbility_FillOutGameState(NewGameState); //Costs applied here.
	
	UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));
	EventManager.TriggerEvent('UnitMoveFinished', UnitState, UnitState, NewGameState);

	/*
	Context.InputContext.SourceObject.ObjectID

	if( UnitState.CanTakeCover() )
	{
		NewContext = class'XComGameStateContext_TacticalGameRule'.static.BuildContextFromGameRule(eGameRule_ClaimCover);
		NewContext.UnitRef = UnitState.GetReference();
		`XCOMGAME.GameRuleset.SubmitGameStateContext(NewContext);
	}*/

	return NewGameState;
}

static function X2AbilityTemplate GrimyFlashpoint(name TemplateName, string IconImage, int BonusDamage, int Bonus) {
	local X2AbilityTemplate						Template;
	local X2AbilityTargetStyle                  TargetStyle;
	local X2AbilityTrigger						Trigger;
	local GrimyClass_Effect_BonusWeaponDamage	MixEffect;
	local GrimyClass_Effect_BonusItemCharges		AmmoEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = true;

	// Icon Properties
	Template.IconImage = IconImage;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	MixEffect = new class'GrimyClass_Effect_BonusWeaponDamage';
	MixEffect.BuildPersistentEffect(1, true, true, true);
	MixEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	MixEffect.Bonus = BonusDamage;
	MixEffect.WeaponName = 'FlashbangGrenade';
	Template.AddTargetEffect(MixEffect);

	AmmoEffect = new class'GrimyClass_Effect_BonusItemCharges';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	AmmoEffect.AmmoCount = Bonus;
	AmmoEffect.ItemTemplateNames.AddItem('FlashbangGrenade');
	Template.AddTargetEffect(AmmoEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyEnrage(name TemplateName, string IconImage) {
	local X2AbilityTemplate						Template;
	local GrimyClass_EnrageActionPoints			ThreeActionPoints;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = IconImage;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	
	ThreeActionPoints = new class'GrimyClass_EnrageActionPoints';
	ThreeActionPoints.ActionPointType = class'X2CharacterTemplateManager'.default.RunAndGunActionPoint;
	ThreeActionPoints.NumActionPoints = 1;
	Template.AddTargetEffect(ThreeActionPoints);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

