class X2DownloadableContentInfo_GrimyClassMod extends X2DownloadableContentInfo config(GrimyClassMod);

var config int REACTION_ARMOR, REACTION_ARMOR_DURATION, INTIMIDATION_BONUS;

static event OnPostTemplatesCreated()
{
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
		X2FacilityTemplate(DifficultyTemplate).SoldierUnlockTemplates.AddItem('GrimyIntimidationUnlock');
	}
}

static function UpdateSoldierNicknames() {
	local X2SoldierClassTemplateManager	SoldierManager;
	local X2SoldierClassTemplate		BruiserClass, RangerClass;

	SoldierManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	RangerClass = SoldierManager.FindSoldierClassTemplate('Ranger');
	BruiserClass = Soldiermanager.FindSoldierClassTemplate('Bruiser');
	BruiserClass.RandomNicknames = RangerClass.RandomNicknames;
	BruiserClass.RandomNicknames_Male = RangerClass.RandomNicknames_Male;
	BruiserClass.RandomNicknames_Female = RangerClass.RandomNicknames_Female;
}

static function UpdateAbilities() {
	local X2AbilityTemplateManager				AbilityManager;
	local X2AbilityTemplate						PistolAbility;

	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2Condition_AbilityProperty			AbilityCondition;
	local X2Effect_PersistentStatChange			PoisonEffect, PersistentStatChangeEffect;
	local X2Effect_Persistent					MarkedEffect;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	
	// Poison Effect
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyNeedlePointPassive');
	PoisonEffect = class'X2StatusEffects'.static.CreatePoisonedStatusEffect();
	PoisonEffect.EffectTickedFn = none;
	PoisonEffect.TargetConditions.AddItem(AbilityCondition);

	// Ability Templates
	PistolAbility = AbilityManager.FindAbilityTemplate('PistolStandardShot');
	ActionPointCost = new class'X2AbilityCost_QuickdrawActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	PistolAbility.AbilityCosts[0] = ActionPointCost;
	PistolAbility.AddTargetEffect(PoisonEffect);

	PistolAbility = AbilityManager.FindAbilityTemplate('PistolOverwatch');
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = true;   //  this will guarantee the unit has at least 1 action point
	ActionPointCost.bFreeCost = true;           //  ReserveActionPoints effect will take all action points away
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	PistolAbility.AbilityCosts[0] = ActionPointCost;

	PistolAbility = AbilityManager.FindAbilityTemplate('PistolOverwatchShot');
	PistolAbility.AddTargetEffect(PoisonEffect);

	PistolAbility = AbilityManager.FindAbilityTEmplate('HunkerDown');
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.DeepCoverActionPoint);
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	PistolAbility.AbilityCosts[0] = ActionPointCost;

	PistolAbility = AbilityManager.FindAbilityTemplate('ThrowGrenade');
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('Salvo');
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	PistolAbility.AbilityCosts[1] = ActionPointCost;

	PistolAbility = AbilityManager.FindAbilityTemplate('Faceoff');
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	PistolAbility.AbilityCosts[0] = ActionPointCost;
	PistolAbility.AddTargetEffect(PoisonEffect);

	PistolAbility = AbilityManager.FindAbilityTemplate('FanFire');
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.AllowedTypes.AddItem('GrimyGunpoint');
	PistolAbility.AbilityCosts[0] = ActionPointCost;
	PistolAbility.AddTargetEffect(PoisonEffect);

	// Reaction Ability Edits
	PistolAbility = AbilityManager.FindAbilityTemplate('PistolReturnFire');

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimySpotter');
	MarkedEffect = class'X2StatusEffects'.static.CreateMarkedEffect(2, false);
	MarkedEffect.bApplyOnMiss = true;
	MarkedEffect.TargetConditions.AddItem(AbilityCondition);

	PistolAbility.AddTargetEffect(MarkedEffect);

	// Suppression Effect
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyIntimidationPassive');
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Offense, default.INTIMIDATION_BONUS);
	PersistentStatChangeEffect.bApplyOnMiss = true;
	PersistentStatChangeEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.TargetConditions.AddItem(AbilityCondition);

	PistolAbility.AddTargetEffect(PersistentStatChangeEffect);

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimySurvival');

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(default.REACTION_ARMOR_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.REACTION_ARMOR);
	PersistentStatChangeEffect.bApplyOnMiss = true;
	PersistentStatChangeEffect.TargetConditions.AddItem(AbilityCondition);
	
	PistolAbility.AddShooterEffect(PersistentStatChangeEffect);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(default.REACTION_ARMOR_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorChance, 100);
	PersistentStatChangeEffect.bApplyOnMiss = true;
	PersistentStatChangeEffect.TargetConditions.AddItem(AbilityCondition);

	PistolAbility.AddShooterEffect(PersistentStatChangeEffect);
}