class X2DownloadableContentInfo_GrimyClassRebalance extends X2DownloadableContentInfo config(GrimyClassRebalance);

struct FIX_ABILITY_DATA
{
	var name AbilityName;
	var bool bAddSquadsight;
	var bool bEditActionCost;
};

struct BONUS_IMMUNITY
{
	var name ItemName;
	var name AbilityName;
	var name ImmunityName;
};

var config array<FIX_ABILITY_DATA> FIX_ABILITY_LIST;
var config array<name> SUPPRESSION_WEAPONS, FLUSH_WEAPONS;
var config int MAX_PSI_ABILITIES;
var config bool HUNTERS_INSTINCT_ALLOW_MELEE, DEADSHOT_REMOVE_CRIT, COOL_PRESSURE_REMOVE_REACTION_BONUS;
var config int HUNTERS_INSTINCT_DMG;
var config int DEADSHOT_PISTOL_DMG, DEADSHOT_SNIPER_DMG;
var config int COOL_PRESSURE_DMG;
var config int TRIAGE_SHIELD_BONUS, TRIAGE_SHIELD_DURATION;
var config int RESTOCK_PROTOCOL_AMMO, RESTOCK_PROTOCOL_CHARGES;

var config bool bAddGunSmack, bAddSuppression, bAddFlush, bAddSneak, bSniperOverwatchAfterMoving, bDisableVolatileMixDOT;

var config bool bDisableTileSnap;

var config bool DEMOLITION_CANT_MISS, RESTORATIVE_MIST_CURES_INJURIES;
var config int MAYHEM_DMG;

var config array<name> SUPPRESSION_UPGRADES;
var config array<BONUS_IMMUNITY> GRENADE_IMMUNITIES;

var localized string MAYHEM;

static event OnPostTemplatesCreated()
{
	EditStaffSlots();
	EditVanillaAbilities();
	ApplyAbilityFixes();
	UpdateWeaponAbilities();
	UpdateGTSAbilities();
	AddCharacterAbilities();
}

static function EditStaffSlots() {
	local X2StrategyElementTemplateManager	StrategyManager;
	local X2StaffSlotTemplate				StaffTemplate;

	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StaffTemplate = X2StaffSlotTemplate(StrategyManager.FindStrategyElementTemplate('PsiChamberSoldierStaffSlot'));

	StaffTemplate.ShouldDisplayToDoWarningFn = ShouldDisplayPsiChamberSoldierToDoWarning;
	StaffTemplate.IsUnitValidForSlotFn = IsUnitValidForPsiChamberSoldierSlot;
}

