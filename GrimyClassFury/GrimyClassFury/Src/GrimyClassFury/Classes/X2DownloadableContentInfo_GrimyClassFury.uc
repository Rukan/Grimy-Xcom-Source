class X2DownloadableContentInfo_GrimyClassFury extends X2DownloadableContentInfo config(GrimyClassFury);

var config array<name> HEALING_SKILLS;
var config int REAVE_COST, PYROKINESIS_COST, MADNESS_COST;
var config int REAVE_COOLDOWN, PYROKINESIS_COOLDOWN, MADNESS_COOLDOWN, MADNESS_DURATION;

static event OnPostTemplatesCreated() {
	UpdateFacilities();
	UpdateAbilities();
	UpdateSoldierNicknames();
}

static function UpdateFacilities() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local array<X2DataTemplate>					DifficultyTemplates;
	local X2DataTemplate						DifficultyTemplate;

	// Add Strategy Unlocks
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StrategyManager.FindDataTemplateAllDifficulties('OfficerTrainingSchool',DifficultyTemplates);	
	foreach DifficultyTemplates(DifficultyTemplate) {
		X2FacilityTemplate(DifficultyTemplate).SoldierUnlockTemplates.AddItem('GrimySpeedsterUnlock');
	}
}

static function UpdateSoldierNicknames() {
	local X2SoldierClassTemplateManager	SoldierManager;
	local X2SoldierClassTemplate		FuryClass, PsiOperativeClass;

	SoldierManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	PsiOperativeClass = SoldierManager.FindSoldierClassTemplate('PsiOperative');
	FuryClass = Soldiermanager.FindSoldierClassTemplate('Fury');
	FuryClass.RandomNicknames = PsiOperativeClass.RandomNicknames;
	FuryClass.RandomNicknames_Male = PsiOperativeClass.RandomNicknames_Male;
	FuryClass.RandomNicknames_Female = PsiOperativeClass.RandomNicknames_Female;
}

