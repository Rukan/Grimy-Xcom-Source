class GrimyClassRebalance_AbilitySet_Ranger extends X2Ability_RangerAbilitySet config(GrimyClassRebalance);

var config int SNEAK_COOLDOWN, SNEAK_DURATION;
var config int WILL_TO_FIGHT_BASE;
var config float WILL_TO_FIGHT_MULT;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(GrimyStealth('GrimyStealth', GetSneakCooldown(), default.SNEAK_DURATION));
	Templates.AddItem(GrimyWillToFight('GrimyWillToFight', default.WILL_TO_FIGHT_BASE, default.WILL_TO_FIGHT_MULT));
	Templates.Additem(GrimyCloseCombat('GrimyCloseCombat', "img:///UILibrary_PerkIcons.UIPerk_closecombatspecialist"));

	return Templates;
}

static function int GetSneakCooldown() {
	if ( class'GrimyClassRebalance_Listener_MCM'.default.SNEAK_COOLDOWN > 0 )
		return class'GrimyClassRebalance_Listener_MCM'.default.SNEAK_COOLDOWN;
	else
		return default.SNEAK_COOLDOWN;
}

static function X2AbilityTemplate GrimyCloseCombat(name TemplateName, string akIconImage) {
	local X2AbilityTemplate						Template;
	local X2AbilityToHitCalc_StandardAim		StandardAim;
	local X2AbilityCost_Ammo					AmmoCost;

	local X2AbilityTrigger_Event					Trigger;
	local X2AbilityTrigger_EventListener			EventListener;
	local X2Effect_Persistent						BladestormTargetEffect;
	local X2Condition_UnitEffectsWithAbilitySource	BladestormTargetCondition;
	local X2Condition_Visibility					TargetVisibilityCondition;
	local X2Condition_UnitProperty					PropertyCondition;
	local X2Condition_UnitProperty					ShooterCondition;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot(TemplateName);

	Template.IconImage = akIconImage;
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;

	Template.AbilityCosts.length = 0;
	
	Template.bDontDisplayInAbilitySummary = true;
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;	
	Template.AbilityCosts.AddItem(AmmoCost);
	
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bReactionFire = true;
	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;

	//  trigger on movement
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	Trigger.MethodName = 'PostBuildGameState';
	Template.AbilityTriggers.AddItem(Trigger);
	//  trigger on an attack
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_AttackObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);

	//  it may be the case that enemy movement caused a concealment break, which made Bladestorm applicable - attempt to trigger afterwards
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitConcealmentBroken';
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = BladestormConcealmentListener;
	EventListener.ListenerData.Priority = 55;
	Template.AbilityTriggers.AddItem(EventListener);

	BladestormTargetEffect = new class'X2Effect_Persistent';
	BladestormTargetEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
	BladestormTargetEffect.EffectName = 'GrimyCloseCombatTarget';
	BladestormTargetEffect.bApplyOnMiss = true; //Only one chance, even if you miss (prevents crazy flailing counter-attack chains with a Muton, for example)
	Template.AddTargetEffect(BladestormTargetEffect);
	
	ShooterCondition = new class'X2Condition_UnitProperty';
	ShooterCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ShooterCondition);

	Template.AbilityTargetConditions.length = 0;

	BladestormTargetCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	BladestormTargetCondition.AddExcludeEffect('GrimyCloseCombatTarget', 'AA_DuplicateEffectIgnored');
	Template.AbilityTargetConditions.AddItem(BladestormTargetCondition);

	Template.AbilityTargetConditions.AddItem(new class'GrimyClassRebalance_Condition_Distance');

	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	PropertyCondition = new class'X2Condition_UnitProperty';
	PropertyCondition.ExcludeFriendlyToSource = true;
	Template.AbilityTargetConditions.AddItem(PropertyCondition);

	return Template;
}

static function X2AbilityTemplate GrimyWillToFight(name TemplateName, int akBase, float akMult)
{
	local X2AbilityTemplate						Template;
	local GrimyClassRebalance_Effect_WillToFight            DamageEffect;

	// Icon Properties
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_closecombatspecialist";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassRebalance_Effect_WillToFight';
	DamageEffect.BonusBase = akBase;
	DamageEffect.BonusMult = akMult;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}


static function X2AbilityTemplate GrimyStealth(name TemplateName, int akCooldown, int akDuration) {
	local X2AbilityTemplate						Template;
	local GrimyClassRebalance_Effect_RangerStealth                StealthEffect;
	local X2AbilityCooldown						Cooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_UnitIsConcealed');
	Template.HideErrors.AddItem('AA_UnitIsFlanked');
	Template.HideErrors.AddItem('AA_UnitIsOverwatched');
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_stealth";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityCosts.AddItem(default.FreeActionCost);
	
	if ( akCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = akCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityShooterConditions.AddItem(new class'GrimyClassRebalance_Condition_Stealth');

	StealthEffect = new class'GrimyClassRebalance_Effect_RangerStealth';
	StealthEffect.EffectName = 'GrimyStealthEffect';
	StealthEffect.BuildPersistentEffect(akDuration, false, true, false, eGameRule_PlayerTurnEnd);
	StealthEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true);
	StealthEffect.bRemoveWhenTargetConcealmentBroken = true;
	Template.AddTargetEffect(StealthEffect);

	Template.AddTargetEffect(class'X2Effect_Spotted'.static.CreateUnspottedEffect());

	Template.ActivationSpeech = 'ActivateConcealment';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;

	return Template;
}