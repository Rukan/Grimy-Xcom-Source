class GrimyClassHH_HeadhunterAbilitySet extends X2Ability_SharpshooterAbilitySet config(GrimyClassHH);

var config int PIERCING_SHOT_CHARGES, PIERCING_SHOT_COOLDOWN;
var config int TWIN_FANG_CHARGES, TWIN_FANG_COOLDOWN;
var config int THUNDERCLAP_CHARGES, THUNDERCLAP_COOLDOWN;
var config int POINT_BLANK_AIM, POINT_BLANK_CRIT, POINT_BLANK_TILES;

var config int BUCKSHOT_CHARGES, BUCKSHOT_COOLDOWN;
var config int INCENDIARY_SHOT_CHARGES, INCENDIARY_SHOT_COOLDOWN;
var config int DOUBLE_TAP_COOLDOWN;
var config int HEXHUNTER_CHARGES;

var config float THUNDERCLAP_BONUS, INCENDIARY_SHOT_RADIUS, BUCKSHOT_DIAMETER, POINT_BLANK_BONUS, HEXHUNTER_BONUS, BUCKSHOT_BONUS, PIERCING_SHOT_BONUS;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;

	// SQUADDIE
	Templates.AddItem(GrimyPiercingShot('GrimyPiercingShot','GrimyPiercingShotBonus',"img:///GrimyClassHHPackage.UIPerk_PiercingShot",default.PIERCING_SHOT_CHARGES,default.PIERCING_SHOT_COOLDOWN,class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY));
	// CORPORAL
	Templates.AddItem(GrimyRushedShot('GrimyRushedShot',"img:///UILibrary_PerkIcons.UIPerk_targetpaint",class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY));
	// SERGEANT	
	Templates.AddItem(GrimyThunderclap('GrimyThunderclap','GrimyThunderclapBonus',"img:///GrimyClassHHPackage.UIPerk_Thunderclap",default.THUNDERCLAP_CHARGES,default.THUNDERCLAP_COOLDOWN,class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY,true));
	Templates.AddItem(GrimyPointBlank('GrimyPointBlank',"img:///UILibrary_PerkIcons.UIPerk_scope", default.POINT_BLANK_TILES,class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY));
	
	// CAPTAIN
	Templates.AddItem(GrimyIncendiaryShot('GrimyIncendiaryShot',"img:///GrimyClassHHPackage.UIPerk_IncendiaryShot",default.INCENDIARY_SHOT_CHARGES,default.INCENDIARY_SHOT_COOLDOWN,default.INCENDIARY_SHOT_RADIUS,class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY,true));
	// MAJOR
	Templates.AddItem(GrimyTwinFangs('GrimyTwinFangs',"img:///GrimyClassHHPackage.UIPerk_TwinFangs",default.TWIN_FANG_CHARGES,default.TWIN_FANG_COOLDOWN,class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY,true));
	// COLONEL
	Templates.AddItem(GrimyBuckshot('GrimyBuckshot','GrimyBuckshotBonus',"img:///GrimyClassHHPackage.UIPerk_Buckshot",default.BUCKSHOT_CHARGES,default.BUCKSHOT_COOLDOWN,default.BUCKSHOT_DIAMETER,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY,true));
	Templates.AddItem(GrimyDoubleTap('GrimyDoubleTap',"img:///UILibrary_PerkIcons.UIPerk_doubletap",default.DOUBLE_TAP_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	
	// GTS
	Templates.AddItem(GrimyHexHunter('GrimyHexHunter','GrimyHexHunterBonus',"img:///UILibrary_PerkIcons.UIPerk_deathblossom",default.HEXHUNTER_CHARGES,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	
	// PASSIVES
	Templates.AddItem(GrimyPointBlankBonus('GrimyPointBlankBonus','GrimyPointBlank',default.POINT_BLANK_AIM, default.POINT_BLANK_CRIT, default.POINT_BLANK_BONUS));
	Templates.AddItem(GrimyThunderclapBonus('GrimyThunderclapBonus', 'GrimyThunderclap', default.THUNDERCLAP_BONUS));
	Templates.AddItem(GrimyHexHunterBonus('GrimyHexHunterBonus', 'GrimyHexHunter',"img:///UILibrary_PerkIcons.UIPerk_deathblossom", default.HEXHUNTER_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyPiercingShotBonus','GrimyPiercingShot', default.PIERCING_SHOT_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyBuckshotBonus','GrimyBuckshot', default.BUCKSHOT_BONUS));

	// LOOT
	Templates.AddItem(GrimyPiercingShot('GrimyPiercingShotBsc','GrimyPiercingShotBonusBsc',"img:///GrimyClassHHPackage.UIPerk_PiercingShot",1,0,class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY));
	Templates.AddItem(GrimyPiercingShot('GrimyPiercingShotAdv','GrimyPiercingShotBonusAdv',"img:///GrimyClassHHPackage.UIPerk_PiercingShot",2,0,class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY));
	Templates.AddItem(GrimyPiercingShot('GrimyPiercingShotSup','GrimyPiercingShotBonusSup',"img:///GrimyClassHHPackage.UIPerk_PiercingShot",3,0,class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY));
	Templates.AddItem(GrimyThunderclap('GrimyThunderclapBsc','GrimyThunderclapBonusBsc',"img:///GrimyClassHHPackage.UIPerk_Thunderclap",1,0,class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY));
	Templates.AddItem(GrimyThunderclap('GrimyThunderclapAdv','GrimyThunderclapBonusAdv',"img:///GrimyClassHHPackage.UIPerk_Thunderclap",2,0,class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY));
	Templates.AddItem(GrimyThunderclap('GrimyThunderclapSup','GrimyThunderclapBonusSup',"img:///GrimyClassHHPackage.UIPerk_Thunderclap",3,0,class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY));
	Templates.AddItem(GrimyIncendiaryShot('GrimyIncendiaryShotBsc',"img:///GrimyClassHHPackage.UIPerk_IncendiaryShot",1,0,default.INCENDIARY_SHOT_RADIUS,class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY));
	Templates.AddItem(GrimyIncendiaryShot('GrimyIncendiaryShotAdv',"img:///GrimyClassHHPackage.UIPerk_IncendiaryShot",2,0,default.INCENDIARY_SHOT_RADIUS,class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY));
	Templates.AddItem(GrimyIncendiaryShot('GrimyIncendiaryShotSup',"img:///GrimyClassHHPackage.UIPerk_IncendiaryShot",3,0,default.INCENDIARY_SHOT_RADIUS,class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY));
	Templates.AddItem(GrimyTwinFangs('GrimyTwinFangsBsc',"img:///GrimyClassHHPackage.UIPerk_TwinFangs",1,0,class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY));
	Templates.AddItem(GrimyTwinFangs('GrimyTwinFangsAdv',"img:///GrimyClassHHPackage.UIPerk_TwinFangs",2,0,class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY));
	Templates.AddItem(GrimyTwinFangs('GrimyTwinFangsSup',"img:///GrimyClassHHPackage.UIPerk_TwinFangs",3,0,class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY));
	Templates.AddItem(GrimyBuckshot('GrimyBuckshotBsc','GrimyBuckshotBonusBsc',"img:///GrimyClassHHPackage.UIPerk_Buckshot",1,0,default.BUCKSHOT_DIAMETER,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	Templates.AddItem(GrimyBuckshot('GrimyBuckshotAdv','GrimyBuckshotBonusAdv',"img:///GrimyClassHHPackage.UIPerk_Buckshot",2,0,default.BUCKSHOT_DIAMETER,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	Templates.AddItem(GrimyBuckshot('GrimyBuckshotSup','GrimyBuckshotBonusSup',"img:///GrimyClassHHPackage.UIPerk_Buckshot",3,0,default.BUCKSHOT_DIAMETER,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	Templates.AddItem(GrimyHexHunter('GrimyHexHunterBsc','GrimyHexHunterBonusBsc',"img:///UILibrary_PerkIcons.UIPerk_deathblossom",1,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY, true));
	Templates.AddItem(GrimyHexHunter('GrimyHexHunterAdv','GrimyHexHunterBonusAdv',"img:///UILibrary_PerkIcons.UIPerk_deathblossom",1,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY, true));
	Templates.AddItem(GrimyHexHunter('GrimyHexHunterSup','GrimyHexHunterBonusSup',"img:///UILibrary_PerkIcons.UIPerk_deathblossom",1,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY, true));

	Templates.AddItem(GrimyThunderclapBonus('GrimyThunderclapBonusBsc', 'GrimyThunderclapBsc', default.THUNDERCLAP_BONUS));
	Templates.AddItem(GrimyThunderclapBonus('GrimyThunderclapBonusAdv', 'GrimyThunderclapAdv', default.THUNDERCLAP_BONUS));
	Templates.AddItem(GrimyThunderclapBonus('GrimyThunderclapBonusSup', 'GrimyThunderclapSup', default.THUNDERCLAP_BONUS));
	Templates.AddItem(GrimyHexHunterBonus('GrimyHexHunterBonusBsc', 'GrimyHexHunterBsc',"img:///UILibrary_PerkIcons.UIPerk_deathblossom", default.HEXHUNTER_BONUS));
	Templates.AddItem(GrimyHexHunterBonus('GrimyHexHunterBonusAdv', 'GrimyHexHunterAdv',"img:///UILibrary_PerkIcons.UIPerk_deathblossom", default.HEXHUNTER_BONUS));
	Templates.AddItem(GrimyHexHunterBonus('GrimyHexHunterBonusSup', 'GrimyHexHunterSup',"img:///UILibrary_PerkIcons.UIPerk_deathblossom", default.HEXHUNTER_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyPiercingShotBonusBsc','GrimyPiercingShotBsc', default.PIERCING_SHOT_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyPiercingShotBonusAdv','GrimyPiercingShotAdv', default.PIERCING_SHOT_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyPiercingShotBonusSup','GrimyPiercingShotSup', default.PIERCING_SHOT_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyBuckshotBonusBsc','GrimyBuckshotBsc', default.BUCKSHOT_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyBuckshotBonusAdv','GrimyBuckshotAdv', default.BUCKSHOT_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimyBuckshotBonusSup','GrimyBuckshotSup', default.BUCKSHOT_BONUS));

	return Templates;
}

static function X2AbilityTemplate GrimyHexHunter(name TemplateName, name BonusAbility, string IconImage, int BonusCharges, int HUDPriority, optional bool IsUpgrade = false) {
	local X2AbilityTemplate					Template;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);
	
	Template.AbilityCosts.length = 0;

	if ( IsUpgrade ) {
		Template.AdditionalAbilities.AddItem(BonusAbility);
	}
	//else {
		//Template.AbilityCosts.AddItem(new class'GrimyClassHH_AbilityCost_HexHunter');
		//Template.HideErrors.AddItem('AA_MissingPerk');
	//}

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	//Template.HideErrors.AddItem('AA_CannotAfford_ActionPoints');
	Template.IconImage = IconImage; 
	Template.ShotHUDPriority = HUDPriority;


	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 2;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);	

	// Ammo
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	if ( BonusCharges > 0 )
	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	return Template;
}

static function X2AbilityTemplate GrimyDoubleTap(name TemplateName, string IconImage, int BonusCooldown, int HUDPriority)
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCooldown					Cooldown;
	local GrimyClassHH_AbilityCost_Rapid	ActionPointCost;
	
	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);
	Template.bCrossClassEligible = true;
	
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = HUDPriority;

	Template.AbilityCosts.length = 0;

	ActionPointCost = new class'GrimyClassHH_AbilityCost_Rapid';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.RefundActionPoint = 'standard';
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	if ( BonusCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = BonusCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	return Template;
}

static function X2AbilityTemplate GrimyCursorShot(name TemplateName, string IconImage, int BonusCharges, int BonusCooldown, int HUDPriority) {
	local X2AbilityTemplate                 Template;	
	local X2AbilityCooldown                 Cooldown;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local array<name>                       SkipExclusions;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;

	// Macro to do localisation and stuffs
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

	// Icon Properties
	Template.bDontDisplayInAbilitySummary = true;
	Template.IconImage = IconImage; // 
	Template.ShotHUDPriority = HUDPriority;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.DisplayTargetHitChance = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';                                       // color of the icon
	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	if ( BonusCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = BonusCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);	

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true; // 	

	Template.bAllowFreeFireWeaponUpgrade = true;                        // Flag that permits action to become 'free action' via 'Hair Trigger' or similar upgrade / effects
	
	Template.CinescriptCameraType = "StandardGunFiring";	

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;	
}

static function X2AbilityTemplate GrimyPiercingShot(name TemplateName, name BonusAbility, string IconImage, int BonusCharges, int BonusCooldown, int HUDPriority) {
	local X2AbilityTemplate                 Template;
	local X2AbilityTarget_Cursor            CursorTarget;
	local X2AbilityMultiTarget_Line			TargetStyle;

	Template = GrimyCursorShot(TemplateName, IconImage, BonusCharges, BonusCooldown, HUDPriority);
	Template.bCrossClassEligible = true;
	
	Template.AdditionalAbilities.AddItem(BonusAbility);

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	TargetStyle = new class'X2AbilityMultiTarget_Line';
	TargetStyle.bSightRangeLimited = true;
	Template.AbilityMultiTargetStyle = TargetStyle;

	Template.AddMultiTargetEffect(new class'GrimyClassHH_Effect_ShredTier');

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	Template.AbilityToHitOwnerOnMissCalc = new class'X2AbilityToHitCalc_StandardAim';
		
	Template.TargetingMethod = class'X2TargetingMethod_Line';

	return Template;	
}

static function X2AbilityTemplate GrimyBuckShot(name TemplateName, name BonusAbility, string IconImage, int BonusCharges, int BonusCooldown, float BonusDiameter, int HUDPriority, optional bool CrossClass= false) {
	local X2AbilityTemplate                 Template;
	local X2AbilityTarget_Cursor            CursorTarget;
	local X2AbilityMultiTarget_Cone			TargetStyle;
	
	Template = GrimyCursorShot(TemplateName, IconImage, BonusCharges, BonusCooldown, HUDPriority);
	Template.bCrossClassEligible = CrossClass;

	Template.AdditionalAbilities.AddItem(BonusAbility);
	
	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	TargetStyle = new class'X2AbilityMultiTarget_Cone';
	TargetStyle.bUseWeaponRangeForLength = true;
	TargetStyle.ConeEndDiameter = BonusDiameter * class'XComWorldData'.const.WORLD_StepSize;
	TargetStyle.bIgnoreBlockingCover = true;
	TargetStyle.bExcludeSelfAsTargetIfWithinRadius = true;
	Template.AbilityMultiTargetStyle = TargetStyle;

	Template.AddMultiTargetEffect(new class'GrimyClassHH_Effect_ShredTier');

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	Template.AbilityToHitOwnerOnMissCalc = new class'X2AbilityToHitCalc_StandardAim';
		
	Template.TargetingMethod = class'X2TargetingMethod_Cone';

	return Template;	
}

static function X2AbilityTemplate GrimyIncendiaryShot(name TemplateName, string IconImage, int BonusCharges, int BonusCooldown, float BonusRadius, int HUDPriority, optional bool CrossClass= false) {
	local X2AbilityTemplate                 Template;
	local X2AbilityTarget_Cursor            CursorTarget;
	local X2AbilityMultiTarget_Radius		TargetStyle;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	
	Template = GrimyCursorShot(TemplateName, IconImage, BonusCharges, BonusCooldown, HUDPriority);
	Template.bCrossClassEligible = CrossClass;
	
	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	TargetStyle = new class'X2AbilityMultiTarget_Radius';
	TargetStyle.fTargetRadius = BonusRadius;
	TargetStyle.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = TargetStyle;

	WeaponDamageEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect(); 
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Fire';
	WeaponDamageEffect.bExplosiveDamage = true;
	WeaponDamageEffect.bAllowWeaponUpgrade = true;
	Template.AddMultiTargetEffect(WeaponDamageEffect);
	Template.AddMultiTargetEffect(new class'X2Effect_ApplyFireToWorld');
	Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateBurningStatusEffect(2,1));

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityToHitOwnerOnMissCalc = default.DeadEye;
		
	Template.TargetingMethod = class'X2TargetingMethod_RocketLauncher';

	return Template;	
}

static function X2AbilityTemplate GrimyPointBlank(name TemplateName, string IconImage, int MaxDistance, int HUDPriority) {
	local X2AbilityTemplate						Template;	
	local GrimyClassHH_Condition_PointBlank		PointBlankCondition;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);
	Template.bCrossClassEligible = true;
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = HUDPriority;
	Template.AdditionalAbilities.AddItem('GrimyPointBlankBonus');

	PointBlankCondition = new class'GrimyClassHH_Condition_PointBlank';
	PointBlankCondition.MaxDistance = MaxDistance;
	Template.AbilityTargetConditions.AddItem(PointBlankCondition);

	return Template;
}

static function X2AbilityTemplate GrimyRandomShot(name TemplateName, string IconImage, int BonusCharges, int BonusCooldown, int NumTargets, int HUDPriority) {
	local X2AbilityTemplate                 Template;
	local X2AbilityCooldown                 Cooldown;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityToHitCalc_StandardAim    ToHitCalc;

	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;
	
	local GrimyClassHH_MultiTarget			GrimyTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	if ( BonusCharges > 0 )	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	Template.IconImage = IconImage;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.Hostility = eHostility_Offensive;
	Template.ShotHUDPriority = HUDPriority;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";

	if ( BonusCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = BonusCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	ToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	ToHitCalc.bOnlyMultiHitWithSuccess = false;
	Template.AbilityToHitCalc = ToHitCalc;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = NumTargets;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true; // 	

	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	GrimyTarget = new class'GrimyClassHH_MultiTarget';
	GrimyTarget.NumTargets = NumTargets;
	GrimyTarget.bAllowSameTarget = true;
	Template.AbilityMultiTargetStyle = GrimyTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);

	Template.BuildNewGameStateFn = MultiShotAbility_BuildGameState;
	Template.BuildVisualizationFn = CobraShot_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate GrimyTwinFangs(name TemplateName, string IconImage, int BonusCharges, int BonusCooldown, int HUDPriority, optional bool CrossClass = false) {
	local X2AbilityTemplate                 Template;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	
	Template = GrimyRandomShot(TemplateName, IconImage, BonusCharges, BonusCooldown, 2, HUDPriority);
	Template.bCrossClassEligible = CrossClass;

	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());	
	Template.AddMultiTargetEffect(default.WeaponUpgradeMissDamage);
	WeaponDamageEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect(); 
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Poison';
	Template.AddMultiTargetEffect(WeaponDamageEffect);
	Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

	Template.AddTargetEffect(WeaponDamageEffect); // No effect, present for the damage previewer

	return Template;
}

static function X2AbilityTemplate GrimyThunderClap(name TemplateName, name BonusAbility, string IconImage, int BonusCharges, int BonusCooldown, int HUDPriority, optional bool CrossClass = false) {
	local X2AbilityTemplate                 Template;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	
	Template = GrimyRandomShot(TemplateName, IconImage, BonusCharges, BonusCooldown, 1, HUDPriority);
	Template.bCrossClassEligible = CrossClass;

	Template.AdditionalAbilities.AddItem(BonusAbility);

	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());	
	Template.AddMultiTargetEffect(default.WeaponUpgradeMissDamage);
	WeaponDamageEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect(); 
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Electrical';
	Template.AddMultiTargetEffect(WeaponDamageEffect);

	Template.AddTargetEffect(WeaponDamageEffect); // No effect, present for the damage previewer

	return Template;
}

static function X2AbilityTemplate GrimyRushedShot(name TemplateName, string IconImage, int HUDPriority) {
	local X2AbilityTemplate                 Template;
	
	Template = GrimyRandomShot(TemplateName, IconImage, -1, -1, 1, HUDPriority);

	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());	
	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	Template.AddMultiTargetEffect(default.WeaponUpgradeMissDamage);
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect()); // No effect, present for the damage previewer
	
	//Template.BuildNewGameStateFn = MultiShotAbility_BuildGameState;
	//Template.BuildVisualizationFn = none;

	return Template;
}

// passive abilities

static function X2AbilityTemplate GrimyHexHunterBonus(name TemplateName, name AbilityName, string IconImage, float BonusDamage) {
	local X2AbilityTemplate						Template;
	local GrimyClassHH_Effect_BonusHexHunter	DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.IconImage = IconImage;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassHH_Effect_BonusHexHunter';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = BonusDamage;
	DamageEffect.AbilityName = AbilityName;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyThunderclapBonus(name TemplateName, name AbilityName, float BonusDamage) {
	local X2AbilityTemplate						Template;
	local GrimyClassHH_Effect_BonusThunderclap	DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassHH_Effect_BonusThunderclap';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = BonusDamage;
	DamageEffect.AbilityName = AbilityName;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyPointBlankBonus(name TemplateName, name AbilityName, int AimBonus, int CritBonus, float DamageBonus) {
	local X2AbilityTemplate						Template;
	local GrimyClassHH_Effect_BonusPointBlank	ShotEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	ShotEffect = new class'GrimyClassHH_Effect_BonusPointBlank';
	ShotEffect.BuildPersistentEffect(1, true, false, false);
	ShotEffect.AimBonus = AimBonus;
	ShotEffect.CritBonus = CritBonus;
	ShotEffect.DamageBonus = DamageBonus;
	ShotEffect.AbilityName = AbilityName;
	ShotEffect.FriendlyName = Template.LocFriendlyName;
	Template.AddTargetEffect(ShotEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	
	return Template;
}

static function X2AbilityTemplate GrimyBonusDamage(name TemplateName, name AbilityName, float BonusDamage) {
	local X2AbilityTemplate						Template;
	local GrimyClassHH_Effect_BonusDamage	DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassHH_Effect_BonusDamage';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = BonusDamage;
	DamageEffect.AbilityName = AbilityName;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

// UTILITY FUNCTIONS

static function XComGameState RepeatShotAbility_BuildGameState(XComGameStateContext Context) {
	local XComGameState NewGameState;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);

	RepeatShotAbility_FillOutGameState(NewGameState);

	return NewGameState;
}

static function RepeatShotAbility_FillOutGameState(XComGameState NewGameState) {
	local XComGameStateHistory			History;
	local XComGameState_Ability			ShootAbilityState;
	local X2AbilityTemplate				AbilityTemplate;
	local XComGameStateContext_Ability	AbilityContext;

	local XComGameState_BaseObject		SourceObject_OriginalState;
	local XComGameState_BaseObject		SourceObject_NewState;
	local XComGameState_Item			SourceWeapon, SourceWeapon_NewState;

	local XComGameState_Unit			SourceUnit, TargetUnit;
	local array<StateObjectReference>	VisibleEnemies;
	local StateObjectReference			AbilityRef;

	History = `XCOMHISTORY;	

	//Build the new game state frame, and unit state object for the acting unit
	`assert(NewGameState != none);
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	ShootAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));	
	AbilityTemplate = ShootAbilityState.GetMyTemplate();
	SourceObject_OriginalState = History.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID);	
	SourceWeapon = ShootAbilityState.GetSourceWeapon();
	ShootAbilityState = XComGameState_Ability(NewGameState.CreateStateObject(ShootAbilityState.Class, ShootAbilityState.ObjectID));
	NewGameState.AddStateObject(ShootAbilityState);

	//Any changes to the shooter / source object are made to this game state
	SourceObject_NewState = NewGameState.CreateStateObject(SourceObject_OriginalState.Class, AbilityContext.InputContext.SourceObject.ObjectID);
	NewGameState.AddStateObject(SourceObject_NewState);

	if (SourceWeapon != none) {
		SourceWeapon_NewState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', SourceWeapon.ObjectID));
		NewGameState.AddStateObject(SourceWeapon_NewState);
	}

	//Apply the cost of the ability
	AbilityTemplate.ApplyCost(AbilityContext, ShootAbilityState, SourceObject_NewState, SourceWeapon_NewState, NewGameState);

	class'X2TacticalVisibilityHelpers'.static.GetAllVisibleEnemyUnitsForUnit(SourceObject_NewState.ObjectID, VisibleEnemies);
	SourceUnit = XComGameState_Unit(SourceObject_NewState);
	TargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(VisibleEnemies[`SYNC_RAND_STATIC(VisibleEnemies.length)].ObjectID));
	AbilityRef = SourceUnit.FindAbility('SniperStandardFire',SourceUnit.GetPrimaryWeapon().GetReference());
	CallAbilityOnTarget(SourceUnit, TargetUnit, AbilityRef);
}

static function CallAbilityOnTarget(XComGameState_Unit ActiveUnit, XComGameState_Unit TargetUnit, StateObjectReference AbilityRef) {
	local XComGameStateHistory History;
	local XComGameState_Ability AbilityState;
	local XComGameStateContext_Ability AbilityContext;
	local array<name> ActionPointList;
	
	History = `XCOMHISTORY;

	`LOG("GRIMY LOG STARTING ABILITY CALL");
	if ( AbilityRef.ObjectId > 0 ) { 
		`LOG("GRIMY LOG, ABILITY IS NOT NULL");
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
		if ( AbilityState != none ) {
			ActionPointList = ActiveUnit.ActionPoints;
			ActiveUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
			ActiveUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
			if (AbilityState.CanActivateAbilityForObserverEvent(TargetUnit, ActiveUnit) == 'AA_Success') {
				`LOG("ABILITY SUCCEEDED");
				AbilityContext = class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, TargetUnit.ObjectID);
				if( AbilityContext.Validate() ) {
					`TACTICALRULES.SubmitGameStateContext(AbilityContext);
				}
			}
			else {
				`LOG("ABILITY FAILED " $ AbilityState.CanActivateAbilityForObserverEvent(TargetUnit));
				ActiveUnit.ActionPoints = ActionPointList;
			}
		}
	}
}

static function XComGameState MultiShotAbility_BuildGameState(XComGameStateContext Context) {
	local XComGameState NewGameState;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);

	MultiShotAbility_FillOutGameState(NewGameState);

	return NewGameState;
}

static function MultiShotAbility_FillOutGameState(XComGameState NewGameState) {
	local XComGameStateHistory History;
	local XComGameState_Ability ShootAbilityState;
	local X2AbilityTemplate AbilityTemplate;
	local XComGameStateContext_Ability AbilityContext;
	local int TargetIndex;	

	local XComGameState_BaseObject AffectedTargetObject_OriginalState;	
	local XComGameState_BaseObject AffectedTargetObject_NewState;
	local XComGameState_BaseObject SourceObject_OriginalState;
	local XComGameState_BaseObject SourceObject_NewState;
	local XComGameState_Item       SourceWeapon, SourceWeapon_NewState;
	local X2AmmoTemplate           AmmoTemplate;
	//local X2GrenadeTemplate        GrenadeTemplate;
	local X2WeaponTemplate         WeaponTemplate;
	local EffectResults            MultiTargetEffectResults, EmptyResults;
	local EffectTemplateLookupType MultiTargetLookupType;
	
	local XComGameState_Unit SourceUnit;
	local array<StateObjectReference>	EnemyRefs, AffectRefs;

	History = `XCOMHISTORY;	

	//Build the new game state frame, and unit state object for the acting unit
	`assert(NewGameState != none);
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	ShootAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));	
	AbilityTemplate = ShootAbilityState.GetMyTemplate();
	SourceObject_OriginalState = History.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID);	
	SourceWeapon = ShootAbilityState.GetSourceWeapon();
	ShootAbilityState = XComGameState_Ability(NewGameState.CreateStateObject(ShootAbilityState.Class, ShootAbilityState.ObjectID));
	NewGameState.AddStateObject(ShootAbilityState);

	//Any changes to the shooter / source object are made to this game state
	SourceObject_NewState = NewGameState.CreateStateObject(SourceObject_OriginalState.Class, AbilityContext.InputContext.SourceObject.ObjectID);
	NewGameState.AddStateObject(SourceObject_NewState);

	if (SourceWeapon != none) {
		SourceWeapon_NewState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', SourceWeapon.ObjectID));
		NewGameState.AddStateObject(SourceWeapon_NewState);
	}

	if (AbilityTemplate.bRecordValidTiles && AbilityContext.InputContext.TargetLocations.Length > 0) {
		AbilityTemplate.AbilityMultiTargetStyle.GetValidTilesForLocation(ShootAbilityState, AbilityContext.InputContext.TargetLocations[0], AbilityContext.ResultContext.RelevantEffectTiles);
	}

	//If there is a target location, generate a list of projectile events to use if a projectile is requested
	if(AbilityContext.InputContext.ProjectileEvents.Length > 0) {
		GenerateDamageEvents(NewGameState, AbilityContext);
	}

	MultiTargetLookupType = TELT_AbilityMultiTargetEffects;

	//  Apply effects to multi targets
	if( AbilityTemplate.AbilityMultiTargetEffects.Length > 0 ) {
		
		SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
		SourceUnit.GetUISummary_TargetableUnits(AbilityContext.InputContext.MultiTargets,EnemyRefs,AffectRefs,ShootAbilityState,-1);

		if ( GrimyClassHH_MultiTarget(AbilityTemplate.AbilityMultiTargetStyle) != none ) {
			while ( AbilityContext.InputContext.MultiTargets.Length > GrimyClassHH_MultiTarget(AbilityTemplate.AbilityMultiTargetStyle).NumTargets ) {
				AbilityContext.InputContext.MultiTargets.Remove(Rand(AbilityContext.InputContext.MultiTargets.length),1);
			}
		}
		AbilityContext.InputContext.PrimaryTarget.ObjectID = 0;

		for( TargetIndex = 0; TargetIndex < AbilityContext.InputContext.MultiTargets.Length; ++TargetIndex ) {
			AffectedTargetObject_OriginalState = History.GetGameStateForObjectID(AbilityContext.InputContext.MultiTargets[TargetIndex].ObjectID, eReturnType_Reference);
			AffectedTargetObject_NewState = NewGameState.CreateStateObject(AffectedTargetObject_OriginalState.Class, AbilityContext.InputContext.MultiTargets[TargetIndex].ObjectID);
			
			MultiTargetEffectResults = EmptyResults;        //  clear struct for use - cannot pass dynamic array element as out parameter
			if (ApplyEffectsToTarget(
				AbilityContext, 
				AffectedTargetObject_OriginalState, 
				SourceObject_OriginalState, 
				ShootAbilityState, 
				AffectedTargetObject_NewState, 
				NewGameState, 
				AbilityContext.ResultContext.MultiTargetHitResults[TargetIndex],
				AbilityContext.ResultContext.MultiTargetArmorMitigation[TargetIndex],
				AbilityContext.ResultContext.MultiTargetStatContestResult[TargetIndex],
				AbilityTemplate.AbilityMultiTargetEffects, 
				MultiTargetEffectResults, 
				AbilityTemplate.DataName, 
				MultiTargetLookupType )) {
				AbilityContext.ResultContext.MultiTargetEffectResults[TargetIndex] = MultiTargetEffectResults;  //  copy results into dynamic array
			}
			
			if (AbilityTemplate.bAllowAmmoEffects && SourceWeapon_NewState != none && SourceWeapon_NewState.HasLoadedAmmo()) {
				AmmoTemplate = X2AmmoTemplate(SourceWeapon_NewState.GetLoadedAmmoTemplate(ShootAbilityState));
				if (AmmoTemplate != none && AmmoTemplate.TargetEffects.Length > 0) {
					ApplyEffectsToTarget(
						AbilityContext, 
						AffectedTargetObject_OriginalState, 
						SourceObject_OriginalState, 
						ShootAbilityState, 
						AffectedTargetObject_NewState, 
						NewGameState, 
						AbilityContext.ResultContext.HitResult,
						AbilityContext.ResultContext.ArmorMitigation,
						AbilityContext.ResultContext.StatContestResult,
						AmmoTemplate.TargetEffects, 
						AbilityContext.ResultContext.TargetEffectResults, 
						AmmoTemplate.DataName,  //Use the ammo template for TELT_AmmoTargetEffects
						TELT_AmmoTargetEffects);
				}
			}

			if (AbilityTemplate.bAllowBonusWeaponEffects && SourceWeapon_NewState != none) {
				WeaponTemplate = X2WeaponTemplate(SourceWeapon_NewState.GetMyTemplate());
				if (WeaponTemplate != none && WeaponTemplate.BonusWeaponEffects.Length > 0) {
					ApplyEffectsToTarget(
						AbilityContext,
						AffectedTargetObject_OriginalState, 
						SourceObject_OriginalState, 
						ShootAbilityState, 
						AffectedTargetObject_NewState, 
						NewGameState, 
						AbilityContext.ResultContext.HitResult,
						AbilityContext.ResultContext.ArmorMitigation,
						AbilityContext.ResultContext.StatContestResult,
						WeaponTemplate.BonusWeaponEffects, 
						AbilityContext.ResultContext.TargetEffectResults, 
						WeaponTemplate.DataName,
						TELT_WeaponEffects);
				}
			}

			NewGameState.AddStateObject(AffectedTargetObject_NewState);
		}
	}
	
	//Give all effects a chance to make world modifications ( ie. add new state objects independent of targeting )
	//ApplyEffectsToWorld(AbilityContext, SourceObject_OriginalState, ShootAbilityState, NewGameState, AbilityTemplate.AbilityShooterEffects, AbilityTemplate.DataName, TELT_AbilityShooterEffects);
	//ApplyEffectsToWorld(AbilityContext, SourceObject_OriginalState, ShootAbilityState, NewGameState, AbilityTemplate.AbilityTargetEffects, AbilityTemplate.DataName, TELT_AbilityTargetEffects);	
	ApplyEffectsToWorld(AbilityContext, SourceObject_OriginalState, ShootAbilityState, NewGameState, AbilityTemplate.AbilityMultiTargetEffects, AbilityTemplate.DataName, TELT_AbilityMultiTargetEffects);

	//Apply the cost of the ability
	AbilityTemplate.ApplyCost(AbilityContext, ShootAbilityState, SourceObject_NewState, SourceWeapon_NewState, NewGameState);
}

function CobraShot_BuildVisualization(XComGameState VisualizeGameState, out array<VisualizationTrack> OutVisualizationTracks) {
	local X2AbilityTemplate             AbilityTemplate;
	local XComGameStateContext_Ability  Context;
	local AbilityInputContext           AbilityContext;
	local StateObjectReference          ShootingUnitRef;	
	//local X2Action_Fire                 FireAction;
	local X2Action_Fire_Faceoff         FireFaceoffAction;
	local XComGameState_BaseObject      TargetStateObject;//Container for state objects within VisualizeGameState	
	
	local Actor                     TargetVisualizer, ShooterVisualizer;
	local X2VisualizerInterface     TargetVisualizerInterface;
	local int                       EffectIndex, TargetIndex;

	local VisualizationTrack        EmptyTrack;
	local VisualizationTrack        BuildTrack;
	local VisualizationTrack        SourceTrack;
	local XComGameStateHistory      History;

	local X2Action_PlaySoundAndFlyOver SoundAndFlyover;
	local name         ApplyResult;

	local X2Action_StartCinescriptCamera CinescriptStartAction;
	local X2Action_EndCinescriptCamera   CinescriptEndAction;
	local X2Camera_Cinescript            CinescriptCamera;
	local string                         PreviousCinescriptCameraType;
	local X2Effect                       TargetEffect;


	History = `XCOMHISTORY;
	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityContext = Context.InputContext;
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(AbilityContext.AbilityTemplateName);
	ShootingUnitRef = Context.InputContext.SourceObject;

	ShooterVisualizer = History.GetVisualizer(ShootingUnitRef.ObjectID);

	SourceTrack = EmptyTrack;
	SourceTrack.StateObject_OldState = History.GetGameStateForObjectID(ShootingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	SourceTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(ShootingUnitRef.ObjectID);
	if (SourceTrack.StateObject_NewState == none)
		SourceTrack.StateObject_NewState = SourceTrack.StateObject_OldState;
	SourceTrack.TrackActor = ShooterVisualizer;

	if (AbilityTemplate.ActivationSpeech != '') {
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTrack(SourceTrack, Context));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.ActivationSpeech, eColor_Good);
	}


	// Add a Camera Action to the Shooter's track.  Minor hack: To create a CinescriptCamera the AbilityTemplate 
	// must have a camera type.  So manually set one here, use it, then restore.
	PreviousCinescriptCameraType = AbilityTemplate.CinescriptCameraType;
	AbilityTemplate.CinescriptCameraType = "StandardGunFiring";
	CinescriptCamera = class'X2Camera_Cinescript'.static.CreateCinescriptCameraForAbility(Context);
	CinescriptStartAction = X2Action_StartCinescriptCamera( class'X2Action_StartCinescriptCamera'.static.AddToVisualizationTrack(SourceTrack, Context ) );
	CinescriptStartAction.CinescriptCamera = CinescriptCamera;
	AbilityTemplate.CinescriptCameraType = PreviousCinescriptCameraType;


	class'X2Action_ExitCover'.static.AddToVisualizationTrack(SourceTrack, Context);
	
	//  Now configure a fire action for each multi target
	for (TargetIndex = 0; TargetIndex < AbilityContext.MultiTargets.Length; ++TargetIndex) {
		// Add an action to pop the previous CinescriptCamera off the camera stack.
		CinescriptEndAction = X2Action_EndCinescriptCamera( class'X2Action_EndCinescriptCamera'.static.AddToVisualizationTrack( SourceTrack, Context ) );
		CinescriptEndAction.CinescriptCamera = CinescriptCamera;
		CinescriptEndAction.bForceEndImmediately = true;

		// Add an action to push a new CinescriptCamera onto the camera stack.
		AbilityTemplate.CinescriptCameraType = "StandardGunFiring";
		CinescriptCamera = class'X2Camera_Cinescript'.static.CreateCinescriptCameraForAbility(Context);
		CinescriptCamera.TargetObjectIdOverride = AbilityContext.MultiTargets[TargetIndex].ObjectID;
		CinescriptStartAction = X2Action_StartCinescriptCamera( class'X2Action_StartCinescriptCamera'.static.AddToVisualizationTrack(SourceTrack, Context ) );
		CinescriptStartAction.CinescriptCamera = CinescriptCamera;
		AbilityTemplate.CinescriptCameraType = PreviousCinescriptCameraType;

		// Add a custom Fire action to the shooter track.
		TargetVisualizer = History.GetVisualizer(AbilityContext.MultiTargets[TargetIndex].ObjectID);
		FireFaceoffAction = X2Action_Fire_Faceoff(class'X2Action_Fire_Faceoff'.static.AddToVisualizationTrack(SourceTrack, Context));
		FireFaceoffAction.SetFireParameters(Context.IsResultContextMultiHit(TargetIndex), AbilityContext.MultiTargets[TargetIndex].ObjectID, false);
		FireFaceoffAction.vTargetLocation = TargetVisualizer.Location;


		//  Setup target response
		TargetVisualizerInterface = X2VisualizerInterface(TargetVisualizer);
		BuildTrack = EmptyTrack;
		BuildTrack.TrackActor = TargetVisualizer;
		TargetStateObject = VisualizeGameState.GetGameStateForObjectID(AbilityContext.MultiTargets[TargetIndex].ObjectID);
		if( TargetStateObject != none ) {
			History.GetCurrentAndPreviousGameStatesForObjectID(AbilityContext.MultiTargets[TargetIndex].ObjectID, 
																BuildTrack.StateObject_OldState, BuildTrack.StateObject_NewState,
																eReturnType_Reference,
																VisualizeGameState.HistoryIndex);
			`assert(BuildTrack.StateObject_NewState == TargetStateObject);
		}
		else {
			//If TargetStateObject is none, it means that the visualize game state does not contain an entry for the primary target. Use the history version
			//and show no change.
			BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(AbilityContext.MultiTargets[TargetIndex].ObjectID);
			BuildTrack.StateObject_NewState = BuildTrack.StateObject_OldState;
		}

		// Add WaitForAbilityEffect. To avoid time-outs when there are many targets, set a custom timeout
		class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTrack(BuildTrack, Context);
		BuildTrack.TrackActions[BuildTrack.TrackActions.Length - 1].SetCustomTimeoutSeconds((10 + (10 * TargetIndex )));

		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityMultiTargetEffects.Length; ++EffectIndex) {
			TargetEffect = AbilityTemplate.AbilityMultiTargetEffects[EffectIndex];
			ApplyResult = Context.FindMultiTargetEffectApplyResult(TargetEffect, TargetIndex);

			// Target effect visualization
			AbilityTemplate.AbilityMultiTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, ApplyResult);

			// If the last Effect applied was weapon damage, then a weapon damage Action was added to the track.
			// Find that weapon damage action, and extend its timeout so that we won't timeout if there are many
			// targets to visualize before this one.
			if ( X2Effect_ApplyWeaponDamage(TargetEffect) != none ) {
				if ( X2Action_ApplyWeaponDamageToUnit(BuildTrack.TrackActions[BuildTrack.TrackActions.Length - 1]) != none) {
					BuildTrack.TrackActions[BuildTrack.TrackActions.Length - 1].SetCustomTimeoutSeconds((10 + (10 * TargetIndex )));
				}
			}

			// Source effect visualization
			AbilityTemplate.AbilityMultiTargetEffects[EffectIndex].AddX2ActionsForVisualizationSource(VisualizeGameState, SourceTrack, ApplyResult);
		}
		if( TargetVisualizerInterface != none ) {
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildTrack);
		}
		OutVisualizationTracks.AddItem(BuildTrack);
	}
	class'X2Action_EnterCover'.static.AddToVisualizationTrack(SourceTrack, Context);

	// Add an action to pop the last CinescriptCamera off the camera stack.
	CinescriptEndAction = X2Action_EndCinescriptCamera( class'X2Action_EndCinescriptCamera'.static.AddToVisualizationTrack( SourceTrack, Context ) );
	CinescriptEndAction.CinescriptCamera = CinescriptCamera;

	OutVisualizationTracks.AddItem(SourceTrack);
}