static function UpdateAbilities() {
	local X2AbilityTemplateManager					AbilityManager;
	local X2AbilityTemplate							AbilityTemplate;
	local name										AbilityName;
	local X2Effect_GrantActionPoints				ActionPointEffect;
	local X2Condition_AbilityProperty				AbilityCondition;
	local GrimyClassFury_AbilityCost_Reload			AbilityCost;
	
	local GrimyClassFury_AbilityCost_HP				HealthCost;
	local X2Effect_Burning							BurningEffect;
	local X2Effect_PersistentStatChange				PoisonedEffect;
	local GrimyClassFury_Cooldown_PerPlayer			Cooldown;
	local X2Effect_MindControl						MindControlEffect;
	local GrimyClassFury_AbilityPropertyCondition	ExcludeAbilityCondition;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityManager.FindAbilityTemplate('Reload');
	AbilityCost = new class'GrimyClassFury_AbilityCost_Reload';
	AbilityCost.BonusType = 'Strafe';
	AbilityCost.BonusPassive = 'GrimySustainedFire';
	AbilityTemplate.AbilityCosts[0] = AbilityCost;

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Overwatch');
	AbilityCost = new class'GrimyClassFury_AbilityCost_Reload';
	AbilityCost.bConsumeAllPoints = true;
	AbilityCost.bFreeCost = true;
	AbilityCost.DoNotConsumeAllEffects.Length = 0;
	AbilityCost.DoNotConsumeAllSoldierAbilities.Length = 0;
	AbilityCost.BonusType = 'Strafe';
	AbilityCost.BonusPassive = 'GrimySustainedFire';
	AbilityTemplate.AbilityCosts[1] = AbilityCost;
	
	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 1;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyReinvigorate');
	ActionPointEffect.TargetConditions.AddItem(AbilityCondition);
	foreach default.HEALING_SKILLS(AbilityName) {
		AbilityTemplate = AbilityManager.FindAbilityTemplate('MedikitHeal');
		if ( AbilityTemplate.AbilityTargetEffects.length > 0 ) {
			AbilityTemplate.AddTargetEffect(ActionPointEffect);
		}
		if ( AbilityTemplate.AbilityMultiTargetEffects.length > 0 ) {
			AbilityTemplate.AddMultiTargetEffect(ActionPointEffect);
		}
		if ( AbilityTemplate.AbilityShooterEffects.length > 0 ) {
			AbilityTemplate.AddShooterEffect(ActionPointEffect);
		}
	}

	// Soulfire Edit
	AbilityTemplate = AbilityManager.FindAbilityTemplate('Soulfire');

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyPyrokinesis');
	BurningEffect = class'X2StatusEffects'.static.CreateBurningStatusEffect(1,0);
	BurningEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(BurningEffect);

	HealthCost = new class'GrimyClassFury_AbilityCost_HP';
	HealthCost.Cost = default.PYROKINESIS_COST;
	HealthCost.RequiredAbility = 'GrimyPyrokinesis';
	AbilityTemplate.AbilityCosts.AddItem(HealthCost);

	AbilityCost = new class'GrimyClassFury_AbilityCost_Reload';
	AbilityCost.iNumPoints = 1;
	AbilityCost.bConsumeAllPoints = true;
	AbilityCost.BonusType = 'Strafe';
	AbilityCost.BonusPassive = 'GrimyPyrokinesis';
	AbilityTemplate.AbilityCosts[0] = AbilityCost;

	Cooldown = new class'GrimyClassFury_Cooldown_PerPlayer';
	Cooldown.iNumTurns = class'X2Ability_PsiOperativeAbilitySet'.default.SOULFIRE_COOLDOWN;
	Cooldown.AltAbility = 'GrimyPyrokinesis';
	Cooldown.AltTurns = default.PYROKINESIS_COOLDOWN;
	AbilityTemplate.AbilityCooldown = Cooldown;
	
	// Null Lance Edit
	AbilityTemplate = AbilityManager.FindAbilityTemplate('NullLance');

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyReave');
	PoisonedEffect = class'X2StatusEffects'.static.CreatePoisonedStatusEffect();
	PoisonedEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddMultiTargetEffect(PoisonedEffect);

	HealthCost = new class'GrimyClassFury_AbilityCost_HP';
	HealthCost.Cost = default.REAVE_COST;
	HealthCost.RequiredAbility = 'GrimyReave';
	AbilityTemplate.AbilityCosts.AddItem(HealthCost);

	AbilityCost = new class'GrimyClassFury_AbilityCost_Reload';
	AbilityCost.iNumPoints = 1;
	AbilityCost.bConsumeAllPoints = true;
	AbilityCost.BonusType = 'Strafe';
	AbilityCost.BonusPassive = 'GrimyReave';
	AbilityTemplate.AbilityCosts[0] = AbilityCost;

	Cooldown = new class'GrimyClassFury_Cooldown_PerPlayer';
	Cooldown.bAITurns = true;
	Cooldown.iNumTurns = class'X2Ability_PsiOperativeAbilitySet'.default.NULL_LANCE_COOLDOWN_PLAYER;
	Cooldown.iNumTurnsForAI = class'X2Ability_PsiOperativeAbilitySet'.default.NULL_LANCE_COOLDOWN_AI;
	Cooldown.NumGlobalTurns = class'X2Ability_PsiOperativeAbilitySet'.default.NULL_LANCE_GLOBAL_COOLDOWN_AI;
	Cooldown.AltAbility = 'GrimyReave';
	Cooldown.AltTurns = default.REAVE_COOLDOWN;
	AbilityTemplate.AbilityCooldown = Cooldown;

	// Domination Edit
	AbilityTemplate = AbilityManager.FindAbilityTemplate('Domination');

	HealthCost = new class'GrimyClassFury_AbilityCost_HP';
	HealthCost.Cost = default.MADNESS_COST;
	HealthCost.RequiredAbility = 'GrimyMadness';
	AbilityTemplate.AbilityCosts.AddItem(HealthCost);

	AbilityCost = new class'GrimyClassFury_AbilityCost_Reload';
	AbilityCost.iNumPoints = 1;
	AbilityCost.bConsumeAllPoints = true;
	AbilityCost.BonusType = 'Strafe';
	AbilityCost.BonusPassive = 'GrimyMadness';
	AbilityTemplate.AbilityCosts[0] = AbilityCost;

	Cooldown = new class'GrimyClassFury_Cooldown_PerPlayer';
	Cooldown.iNumTurns = class'X2Ability_PsiOperativeAbilitySet'.default.DOMINATION_COOLDOWN;
	Cooldown.AltAbility = 'GrimyMadness';
	Cooldown.AltTurns = default.MADNESS_COOLDOWN;
	AbilityTemplate.AbilityCooldown = Cooldown;

	MindControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(1, false, true);
	ExcludeAbilityCondition = new class'GrimyClassFury_AbilityPropertyCondition';
	ExcludeAbilityCondition.ExcludeAbility = 'GrimyMadness';
	MindControlEffect.TargetConditions.AddItem(ExcludeAbilityCondition);
	class'GrimyClassFury_AbilityTemplateHelper'.static.InjectTargetEffect(AbilityTemplate, MindControlEffect, 0);

	MindControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(default.MADNESS_DURATION, false, false);
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyMadness');
	MindControlEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(MindControlEffect);

	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 2;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
	ActionPointEffect.TargetConditions.ADdItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(ActionPointEffect);
}