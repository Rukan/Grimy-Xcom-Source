class GrimyClass_WeaponAbilitySet extends X2Ability config (GrimyClassMod);

var config int TASER_AMMO_COUNT, CAUSTIC_AMMO_COUNT, GRAPESHOT_AMMO_COUNT;
var config int GRAPESHOT_TILE_WIDTH, GRAPESHOT_TILE_LENGTH, GRAPE_BURN_DMG, GRAPE_BURN_SPREAD;
var config int TASER_STUN_DURATION, TASER_STUN_CHANCE, CAUSTIC_SLUG_SHRED; 
var config float TASER_DAMAGE_MULT, CAUSTIC_DAMAGE_MULT, GRAPESHOT_DAMAGE_MULT;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(GrimyTaserShot('GrimyTaserShot', 'GrimyTaserShotDamage', "img:///UILibrary_PerkIcons.UIPerk_ammo_bluescreen",default.TASER_AMMO_COUNT));
	Templates.AddItem(GrimyGrapeShot('GrimyGrapeShot', 'GrimyGrapeShotDamage', "img:///UILibrary_PerkIcons.UIPerk_ammo_talon",default.GRAPESHOT_AMMO_COUNT));
	Templates.AddItem(GrimyCausticSlug('GrimyCausticSlug', 'GrimyCausticSlugDamage', "img:///UILibrary_PerkIcons.UIPerk_ammo_needle", default.CAUSTIC_AMMO_COUNT, default.CAUSTIC_SLUG_SHRED));

	Templates.AddItem(GrimyBonusDamage('GrimyTaserShotDamage','GrimyTaserShot',default.TASER_DAMAGE_MULT,false,true));
	Templates.AddItem(GrimyBonusDamage('GrimyGrapeShotDamage','GrimyGrapeShot',default.GRAPESHOT_DAMAGE_MULT,true,false));
	Templates.AddItem(GrimyBonusDamage('GrimyCausticSlugDamage','GrimyCausticSlug',default.CAUSTIC_DAMAGE_MULT));
	
	Templates.AddItem(GrimyTaserShot('GrimyTaserShotBsc', 'GrimyTaserShotDamageBsc', "img:///UILibrary_PerkIcons.UIPerk_ammo_bluescreen",1));
	Templates.AddItem(GrimyGrapeShot('GrimyGrapeShotBsc', 'GrimyGrapeShotDamageBsc', "img:///UILibrary_PerkIcons.UIPerk_ammo_talon",1));
	Templates.AddItem(GrimyCausticSlug('GrimyCausticSlugBsc', 'GrimyCausticSlugDamageBsc', "img:///UILibrary_PerkIcons.UIPerk_ammo_needle", 1, default.CAUSTIC_SLUG_SHRED));

	Templates.AddItem(GrimyBonusDamage('GrimyTaserShotDamageBsc','GrimyTaserShotBsc',default.TASER_DAMAGE_MULT,false,true));
	Templates.AddItem(GrimyBonusDamage('GrimyGrapeShotDamageBsc','GrimyGrapeShotBsc',default.GRAPESHOT_DAMAGE_MULT,true,false));
	Templates.AddItem(GrimyBonusDamage('GrimyCausticSlugDamageBsc','GrimyCausticSlugBsc',default.CAUSTIC_DAMAGE_MULT));
	
	Templates.AddItem(GrimyTaserShot('GrimyTaserShotAdv', 'GrimyTaserShotDamageAdv', "img:///UILibrary_PerkIcons.UIPerk_ammo_bluescreen",2));
	Templates.AddItem(GrimyGrapeShot('GrimyGrapeShotAdv', 'GrimyGrapeShotDamageAdv', "img:///UILibrary_PerkIcons.UIPerk_ammo_talon",2));
	Templates.AddItem(GrimyCausticSlug('GrimyCausticSlugAdv', 'GrimyCausticSlugDamageAdv', "img:///UILibrary_PerkIcons.UIPerk_ammo_needle", 2, default.CAUSTIC_SLUG_SHRED));

	Templates.AddItem(GrimyBonusDamage('GrimyTaserShotDamageAdv','GrimyTaserShotAdv',default.TASER_DAMAGE_MULT,false,true));
	Templates.AddItem(GrimyBonusDamage('GrimyGrapeShotDamageAdv','GrimyGrapeShotAdv',default.GRAPESHOT_DAMAGE_MULT,true,false));
	Templates.AddItem(GrimyBonusDamage('GrimyCausticSlugDamageAdv','GrimyCausticSlugAdv',default.CAUSTIC_DAMAGE_MULT));
	
	Templates.AddItem(GrimyTaserShot('GrimyTaserShotSup', 'GrimyTaserShotDamageSup', "img:///UILibrary_PerkIcons.UIPerk_ammo_bluescreen",3));
	Templates.AddItem(GrimyGrapeShot('GrimyGrapeShotSup', 'GrimyGrapeShotDamageSup', "img:///UILibrary_PerkIcons.UIPerk_ammo_talon",3));
	Templates.AddItem(GrimyCausticSlug('GrimyCausticSlugSup', 'GrimyCausticSlugDamageSup', "img:///UILibrary_PerkIcons.UIPerk_ammo_needle", 3, default.CAUSTIC_SLUG_SHRED));

	Templates.AddItem(GrimyBonusDamage('GrimyTaserShotDamageSup','GrimyTaserShotSup',default.TASER_DAMAGE_MULT,false,true));
	Templates.AddItem(GrimyBonusDamage('GrimyGrapeShotDamageSup','GrimyGrapeShotSup',default.GRAPESHOT_DAMAGE_MULT,true,false));
	Templates.AddItem(GrimyBonusDamage('GrimyCausticSlugDamageSup','GrimyCausticSlugSup',default.CAUSTIC_DAMAGE_MULT));

	return Templates;
}