static function bool ShouldDisplayPsiChamberSoldierToDoWarning(StateObjectReference SlotRef)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_StaffSlot SlotState;
	local XComGameState_Unit Unit;
	local StaffUnitInfo UnitInfo;
	local int i;

	History = `XCOMHISTORY;
	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	SlotState = XComGameState_StaffSlot(History.GetGameStateForObjectID(SlotRef.ObjectID));

	for (i = 0; i < XComHQ.Crew.Length; i++)
	{
		UnitInfo.UnitRef = XComHQ.Crew[i];
		Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.Crew[i].ObjectID));

		if (Unit.GetSoldierClassTemplateName() == 'PsiOperative' && IsUnitValidForPsiChamberSoldierSlot(SlotState, UnitInfo))
		{
			return true;
		}
	}

	return false;
}

static function bool IsUnitValidForPsiChamberSoldierSlot(XComGameState_StaffSlot SlotState, StaffUnitInfo UnitInfo)
{
	local XComGameState_Unit Unit; 
	local X2SoldierClassTemplate SoldierClassTemplate;
	local SCATProgression ProgressAbility;
	local name AbilityName;
	local int NumLearned;
	
	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitInfo.UnitRef.ObjectID));

	if (Unit.IsASoldier()
		&& !Unit.IsInjured()
		&& !Unit.IsTraining()
		&& !Unit.IsPsiTraining()
		&& !Unit.IsPsiAbilityTraining())
	{
		if (Unit.GetRank() == 0 && !Unit.CanRankUpSoldier()) // All rookies who have not yet ranked up can be trained as Psi Ops
		{
			return true;
		}
		else if (Unit.GetSoldierClassTemplateName() == 'PsiOperative') // But Psi Ops can only train until they learn all abilities
		{
			NumLearned = 0;
			SoldierClassTemplate = Unit.GetSoldierClassTemplate();
			foreach Unit.PsiAbilities(ProgressAbility)
			{
				AbilityName = SoldierClassTemplate.GetAbilityName(ProgressAbility.iRank, ProgressAbility.iBranch);
				if (AbilityName != '' )
				{	
					if ( Unit.HasSoldierAbility(AbilityName) ) {
						NumLearned++;
						if ( NumLearned > GetMaxPsiAbilities() ) {
							return false;
						}
					}
					else {
						return true; // If we find an ability that the soldier hasn't learned yet, they are valid
					}
				}
			}
		}
	}

	return false;
}

static function EditVanillaAbilities() {
	local X2AbilityTemplateManager							AbilityManager;
	local X2AbilityTemplate									AbilityTemplate;
	local GrimyClassRebalance_Effect_Shadowstrike			ShadowEffect;
	local X2Condition_Visibility							VisCondition;
	local X2Condition_AbilityProperty						AbilityCondition;
	local X2Effect_PersistentStatChange						PersistentStatChangeEffect;
	local GrimyClassRebalance_AbilityCharges_Restock		RestockCharges;
	local GrimyClassRebalance_Effect_Restock				RestockEffect;
	local GrimyClassRebalance_Effect_EverVigilant			VigilantEffect;
	local X2Effect_ApplyWeaponDamage						WeaponDamageEffect;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	local GrimyClassRebalance_Effect_VolatileMix			MixEffect;
	local X2Effect_DamageImmunity							DamageImmunity;
	local BONUS_IMMUNITY									GrenadeImmunity;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	//AbilityTemplate = AbilityManager.FindAbilityTemplate('Stealth');
	//AbilityTemplate.OverrideAbilities.AddItem('GrimyStealth');

	AbilityTemplate = AbilityManager.FindAbilityTemplate('SwordSlice');

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Shadowstrike');
	ShadowEffect = new class'GrimyClassRebalance_Effect_Shadowstrike';
	ShadowEffect.EffectName = 'Shadowstrike';
	ShadowEffect.DuplicateResponse = eDupe_Ignore;
	ShadowEffect.BuildPersistentEffect(1, true, false);
	ShadowEffect.SetDisplayInfo(ePerkBuff_Passive, AbilityTemplate.LocFriendlyName, AbilityTemplate.GetMyLongDescription(), AbilityTemplate.IconImage,,,AbilityTemplate.AbilitySourceName);
	ShadowEffect.AddEffectHitModifier(eHit_Success, class'X2Ability_RangerAbilitySet'.default.SHADOWSTRIKE_AIM, AbilityTemplate.LocFriendlyName);
	ShadowEffect.AddEffectHitModifier(eHit_Crit, class'X2Ability_RangerAbilitySet'.default.SHADOWSTRIKE_CRIT, AbilityTemplate.LocFriendlyName);
	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bExcludeGameplayVisible = true;
	ShadowEffect.ToHitConditions.AddItem(VisCondition);
	class'GrimyClassRebalance_Helper_Abilities'.static.GrimyInjectTargetEffect(AbilityTemplate, ShadowEffect, 0);

	AbilityTemplate = AbilityManager.FindAbilityTemplate('AidProtocol');
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(default.TRIAGE_SHIELD_DURATION, false, true, false, eGameRule_PlayerTurnBegin);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, GetTriageBonus());
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyTriageProtocol');
	PersistentStatChangeEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(PersistentStatChangeEffect);

	AbilityTemplate.AbilityCosts.AddItem(new class'GrimyClassRebalance_AbilityCost_RestockCharges');

	RestockCharges = new class'GrimyClassRebalance_AbilityCharges_Restock';
	RestockCharges.InitialCharges = default.RESTOCK_PROTOCOL_CHARGES;
	AbilityTemplate.AbilityCharges = RestockCharges;

	RestockEffect = new class'GrimyClassRebalance_Effect_Restock';
	RestockEffect.AmmoCount = default.RESTOCK_PROTOCOL_AMMO;
	RestockEffect.ForPrimary = true;
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimySupplyProtocol');
	RestockEffect.TargetConditions.AddItem(AbilityCondition);
	RestockEffect.TargetConditions.AddItem(new class'GrimyClassRebalance_Condition_Restock');
	AbilityTemplate.AddTargetEffect(RestockEffect);
	
	AbilityTemplate = AbilityManager.FindAbilityTemplate('EverVigilantTrigger');
	AbilityTemplate.AdditionalAbilities.RemoveItem('EverVigilantTrigger');

	VigilantEffect = new class'GrimyClassRebalance_Effect_EverVigilant';
	VigilantEffect.BuildPersistentEffect(1, true, false, , eGameRule_PlayerTurnEnd); 
	VigilantEffect.DuplicateResponse = eDupe_Allow;
	AbilityTemplate.AddTargetEffect(VigilantEffect);

	if ( default.DEMOLITION_CANT_MISS ) {
		AbilityTemplate = AbilityManager.FindAbilityTemplate('Demolition');
		AbilityTemplate.AbilityToHitCalc = new class'X2AbilityToHitCalc_DeadEye';
	}

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Suppression');
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.EffectDamageValue.Damage = default.MAYHEM_DMG;
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('GrimyMayhem');
	WeaponDamageEffect.TargetConditions.AddItem(AbilityCondition);
	AbilityTemplate.AddTargetEffect(WeaponDamageEffect);
	
	if ( default.RESTORATIVE_MIST_CURES_INJURIES ) {
		AbilityTemplate = AbilityManager.FindAbilityTemplate('RestorativeMist');
		AbilityTemplate.AddMultiTargetEffect(new class'GrimyClassRebalance_Effect_RestoreInjuries');
	}

	if ( GetbSniperOverwatchAfterMoving() ) {
		ActionPointCost = new class'X2AbilityCost_ActionPoints';
		ActionPointCost.iNumPoints = 1;
		ActionPointCost.bConsumeAllPoints = true;
		ActionPointCost.bFreeCost = true;           //  ReserveActionPoints effect will take all action points away
		ActionPointCost.DoNotConsumeAllEffects.Length = 0;
		ActionPointCost.DoNotConsumeAllSoldierAbilities.Length = 0;

		AbilityTemplate = AbilityManager.FindAbilityTemplate('LongWatch');
		AbilityTemplate.AbilityCosts[1] = ActionPointCost;
		AbilityTemplate = AbilityManager.FindAbilityTemplate('SniperRifleOverwatch');
		AbilityTemplate.AbilityCosts[1] = ActionPointCost;
	}

	if ( GetbDisableVolatileMixDOT() ) {
		AbilityTemplate = AbilityManager.FindAbilityTemplate('VolatileMix');

		MixEffect = new class'GrimyClassRebalance_Effect_VolatileMix';
		MixEffect.BuildPersistentEffect(1, true, true, true);
		MixEffect.SetDisplayInfo(ePerkBuff_Passive, AbilityTemplate.LocFriendlyName, AbilityTemplate.GetMyLongDescription(), AbilityTemplate.IconImage,,,AbilityTemplate.AbilitySourceName);
		MixEffect.BonusDamage = class'X2Ability_GrenadierAbilitySet'.default.VOLATILE_DAMAGE;
		class'GrimyClassRebalance_Helper_Abilities'.static.GrimyInjectTargetEffect(AbilityTemplate, MixEffect, 0);
	}

	if ( GetbDisableTileSnap() ) {
		AbilityTemplate = AbilityManager.FindAbilityTemplate('AcidBlob');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_Grenade';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('ThrowGrenade');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_Grenade';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('LaunchGrenade');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_Grenade';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('Battlescanner');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_Grenade';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('CapacitorDischarge');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_GremlinAOE';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('AnimaInversion');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_MassReanimation';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('AnimaInversionMP');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_MassReanimation';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('MicroMissiles');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_MECMicroMissile';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('MimicBeaconThrow');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_MimicBeacon';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('RocketLauncher');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_RocketLauncher';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('PoisonSpit');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_ViperSpit';
		AbilityTemplate = AbilityManager.FindAbilityTemplate('VoidRift');
		AbilityTemplate.TargetingMethod = class'GrimyClassRebalance_TargetingMethod_VoidRift';
	}

	foreach default.GRENADE_IMMUNITIES(GrenadeImmunity) {
		if ( GrenadeImmunity.AbilityName != '' ) {
			AbilityTemplate = AbilityManager.FindAbilityTemplate(GrenadeImmunity.AbilityName);
			DamageImmunity = new class'X2Effect_DamageImmunity';
			DamageImmunity.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
			DamageImmunity.ImmuneTypes.AddItem(GrenadeImmunity.ImmunityName);
			AbilityTemplate.AddMultiTargetEffect(DamageImmunity);
		}
	}
}

static function AddCharacterAbilities() {
	local X2CharacterTemplateManager	CharManager;
	local X2CharacterTemplate			CharTemplate;

	local array<X2DataTemplate>		DifficultyTemplates;
	local X2DataTemplate			DifficultyTemplate;

	CharManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	CharManager.FindDataTemplateAllDifficulties('Soldier',DifficultyTemplates);
	
	foreach DifficultyTemplates(DifficultyTemplate) {
		CharTemplate = X2CharacterTemplate(DifficultyTemplate);
		if ( CharTemplate != none ) {
			if ( GetbAddSneak() ) {
				CharTemplate.Abilities.AddItem('GrimyStealth');
			}
			if ( GetbAddGunsmack() ) {
				CharTemplate.Abilities.AddItem('GrimyGunSmackPassive');
			}
		}
	}
}

static function ApplyAbilityFixes() {
	local X2AbilityTemplateManager	AbilityManager;
	local FIX_ABILITY_DATA			AbilityData;
	
	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	foreach default.FIX_ABILITY_LIST(AbilityData) {
		ApplyAbilityFix(AbilityManager.FindAbilityTemplate(AbilityData.AbilityName), AbilityData.bAddSquadsight, AbilityData.bEditActionCost);
	}
}

static function ApplyAbilityFix(X2AbilityTemplate Template, bool bAddSquadsight, bool bEditActionCost) {
	local int i;
	local X2Condition_Visibility            TargetVisibilityCondition;
	local X2AbilityCost_ActionPoints        ActionPointCost;

	if ( Template == none ) { return; }

	if ( bAddSquadsight ) {
		for ( i=0; i<Template.AbilityTargetConditions.length; i++ ) {
			if ( Template.AbilityTargetConditions[i].IsA('X2Condition_Visibility') ) {
				TargetVisibilityCondition = X2Condition_Visibility(Template.AbilityTargetConditions[i]);
				TargetVisibilityCondition.bAllowSquadsight = true;
				Template.AbilityTargetConditions[i] = TargetVisibilityCondition;
				break;
			}
		}
	}
	if ( bEditActionCost ) {
		for ( i=0; i<Template.AbilityCosts.length; i++ ) {
			if ( Template.AbilityCosts[i].IsA('X2AbilityCost_ActionPoints') ) {
				ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[i]);
				ActionPointCost.iNumPoints = 0;
				ActionPointCost.bAddWeaponTypicalCost = true;
				Template.AbilityCosts[i] = ActionPointCost;
				break;
			}
		}
	}
}

static function UpdateWeaponAbilities() {
	local X2ItemTemplateManager		ItemManager;
	local array<X2WeaponTemplate>	WeaponTemplates;
	local X2WeaponTemplate			WeaponTemplate;
	local X2WeaponUpgradeTemplate	WeaponUpgradeTemplate;

	local array<X2DataTemplate>		DifficultyTemplates;
	local X2DataTemplate			DifficultyTemplate;
	local name						TemplateName;
	local X2GrenadeTemplate			GrenadeTemplate;
	local X2Effect_DamageImmunity	DamageImmunity;
	local BONUS_IMMUNITY			GrenadeImmunity;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	WeaponTemplates = ItemManager.GetAllWeaponTemplates();

	foreach WeaponTemplates(WeaponTemplate) {
		if ( WeaponTemplate.iClipSize >= 2 ) {
			if ( GetbAddSuppression() && default.SUPPRESSION_WEAPONS.find(WeaponTemplate.WeaponCat) != INDEX_NONE && WeaponTemplate.Abilities.Find('Suppression') == INDEX_NONE ) {
				ItemManager.FindDataTemplateAllDifficulties(WeaponTemplate.DataName,DifficultyTemplates);
				foreach DifficultyTemplates(DifficultyTemplate) {
					WeaponTemplate = X2WeaponTemplate(DifficultyTemplate);
					if ( WeaponTemplate != none && WeaponTemplate.Abilities.Find('Suppression') == INDEX_NONE ) {
						WeaponTemplate.Abilities.AddItem('Suppression');
					}
				}
			}

			if ( GetbAddFlush() && default.FLUSH_WEAPONS.find(WeaponTemplate.WeaponCat) != INDEX_NONE && WeaponTemplate.Abilities.Find('GrimyFlush') == INDEX_NONE  ) {
				ItemManager.FindDataTemplateAllDifficulties(WeaponTemplate.DataName,DifficultyTemplates);
				foreach DifficultyTemplates(DifficultyTemplate) {
					if ( DifficultyTemplate.IsA('X2WeaponTemplate') ) {
						X2WeaponTemplate(DifficultyTemplate).Abilities.AddItem('GrimyFlush');
					}
				}
			}
		}
	}

	if ( GetbAddSuppression() ) {
		foreach default.SUPPRESSION_UPGRADES(TemplateName) {
			ItemManager.FindDataTemplateAllDifficulties('TemplateName',DifficultyTemplates);
			foreach DifficultyTemplates(DifficultyTemplate) {
				WeaponUpgradeTemplate = X2WeaponUpgradeTemplate(DifficultyTemplate);
				if ( WeaponUpgradeTemplate != none ) {
					WeaponUpgradeTemplate.BonusAbilities.RemoveItem('Suppression');
					WeaponUpgradeTemplate.BonusAbilities.AddItem('GrimyMayhem');
					WeaponUpgradeTemplate.TinySummary = Repl(WeaponUpgradeTemplate.TinySummary,"Suppression",default.MAYHEM);
					class'GrimyClassRebalance_Helper_WeaponUpgradeTemplate'.static.ReplaceBriefSummary(WeaponUpgradeTemplate,"suppression",default.MAYHEM);
				}
			}
		}
	}
	
	foreach default.GRENADE_IMMUNITIES(GrenadeImmunity) {
		if ( GrenadeImmunity.ItemName != '' ) {
			ItemManager.FindDataTemplateAllDifficulties(GrenadeImmunity.ItemName,DifficultyTemplates);
			foreach DifficultyTemplates(DifficultyTemplate) {
				GrenadeTemplate = X2GrenadeTemplate(DifficultyTemplate);
				if ( GrenadeTemplate != none ) {
					DamageImmunity = new class'X2Effect_DamageImmunity';
					DamageImmunity.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
					DamageImmunity.ImmuneTypes.AddItem(GrenadeImmunity.ImmunityName);
					GrenadeTemplate.ThrownGrenadeEffects.AddItem(DamageImmunity);
					GrenadeTemplate.LaunchedGrenadeEffects.AddItem(DamageImmunity);
				}
			}
		}
	}
}

static function UpdateGTSAbilities() {
	local X2AbilityTemplateManager							AbilityManager;
	local X2AbilityTemplate									Template;
	local GrimyClassRebalance_Effect_HuntersInstinct		HuntersInstinctEffect;
	local GrimyClassRebalance_Effect_Deadshot				DeadshotEffect;
	local GrimyClassRebalance_Effect_CoolPressure			CoolPressureEffect;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	Template = AbilityManager.FindAbilityTemplate('HuntersInstinct');
	HuntersInstinctEffect = new class'GrimyClassRebalance_Effect_HuntersInstinct';
	HuntersInstinctEffect.BonusDamage = default.HUNTERS_INSTINCT_DMG;
	HuntersInstinctEffect.bAllowMelee = default.HUNTERS_INSTINCT_ALLOW_MELEE;
	HuntersInstinctEffect.BuildPersistentEffect(1, true, true, true);
	HuntersInstinctEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	class'GrimyClassRebalance_Helper_Abilities'.static.GrimyInjectTargetEffect(Template, HuntersInstinctEffect, 0);

	Template = AbilityManager.FindAbilityTemplate('HitWhereItHurts');
	DeadshotEffect = new class'GrimyClassRebalance_Effect_Deadshot';
	DeadshotEffect.PrimaryBonus = default.DEADSHOT_SNIPER_DMG;
	DeadshotEffect.SecondaryBonus = default.DEADSHOT_PISTOL_DMG;
	DeadshotEffect.BuildPersistentEffect(1, true, true, true);
	DeadshotEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	if ( default.DEADSHOT_REMOVE_CRIT ) {
		class'GrimyClassRebalance_Helper_Abilities'.static.GrimyInjectTargetEffect(Template, DeadshotEffect, 0);
	}
	else {
		Template.AddTargetEffect(DeadshotEffect);
	}

	Template = AbilityManager.FindAbilityTemplate('CoolUnderPressure');
	CoolPressureEffect = new class'GrimyClassRebalance_Effect_CoolPressure';
	CoolPressureEffect.bonusDamage = default.COOL_PRESSURE_DMG;
	CoolPressureEffect.BuildPersistentEffect(1, true, true, true);
	CoolPressureEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);

	if ( default.COOL_PRESSURE_REMOVE_REACTION_BONUS ) {
		class'GrimyClassRebalance_Helper_Abilities'.static.GrimyInjectTargetEffect(Template, CoolPressureEffect, 0);
	}
	else {
		Template.AddTargetEffect(CoolPressureEffect);
	}

	//Template = AbilityManager.FindAbilityTemplate('BiggestBooms');
}

static function bool GetbAddGunsmack() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bAddGunSmack;
	else
		return default.bAddGunSmack;
}

static function bool GetbAddSuppression() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bAddSuppression;
	else
		return default.bAddSuppression;
}

static function bool GetbAddFlush() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bAddFlush;
	else
		return default.bAddFlush;
}

static function bool GetbAddSneak() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bAddSneak;
	else
		return default.bAddSneak;
}

static function bool GetbSniperOverwatchAfterMoving() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bSniperOverwatchAfterMoving;
	else
		return default.bSniperOverwatchAfterMoving;
}

static function bool GetbDisableVolatileMixDOT() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bDisableVolatileMixDOT;
	else
		return default.bDisableVolatileMixDOT;
}

static function bool GetbDisableTileSnap() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SETTINGS_CHANGED ) 
		return class'GrimyClassRebalance_Listener_MCM'.default.bDisableTileSnap;
	else
		return default.bDisableTileSnap;
}


static function int GetMaxPsiAbilities() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.MAX_PSI_ABILITIES > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.MAX_PSI_ABILITIES;
	else
		return default.MAX_PSI_ABILITIES;
}

static function int GetTriageBonus() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.TRIAGE_SHIELD_BONUS > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.TRIAGE_SHIELD_BONUS;
	else
		return default.TRIAGE_SHIELD_BONUS;
}