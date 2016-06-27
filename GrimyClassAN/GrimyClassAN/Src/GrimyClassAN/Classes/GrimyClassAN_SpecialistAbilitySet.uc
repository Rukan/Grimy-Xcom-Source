class GrimyClassAN_SpecialistAbilitySet extends X2Ability_SpecialistAbilitySet config(GrimyClassAN);

var config int CAUTERIZE_CHARGES, CAUTERIZE_DAMAGE, CAUTERIZE_HEAL, CAUTERIZE_HEAL_SPREAD;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(GrimyCauterize('GrimyCauterize',default.CAUTERIZE_CHARGES, default.CAUTERIZE_DAMAGE, default.CAUTERIZE_HEAL, default.CAUTERIZE_HEAL_SPREAD,"img:///GrimyClassAN_Icons.UIPerk_item_Cauterize"));

	return Templates;
}

static function X2AbilityTemplate GrimyCauterize(name TemplateName, int BonusCharges, int BonusDamage, int BonusHeal, int HealSpread, string IconImage)
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges             ChargeCost;
	local X2Condition_UnitProperty          UnitPropertyCondition;
	local X2Condition_UnitStatCheck         UnitStatCheckCondition;
	local X2Condition_UnitEffects           UnitEffectsCondition;
	local GrimyClassAN_Effect_Healing		MedikitHeal;
	local array<name>                       SkipExclusions;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	local X2Condition_Visibility                VisCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.AdditionalAbilities.AddItem('RevivalProtocol');
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.Hostility = eHostility_Defensive;
	Template.bDisplayInUITooltip = false;
	Template.bLimitTargetIcons = true;
	Template.AbilitySourceName = 'eAbilitySource_Perk';

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;	
	Template.AbilityCosts.AddItem(ActionPointCost);
	
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
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SingleTargetWithSelf;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeTurret = true;
	UnitPropertyCondition.ExcludeCivilian = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bRequireGameplayVisible = true;
	VisCondition.bActAsSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisCondition);

	//Hack: Do this instead of ExcludeDead, to only exclude properly-dead or bleeding-out units.
	UnitStatCheckCondition = new class'X2Condition_UnitStatCheck';
	UnitStatCheckCondition.AddCheckStat(eStat_HP, 0, eCheck_GreaterThan);
	Template.AbilityTargetConditions.AddItem(UnitStatCheckCondition);

	UnitEffectsCondition = new class'X2Condition_UnitEffects';
	UnitEffectsCondition.AddExcludeEffect(class'X2StatusEffects'.default.BleedingOutName, 'AA_UnitIsImpaired');
	Template.AbilityTargetConditions.AddItem(UnitEffectsCondition);
	
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.EffectDamageValue.Damage = BonusDamage;
	Template.AddTargetEffect(WeaponDamageEffect);
	
	UnitStatCheckCondition = new class'X2Condition_UnitStatCheck';
	UnitStatCheckCondition.AddCheckStat(eStat_HP, BonusDamage, eCheck_GreaterThan);

	MedikitHeal = new class'GrimyClassAN_Effect_Healing';
	MedikitHeal.PerUseHP = BonusHeal;
	MedikitHeal.HealSpread = HealSpread;
	MedikitHeal.TargetConditions.AddItem(UnitStatCheckCondition);
	Template.AddTargetEffect(MedikitHeal);

	Template.AddTargetEffect(RemoveAllEffectsByDamageType());

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.bStationaryWeapon = true;
	Template.PostActivationEvents.AddItem('ItemRecalled');
	Template.BuildNewGameStateFn = AttachGremlinToTarget_BuildGameState;
	Template.BuildVisualizationFn = GremlinSingleTarget_BuildVisualization;

	Template.ActivationSpeech = 'MedicalProtocol';

	Template.bOverrideWeapon = true;
	Template.CustomSelfFireAnim = 'NO_MedicalProtocolA';
	return Template;
}