static function X2AbilityTemplate GrimyTaserShot(name TemplateName, name BonusName, string IconImage, int BonusCharges)
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local array<name>                       SkipExclusions;
	local X2Effect_Knockback				KnockbackEffect;
	
	local X2Condition_AbilityProperty		AbilityCondition;
	local X2Effect_PersistentStatChange		PoisonEffect;
	local X2Condition_UnitProperty			UnitPropCondition;
	local X2Effect_Stunned				    StunnedEffect;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;

	// Macro to do localisation and stuffs
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AdditionalAbilities.AddItem(BonusName);

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyNeedlePointPassive');
	PoisonEffect = class'X2StatusEffects'.static.CreatePoisonedStatusEffect();
	PoisonEffect.EffectTickedFn = none;
	PoisonEffect.TargetConditions.AddItem(AbilityCondition);
	X2Effect_ApplyWeaponDamage(PoisonEffect.ApplyOnTick[0]).bAllowFreeKill = false;
	Template.AddTargetEffect(PoisonEffect);
	
	// Stunned effect
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.TASER_STUN_DURATION, default.TASER_STUN_CHANCE);
	StunnedEffect.bRemoveWhenSourceDies = false;

	UnitPropCondition = new class'X2Condition_UnitProperty';
	UnitPropCondition.ExcludeRobotic = true;
	StunnedEffect.TargetConditions.AddItem(UnitPropCondition);

	Template.AddTargetEffect(StunnedEffect);

	if ( BonusCharges > 0 )
	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	// Icon Properties
	Template.bDontDisplayInAbilitySummary = true;
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.DisplayTargetHitChance = true;
	Template.AbilitySourceName = 'eAbilitySource_Perk';                                       // color of the icon
	Template.bHideOnClassUnlock = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;

	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// *** VALIDITY CHECKS *** //
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Targeting Details
	// Can only shoot visible enemies
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	// Can't target dead; Can't target friendlies
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	// Only at single targets that are in range.
	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_QuickdrawActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ACtionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	Template.AbilityCosts.AddItem(ActionPointCost);	

	// Ammo
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true; // 	

	// Weapon Upgrade Compatibility
	Template.bAllowFreeFireWeaponUpgrade = true;                                            // Flag that permits action to become 'free action' via 'Hair Trigger' or similar upgrade / effects

	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Electrical';
	WeaponDamageEffect.EffectDamageValue.Pierce = 1000;
	Template.AddTargetEffect(WeaponDamageEffect);

	// Hit Calculation (Different weapons now have different calculations for range)
	Template.AbilityToHitCalc = default.SimpleStandardAim;
	Template.AbilityToHitOwnerOnMissCalc = default.SimpleStandardAim;
		
	// Targeting Method
	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";

	// MAKE IT LIVE!
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;	
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	KnockbackEffect.bUseTargetLocation = true;
	Template.AddTargetEffect(KnockbackEffect);

	return Template;	
}

