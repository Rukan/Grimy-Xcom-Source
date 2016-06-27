class GrimyClassFury_AbilitySet extends X2Ability_PsiOperativeAbilitySet config(GrimyClassFury);

var config float STRAFE_BONUS;
var config int STRAFE_ACTIONS, SPEEDSTER_ACTIONS, SPEEDSTER_MOBILITY;
var config float WILLTOSURVIVE_MULT;
var config int STRAFE_MOBILITY;
var config int ARCANE_MISSILE_COUNT;
var config int SUSTAINED_FIRE_BONUS;
var config int SOUL_TAP_COST, SOUL_TAP_COOLDOWN;
var config int SPRAYPRAY_BONUS, SPRAYPRAY_NUMTARGETS, SPRAYPRAY_COOLDOWN;
var config float REAVE_BONUS;
var config int MADNESS_BONUS_CHARGES;

var config array<name> EXCLUDE_CHARS;

var config int ANOMALY_COST, ANOMALY_CHARGES, ANOMALY_COOLDOWN, ANOMALY_RADIUS, ANOMALY_RANGE, ANOMALY_DAMAGE, ANOMALY_TIER;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;

	//Squaddie
	Templates.AddItem(GrimyStrafe('GrimyStrafe','GrimyStrafeBonus',"img:///GrimyClassFuryPackage.Strafe",class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY));
	//Corporal
	Templates.AddItem(GrimySustainedFire('GrimySustainedFire',"img:///GrimyClassFuryPackage.SustainedFire",default.SUSTAINED_FIRE_BONUS));
	Templates.AddItem(GrimyPyrokinesis('GrimyPyrokinesis',"img:///UILibrary_PerkIcons.UIPerk_torch"));
	//Sergeant
	Templates.AddItem(GrimySoulTap('GrimySoulTap',"img:///GrimyClassFuryPackage.UIPerk_Soultap",default.SOUL_TAP_COST,default.SOUL_TAP_COOLDOWN,class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY));
	//Lieutenant
	Templates.AddItem(PurePassive('GrimyReinvigorate',"img:///GrimyClassFuryPackage.Reinvigorate",true));
	Templates.AddItem(GrimyReave('GrimyReave',"img:///UILibrary_PerkIcons.UIPerk_Bloodcall", default.REAVE_BONUS));
	//Major
	Templates.AddItem(GrimyBulletRoulette('GrimyBulletRoulette',"img:///GrimyClassFuryPackage.BulletRoulette"));
	Templates.AddItem(GrimyMadness('GrimyMadness',"img:///UILibrary_PerkIcons.UIPerk_sectoid_mindspin", default.MADNESS_BONUS_CHARGES));
	//COLONEL
	Templates.AddItem(GrimySprayAndPray('GrimySprayAndPray','GrimySprayAndPrayBonus',"img:///GrimyClassFuryPackage.SprayAndPray",default.SPRAYPRAY_NUMTARGETS, default.SPRAYPRAY_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	Templates.AddItem(GrimyAnomaly('GrimyAnomaly','GrimyAnomalyBonus',"img:///UILibrary_PerkIcons.UIPerk_psi_rift",default.ANOMALY_COST, default.ANOMALY_CHARGES,default.ANOMALY_COOLDOWN,default.ANOMALY_RADIUS,default.ANOMALY_RANGE,class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY));
	
	// Passive Bonuses
	Templates.AddItem(GrimyStrafeBonus('GrimySpeedster','',0, default.SPEEDSTER_MOBILITY,false, default.SPEEDSTER_ACTIONS));
	Templates.AddItem(GrimyStrafeBonus('GrimyStrafeBonus','GrimyStrafe',default.STRAFE_BONUS, default.STRAFE_MOBILITY, true, default.STRAFE_ACTIONS));
	Templates.AddItem(GrimyWillToSurvive('GrimyWillToSurvive',"img:///UILibrary_PerkIcons.UIPerk_star_will",default.WILLTOSURVIVE_MULT));
	Templates.AddItem(GrimyBonusDamage('GrimyAnomalyBonus','GrimyAnomaly',0.0, default.ANOMALY_DAMAGE, default.ANOMALY_TIER));
	Templates.AddItem(GrimyBonusDamage('GrimySprayAndPrayBonus','GrimySprayAndPray',default.SPRAYPRAY_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimySprayAndPrayBonusBsc','GrimySprayAndPrayBsc',default.SPRAYPRAY_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimySprayAndPrayBonusAdv','GrimySprayAndPrayAdv',default.SPRAYPRAY_BONUS));
	Templates.AddItem(GrimyBonusDamage('GrimySprayAndPrayBonusSup','GrimySprayAndPraySup',default.SPRAYPRAY_BONUS));

	Templates.AddItem(GrimySprayAndPray('GrimySprayAndPrayBsc','GrimySprayAndPrayBonusBsc',"img:///GrimyClassFuryPackage.SprayAndPray",default.SPRAYPRAY_NUMTARGETS, default.SPRAYPRAY_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY,1));
	Templates.AddItem(GrimySprayAndPray('GrimySprayAndPrayAdv','GrimySprayAndPrayBonusAdv',"img:///GrimyClassFuryPackage.SprayAndPray",default.SPRAYPRAY_NUMTARGETS, default.SPRAYPRAY_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY,2));
	Templates.AddItem(GrimySprayAndPray('GrimySprayAndPraySup','GrimySprayAndPrayBonusSup',"img:///GrimyClassFuryPackage.SprayAndPray",default.SPRAYPRAY_NUMTARGETS, default.SPRAYPRAY_COOLDOWN, class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY,3));

	return Templates;
}

static function X2AbilityTemplate GrimyAnomaly(name TemplateName, name BonusAbility, string IconImage, int HPCost, int BonusCharges, int BonusCooldown, int BonusRadius, int BonusRange, int HUDPriority) {
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityTarget_Cursor            CursorTarget;
	local X2AbilityMultiTarget_Radius       RadiusMultiTarget;
	local X2AbilityCooldown                 Cooldown;
	local X2Effect_ApplyWeaponDamage        DamageEffect;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;
	local GrimyClassFury_AbilityCost_HP		HealthCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.AdditionalAbilities.AddItem(BonusAbility);

	Template.ShotHUDPriority = HUDPriority;
	Template.IconImage = IconImage;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.bShowActivation = true;
	Template.CustomFireAnim = 'HL_Psi_MindControl';

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	if ( HPCost > 0 ) {
		HealthCost = new class'GrimyClassFury_AbilityCost_HP';
		HealthCost.Cost = HPCost;
		HealthCost.RequiredAbility = TemplateName;
		Template.AbilityCosts.AddItem(HealthCost);
	}

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

	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToSquadsightRange = true;
	CursorTarget.FixedAbilityRange = BonusRange;
	Template.AbilityTargetStyle = CursorTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = BonusRadius;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	DamageEffect = new class'X2Effect_ApplyWeaponDamage';
	DamageEffect.bIgnoreBaseDamage = true;
	DamageEffect.DamageTag = '';
	Template.AddMultiTargetEffect(DamageEffect);


	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.TargetingMethod = class'X2TargetingMethod_VoidRift';

	Template.ActivationSpeech = 'VoidRift';

	Template.BuildNewGameStateFn = AnomalyAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Psionic_FireAtLocation";

	return Template;
}

function XComGameState AnomalyAbility_BuildGameState(XComGameStateContext Context)
{
	local XComGameState NewGameState;
	local XComGameStateHistory				History;
	local XComGameState_HeadquartersXCom	XComHQ;
	local XComGameState_MissionSite			MissionSite;
	local vector							TargetLocation;

	local XComGameState_AIReinforcementSpawner NewAIReinforcementSpawnerState;
	local XComTacticalMissionManager MissionManager;
	local ConfigurableEncounter Encounter;
	local Name EncounterID;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);
		
	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom') );
	MissionSite = XComGameState_MissionSite(History.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID) );
	TargetLocation = XComGameStateContext_Ability(NewGameState.GetContext()).InputContext.TargetLocations[0];

	//class'XComGameState_AIReinforcementSpawner'.static.InitiateReinforcements(GetReinforcementName(MissionSite), , true, TargetLocation, 0); //, NewGameState);

	EncounterID = GetReinforcementName(MissionSite);
	MissionManager = `TACTICALMISSIONMGR;
	MissionManager.GetConfigurableEncounter(EncounterID, Encounter);

	NewAIReinforcementSpawnerState = XComGameState_AIReinforcementSpawner(NewGameState.CreateStateObject(class'XComGameState_AIReinforcementSpawner'));
	//NewAIReinforcementSpawnerState.Countdown = 1;
	NewAIReinforcementSpawnerState.SpawnInfo.EncounterID = EncounterID;
	NewAIReinforcementSpawnerState.UsingPsiGates = true;

	NewAIReinforcementSpawnerState.SpawnInfo.SpawnLocation = TargetLocation;
	NewGameState.AddStateObject(NewAIReinforcementSpawnerState);

	TypicalAbility_FillOutGameState(NewGameState);

	return NewGameState;
}

function name GetReinforcementName(XComGameState_MissionSite MissionSite) {
	local name RetName;

	RetName = MissionSite.SelectedMissionData.SelectedEncounters[`SYNC_RAND(MissionSite.SelectedMissionData.SelectedEncounters.length)].SelectedEncounterName;
	if ( default.EXCLUDE_CHARS.find(RetName) == INDEX_NONE ) {
		return RetName;
	}
	else {
		return GetReinforcementName(MissionSite);
	}
}

