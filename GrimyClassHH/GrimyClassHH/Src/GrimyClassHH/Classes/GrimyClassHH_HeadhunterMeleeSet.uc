class GrimyClassHH_HeadhunterMeleeSet extends X2Ability_RangerAbilitySet config(GrimyClassHH);

var config int BLADE_OIL_CHARGES, BLADE_OIL_COOLDOWN;
var config float EXECUTE_BONUS;
var config int RAPIDSLASH_COOLDOWN;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>			Templates;

	// CORPORAL
	Templates.AddItem(GrimyBladeOil('GrimyBladeOil',"img:///GrimyClassHHPackage.UIPerk_BladeOil",default.BLADE_OIL_CHARGES, default.BLADE_OIL_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY));
	// MAJOR
	Templates.AddItem(GrimyRapidSlashHH('GrimyRapidSlashHH',"img:///UILibrary_PerkIcons.UIPerk_charge",default.RAPIDSLASH_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY));
	// PASSIVES
	Templates.AddItem(GrimyExecuteBonus('GrimyExecuteBonus',"img:///GrimyClassHHPackage.UIPerk_mark",default.EXECUTE_BONUS));
	Templates.AddItem(PurePassive('GrimyEntangle',"img:///UILibrary_PerkIcons.UIPerk_disoriented",false));

	// LOOT
	Templates.AddItem(GrimyBladeOil('GrimyBladeOilBsc',"img:///GrimyClassHHPackage.UIPerk_BladeOil", 1, 0, class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY));
	Templates.AddItem(GrimyBladeOil('GrimyBladeOilAdv',"img:///GrimyClassHHPackage.UIPerk_BladeOil", 1, 0, class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY));
	Templates.AddItem(GrimyBladeOil('GrimyBladeOilSup',"img:///GrimyClassHHPackage.UIPerk_BladeOil", 1, 0, class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY));

	return Templates;
}

static function X2AbilityTemplate GrimyBladeOil(name TemplateName, string IconImage, int BonusCharges, int BonusCooldown, int HUDPriority, optional bool CrossClass = false)
{
	local X2AbilityTemplate					Template;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	local X2AbilityCooldown                 Cooldown;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;

	Template = AddSwordSliceAbility(TemplateName);
	Template.bCrossClassEligible = CrossClass;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = HUDPriority;
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.EffectDamageValue.DamageType = 'Poison';
	Template.AddTargetEffect(WeaponDamageEffect);
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());
	
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

	return Template;
}

static function X2AbilityTemplate GrimyRapidSlashHH(name TemplateName, string IconImage, int BonusCooldown, int HUDPriority)
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCooldown					Cooldown;
	local GrimyClassHH_AbilityCost_Rapid	ActionPointCost;

	Template = AddSwordSliceAbility(TemplateName);
	
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = HUDPriority;

	Template.AbilityCosts.length = 0;

	ActionPointCost = new class'GrimyClassHH_AbilityCost_Rapid';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.RefundActionPoint = 'standard';
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = BonusCooldown;
	Template.AbilityCooldown = Cooldown;

	return Template;
}

// passive abilities

static function X2AbilityTemplate GrimyExecuteBonus(name TemplateName, string IconImage, float BonusDamage) {
	local X2AbilityTemplate						Template;
	local GrimyClassHH_Effect_BonusExecute		DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.IconImage = IconImage;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassHH_Effect_BonusExecute';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = BonusDamage;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}