static function X2AbilityTemplate GrimyGrapeShot(name TemplateName, name BonusName, string IconImage, int BonusCharges)
{
	local X2AbilityTemplate						Template;	
	local X2AbilityCost_Ammo					AmmoCost;
	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2AbilityTarget_Cursor				CursorTarget;
	local X2AbilityMultiTarget_Cone				ConeMultiTarget;
	local X2Condition_UnitProperty				UnitPropertyCondition;
	local X2AbilityToHitCalc_StandardAim		StandardAim;
	local X2Effect_ApplyDirectionalWorldDamage	WorldDamage;
	local X2Effect_ApplyWeaponDamage			WeaponDamageEffect;
	local X2AbilityCharges						Charges;
	local X2AbilityCost_Charges					ChargeCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = true;

	if ( BonusCharges > 0 )
	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	Template.AdditionalAbilities.AddItem(BonusName);
	
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bMultiTargetOnly = true;
	Template.AbilityToHitCalc = StandardAim;
	
	WeaponDamageEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect();
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Fire';
	Template.AddMultiTargetEffect(WeaponDamageEffect);
	Template.bOverrideAim = true;
	
	Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateBurningStatusEffect(default.GRAPE_BURN_DMG,default.GRAPE_BURN_SPREAD));

	WorldDamage = new class'X2Effect_ApplyDirectionalWorldDamage';
	WorldDamage.bUseWeaponDamageType = true;
	WorldDamage.bUseWeaponEnvironmentalDamage = true;
	WorldDamage.bApplyOnHit = true;
	WorldDamage.bApplyOnMiss = true;
	WorldDamage.bApplyToWorldOnHit = false;
	WorldDamage.bApplyToWorldOnMiss = false;
	WorldDamage.bHitAdjacentDestructibles = true;
	WorldDamage.PlusNumZTiles = 1;
	WorldDamage.bHitTargetTile = true;
	WorldDamage.ApplyChance = 100;
	Template.AddMultiTargetEffect(WorldDamage);
	
	CursorTarget = new class'X2AbilityTarget_Cursor';
	Template.AbilityTargetStyle = CursorTarget;	

	ConeMultiTarget = new class'X2AbilityMultiTarget_Cone';
	ConeMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	ConeMultiTarget.ConeEndDiameter = default.GRAPESHOT_TILE_WIDTH * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.bUseWeaponRangeForLength = false;
	ConeMultiTarget.ConeLength = default.GRAPESHOT_TILE_LENGTH * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.fTargetRadius = 99;     //  large number to handle weapon range - targets will get filtered according to cone constraints
	ConeMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = ConeMultiTarget;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	Template.AddShooterEffectExclusions();

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.IconImage = IconImage;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";

	Template.ActionFireClass = class'X2Action_Fire_SaturationFire';

	Template.TargetingMethod = class'X2TargetingMethod_Cone';

	Template.ActivationSpeech = 'SaturationFire';
	Template.CinescriptCameraType = "Grenadier_SaturationFire";
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;	
}

static function X2AbilityTemplate GrimyCausticSlug(name TemplateName, name BonusName, string IconImage, int BonusCharges, int BonusShred)
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local array<name>                       SkipExclusions;
	local X2AbilityToHitCalc_StandardAim    StandardAim;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	if ( BonusCharges > 0 )
	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	Template.AdditionalAbilities.AddItem(BonusName);
	
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	// Icon Properties
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.DisplayTargetHitChance = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";

	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// *** VALIDITY CHECKS *** //
	//  Normal effect restrictions (except disoriented)
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Targeting Details
	// Can only shoot visible enemies
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	// Can't target dead; Can't target friendlies
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	// Only at single targets that are in range.
	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);	

	Template.bAllowAmmoEffects = true;

	// Weapon Upgrade Compatibility
	Template.bAllowFreeFireWeaponUpgrade = true;                                            // Flag that permits action to become 'free action' via 'Hair Trigger' or similar upgrade / effects

	WeaponDamageEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect();
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Acid';
	WeaponDamageEffect.EffectDamageValue.Shred = BonusShred;
	Template.AddTargetEffect(WeaponDamageEffect);
	
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AssociatedPassives.AddItem('HoloTargeting');

	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bHitsAreCrits = true;
	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;
		
	// Targeting Method
	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";

	// Voice events
	Template.ActivationSpeech = 'BulletShred';

	// MAKE IT LIVE!
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;	

	Template.bCrossClassEligible = true;

	return Template;	
}


static function X2AbilityTemplate GrimyBonusDamage(name TemplateName, name AbilityName, float BonusDamage, optional bool ExcludeRobotic = false, optional bool ExcludeOrganic = false)
{
	local X2AbilityTemplate						Template;
	local GrimyClass_Effect_BonusAbilityDamage	DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClass_Effect_BonusAbilityDamage';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = BonusDamage;
	DamageEffect.AbilityName = AbilityName;
	DamageEffect.bExcludeRobotic = ExcludeRobotic;
	DamageEffect.bExcludeOrganic = ExcludeOrganic;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}