static function X2AbilityTemplate GrimyBulletRoulette(name TemplateName, string IconImage) {
	local X2AbilityTemplate									Template;
	local GrimyClassFury_Effect_BulletRoulette				AmmoEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = true;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = IconImage;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;

	AmmoEffect = new class'GrimyClassFury_Effect_BulletRoulette';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(AmmoEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyPyrokinesis(name TemplateName, string IconImage) {
	local X2AbilityTemplate						Template;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.AdditionalAbilities.AddItem('Soulfire');
	Template.IconImage = IconImage;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyReave(name TemplateName, string IconImage, float DamageMult) {
	local X2AbilityTemplate						Template;
	local GrimyClassFury_Effect_BonusDamage		DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.AdditionalAbilities.AddItem('NullLance');
	Template.IconImage = IconImage;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassFury_Effect_BonusDamage';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = DamageMult;
	DamageEffect.AbilityName = 'NullLance';
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyMadness(name TemplateName, string IconImage, int BonusAmmo) {
	local X2AbilityTemplate							Template;
	local GrimyClassFury_Effect_BonusAbilityCharges	AmmoEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.AdditionalAbilities.AddItem('Domination');
	Template.IconImage = IconImage;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	
	AmmoEffect = new class'GrimyClassFury_Effect_BonusAbilityCharges';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	AmmoEffect.ChargeCount = BonusAmmo;
	AmmoEffect.AbilityName = 'Domination';
	Template.AddTargetEffect(AmmoEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimySoulTap(name TemplateName, string IconImage, int HPCost, int BonusCooldown, int HUDPriority) {
	local X2AbilityTemplate				Template;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2Effect_GrantActionPoints	ActionPointEffect;
	local X2AbilityCooldown             Cooldown;
	local GrimyClassFury_AbilityCost_HP	HealthCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	// Icon Properties
	Template.AbilitySourceName = 'eAbilitySource_Psionic';                                       // color of the icon
	Template.IconImage = IconImage;
	Template.ShotHUDPriority = HUDPriority;
	Template.Hostility = eHostility_Defensive;
	Template.bLimitTargetIcons = true;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;	
	
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = False;
	Template.AbilityCosts.AddItem(ActionPointCost);

	if ( HPCost > 0 ) {
		HealthCost = new class'GrimyClassFury_AbilityCost_HP';
		HealthCost.Cost = HPCost;
		HealthCost.RequiredAbility = TemplateName;
		Template.AbilityCosts.AddItem(HealthCost);
	}

	if ( BonusCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = BonusCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 2;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
	Template.AddTargetEffect(ActionPointEffect);

	Template.AbilityTargetStyle = default.SelfTarget;
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Psionic_FireAtUnit";

	return Template;
}

static function X2AbilityTemplate GrimySustainedFire(name TemplateName, string IconImage, int BonusAmmo) {
	local X2AbilityTemplate									Template;
	local GrimyClassFury_Effect_BonusAbilityCharges			AmmoEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = IconImage;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;

	AmmoEffect = new class'GrimyClassFury_Effect_BonusAbilityCharges';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	AmmoEffect.ChargeCount = BonusAmmo;
	AmmoEffect.AbilityName = 'Reload';
	Template.AddTargetEffect(AmmoEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimySprayAndPray(name TemplateName, name BonusAbility, string IconImage, int NumTargets, int BonusCooldown, int HUDPriority, optional int BonusCharges = 0) {
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityCost_Ammo				AmmoCost;
	local GrimyClassFury_MultiTarget			GrimyTarget;
	local X2AbilityCooldown             Cooldown;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);
	Template.bCrossClassEligible = true;

	Template.AdditionalAbilities.AddItem(BonusAbility);

	Template.IconImage = IconImage; 
	Template.ShotHUDPriority = HUDPriority;

	if ( BonusCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = BonusCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	Template.AbilityCosts.length = 0;

	if ( BonusCharges > 0 )
	{
		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = BonusCharges;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);
	}

	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	ActionPointCost.AllowedTypes.AddItem('Strafe');
	Template.AbilityCosts.AddItem(ActionPointCost);	
	
	// Ammo
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = NumTargets;
	Template.AbilityCosts.AddItem(AmmoCost);

	GrimyTarget = new class'GrimyClassFury_MultiTarget';
	GrimyTarget.NumTargets = NumTargets;
	GrimyTarget.bAllowSameTarget = true;
	Template.AbilityMultiTargetStyle = GrimyTarget;
	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	Template.AddMultiTargetEffect(default.WeaponUpgradeMissDamage);

	Template.BuildNewGameStateFn = MultiShotAbility_BuildGameState;
	Template.BuildVisualizationFn = CobraShot_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate GrimyStrafe(name TemplateName, name BonusAbility, string IconImage, int HUDPriority) {
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityCost_Ammo				AmmoCost;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);

	Template.AdditionalAbilities.AddItem(BonusAbility);

	Template.IconImage = IconImage; 
	Template.ShotHUDPriority = HUDPriority;
	
	Template.AbilityCosts.length = 0;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	ActionPointCost.AllowedTypes.AddItem('Strafe');
	Template.AbilityCosts.AddItem(ActionPointCost);	
	
	// Ammo
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	return Template;
}

static function X2AbilityTemplate GrimyStrafeBonus(name TemplateName, name AbilityName, float BonusDamage, int BonusMobility, optional bool bStrafe = true, optional int BonusAction = 1) {
	local X2AbilityTemplate						Template;
	local GrimyClassFury_Effect_BonusDamage		DamageEffect;
	local X2Effect_TurnStartActionPoints		ActionPointEffect;
	local X2Effect_PersistentStatChange			StatEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	if ( BonusDamage != 0.0 ) {
		DamageEffect = new class'GrimyClassFury_Effect_BonusDamage';
		DamageEffect.BuildPersistentEffect(1, true, false, false);
		DamageEffect.Bonus = BonusDamage;
		DamageEffect.AbilityName = AbilityName;
		Template.AddTargetEffect(DamageEffect);
	}
	
	if ( bStrafe ) {
		Template.AddTargetEffect(new class'GrimyClassFury_Effect_StrafePoint');
	}

	if ( BonusAction > 0 ) {
		ActionPointEffect = new class'X2Effect_TurnStartActionPoints';
		ActionPointEffect.BuildPersistentEffect(1, true, false, false);
		ActionPointEffect.ActionPointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
		ActionPointEffect.NumActionPoints = BonusAction;
		Template.AddTargetEffect(ActionPointEffect);
	}

	if ( BonusMobility != 0 ) {
		StatEffect = new class'X2Effect_PersistentStatChange';
		StatEffect.BuildPersistentEffect(1, true, false, false);
		StatEffect.AddPersistentStatChange(eStat_Mobility, BonusMobility);
		Template.AddTargetEffect(StatEffect);
	}

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyBonusDamage(name TemplateName, name AbilityName, float BonusDamage, optional int BaseDamage = 0, optional int TierDamage = 0.0) {
	local X2AbilityTemplate						Template;
	local GrimyClassFury_Effect_BonusDamage		DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassFury_Effect_BonusDamage';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.Bonus = BonusDamage;
	DamageEffect.AbilityName = AbilityName;
	DamageEffect.BaseDamage = BaseDamage;
	DamageEffect.TierMult = TierDamage;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyWillToSurvive(name TemplateName, string IconImage, float WillMult) {
	local X2AbilityTemplate						Template;
	local GrimyClassFury_Effect_WillToSurvive	StatEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.IconImage = IconImage;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	StatEffect = new class'GrimyClassFury_Effect_WillToSurvive';
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.WillMult = WillMult;
	Template.AddTargetEffect(StatEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

// UTILITY FUNCTIONS

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

		if ( GrimyClassFury_MultiTarget(AbilityTemplate.AbilityMultiTargetStyle) != none ) {
			while ( AbilityContext.InputContext.MultiTargets.Length > GrimyClassFury_MultiTarget(AbilityTemplate.AbilityMultiTargetStyle).NumTargets ) {
				AbilityContext.InputContext.MultiTargets.Remove(Rand(AbilityContext.InputContext.MultiTargets.length),1);
			}
		}

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