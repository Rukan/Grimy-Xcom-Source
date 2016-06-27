//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_GrimyClassAN.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_GrimyClassAN extends X2DownloadableContentInfo config(GrimyClassAN);

var config int HOSTAGE_DURATION, HOSTAGE_CHANCE;
var config int SHELLSHOCK_DURATION, SHELLSHOCK_CHANCE;

static event OnPostTemplatesCreated() {
	UpdateAbilities();
	UpdateFacilities();
	UpdateSoldierNicknames();
}

static function UpdateSoldierNicknames() {
	local X2SoldierClassTemplateManager	SoldierManager;
	local X2SoldierClassTemplate		AnarchistClass, GrenadierClass;

	SoldierManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	GrenadierClass = SoldierManager.FindSoldierClassTemplate('Grenadier');
	AnarchistClass = Soldiermanager.FindSoldierClassTemplate('Anarchist');
	AnarchistClass.RandomNicknames = GrenadierClass.RandomNicknames;
	AnarchistClass.RandomNicknames_Male = GrenadierClass.RandomNicknames_Male;
	AnarchistClass.RandomNicknames_Female = GrenadierClass.RandomNicknames_Female;
}

static function UpdateAbilities() {
	local X2AbilityTemplateManager				AbilityManager;
	local X2AbilityTemplate						AbilityTemplate;
	local X2Condition_AbilityProperty			AbilityCondition;
	local X2Effect_DisableWeapon				DisableEffect;

	local X2Effect_Stunned						StunnedEffect;
	local X2Effect_GenerateCover				CoverEffect;
	
	local GrimyClassAN_TargetCursor					CursorTarget;
	local GrimyClassAN_MultiTargetRadius				RadiusMultiTarget;
	
	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimySabotage');

	AbilityTemplate = AbilityManager.FindAbilityTemplate('CombatProtocol');
	DisableEffect = new class'X2Effect_DisableWeapon';
	DisableEffect.ApplyChance = 100;
	DisableEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(DisableEffect);
	
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyHostageProtocol');
	
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.HOSTAGE_DURATION, default.HOSTAGE_CHANCE);
	StunnedEffect.bRemoveWhenSourceDies = false;
	StunnedEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(StunnedEffect);
	
	CoverEffect = new class'X2Effect_GenerateCover';
	CoverEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	CoverEffect.bRemoveWhenTargetDies = true;
	CoverEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(CoverEffect);

	AbilityTemplate = Abilitymanager.FindAbilityTemplate('LaunchGrenade');
	
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyShellShock');
	
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.SHELLSHOCK_DURATION, default.SHELLSHOCK_CHANCE);
	StunnedEffect.bRemoveWhenSourceDies = false;
	StunnedEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddMultiTargetEffect(StunnedEffect);
	
	AbilityTemplate = AbilityManager.FindAbilityTemplate('LaunchGrenade');

	CursorTarget = new class'GrimyClassAN_TargetCursor';
	if ( !AbilityTemplate.AbilityTargetStyle.IsA('GrimyLoot_TargetCursor') ) {
		CursorTarget.bRestrictToWeaponRange = true;
		AbilityTemplate.AbilityTargetStyle = CursorTarget;
	}
	
	if ( !AbilityTemplate.AbilityMultiTargetStyle.IsA('GrimyLoot_MultiTargetRadius') ) {
		RadiusMultiTarget = new class'GrimyClassAN_MultiTargetRadius';
		RadiusMultiTarget.bUseWeaponRadius = true;
		RadiusMultiTarget.SoldierAbilityName = 'VolatileMix';
		RadiusMultiTarget.BonusRadius = class'X2Ability_GrenadierAbilitySet'.default.VOLATILE_RADIUS;
		AbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;
	}
}

static function UpdateFacilities() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local array<X2DataTemplate>					DifficultyTemplates;
	local X2DataTemplate						DifficultyTemplate;

	// Add Strategy Unlocks
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StrategyManager.FindDataTemplateAllDifficulties('OfficerTrainingSchool',DifficultyTemplates);	
	foreach DifficultyTemplates(DifficultyTemplate) {
		X2FacilityTemplate(DifficultyTemplate).SoldierUnlockTemplates.AddItem('GrimyShellShockUnlock');
	}
}
