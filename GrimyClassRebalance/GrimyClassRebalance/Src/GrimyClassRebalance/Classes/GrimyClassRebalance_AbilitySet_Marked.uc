class GrimyClassRebalance_AbilitySet_Marked extends X2Ability_AdventCaptain config(GrimyClassRebalance);

var config int COORDINATE_FIRE_COOLDOWN, COORDINATE_FIRE_RADIUS, FOCUS_FIRE_CHARGES;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(GrimyCoordinateFire('GrimyCoordinateFire',default.COORDINATE_FIRE_COOLDOWN, default.COORDINATE_FIRE_RADIUS));
	Templates.AddItem(GrimyFocusFire('GrimyFocusFire',0,default.FOCUS_FIRE_CHARGES));

	return Templates;
}

static function X2AbilityTemplate GrimyCoordinateFire(name TemplateName, int akCooldown, int akRadius) {
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCooldown Cooldown;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2AbilityTrigger_PlayerInput InputTrigger;
	local X2AbilityMultiTarget_Radius MultiTarget;
	local X2Effect_ReturnFire                   FireEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.bCrossClassEligible = true;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_readyforanything";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Defensive;

	// This ability is a free action
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	if ( akCooldown > 0 ) {
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = akCooldown;
	Template.AbilityCooldown = Cooldown;
	}

	//Can't use while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Add dead eye to guarantee
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	// Multi target
	MultiTarget = new class'X2AbilityMultiTarget_Radius';
	MultiTarget.fTargetRadius = akRadius;
	MultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = MultiTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	// The Targets must be within the AOE, LOS, and friendly
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeCivilian = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);

	FireEffect = new class'X2Effect_ReturnFire';
	FireEffect.AbilityToActivate = 'OverwatchShot';
	FireEffect.GrantActionPoint = 'overwatch';
	FireEffect.bPreEmptiveFire = true;
	FireEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	Template.AddMultiTargetEffect(FireEffect);
	Template.AddShooterEffect(FireEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TargetGettingMarked_BuildVisualization;
	
	return Template;
}

static function X2AbilityTemplate GrimyFocusFire(name TemplateName, int akCooldown, int BonusCharges) {
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCooldown Cooldown;
	local X2AbilityTrigger_PlayerInput InputTrigger;
	local array<name>                       SkipExclusions;
	local X2Condition_Visibility            VisibilityCondition;
	local X2AbilityCharges                      Charges;
	local X2AbilityCost_Charges                 ChargeCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
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

	Template.bCrossClassEligible = true;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_burstfire";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Defensive;

	// This ability is a free action
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	if ( akCooldown > 0 ) {
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = akCooldown;
		Template.AbilityCooldown = Cooldown;
	}

	// Add dead eye to guarantee
	Template.AbilityToHitCalc = default.DeadEye;
	
	VisibilityCondition = new class'X2Condition_Visibility';
	VisibilityCondition.bRequireGameplayVisible = true;
	VisibilityCondition.bAllowSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisibilityCondition);
	// Can't target dead; Can't target friendlies
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	// Only at single targets that are in range.
	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);
	
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	//Template.AddTargetEffect(new class'GrimyClassRebalance_Effect_FocusFire');
	
	Template.BuildNewGameStateFn = FocusAbility_BuildGameState;
	//Template.BuildVisualizationFn = TargetGettingMarked_BuildVisualization;
	
	return Template;
}

static function XComGameState FocusAbility_BuildGameState(XComGameStateContext Context)
{
	local XComGameState NewGameState;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);

	FocusAbility_FillOutGameState(NewGameState);

	return NewGameState;
}

static function FocusAbility_FillOutGameState(XComGameState NewGameState)
{
	local XComGameStateHistory History;
	local XComGameState_Ability ShootAbilityState;
	local X2AbilityTemplate AbilityTemplate;
	local XComGameStateContext_Ability AbilityContext;

	local XComGameState_BaseObject AffectedTargetObject_OriginalState;	
	local XComGameState_BaseObject AffectedTargetObject_NewState;
	local XComGameState_BaseObject SourceObject_OriginalState;
	local XComGameState_BaseObject SourceObject_NewState;
	local XComGameState_Item       SourceWeapon, SourceWeapon_NewState;

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

	if (SourceWeapon != none)
	{
		SourceWeapon_NewState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', SourceWeapon.ObjectID));
		NewGameState.AddStateObject(SourceWeapon_NewState);
	}

	//If there is a target location, generate a list of projectile events to use if a projectile is requested
	if(AbilityContext.InputContext.ProjectileEvents.Length > 0)
	{
		GenerateDamageEvents(NewGameState, AbilityContext);
	}

	//  Apply effects to primary target
	if (AbilityContext.InputContext.PrimaryTarget.ObjectID != 0)
	{
		AffectedTargetObject_OriginalState = History.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID, eReturnType_Reference);
		AffectedTargetObject_NewState = NewGameState.CreateStateObject(AffectedTargetObject_OriginalState.Class, AbilityContext.InputContext.PrimaryTarget.ObjectID);
		
		GrimyBuildFocusFire(XComGameState_Unit(SourceObject_NewState), XComGameState_Unit(AffectedTargetObject_NewState));
			
		//NewGameState.AddStateObject(AffectedTargetObject_NewState);

		if (AbilityTemplate.Hostility == eHostility_Offensive && AffectedTargetObject_NewState.CanEarnXp() && XComGameState_Unit(AffectedTargetObject_NewState).IsEnemyUnit(XComGameState_Unit(SourceObject_NewState)))
		{
			`TRIGGERXP('XpGetShotAt', AffectedTargetObject_NewState.GetReference(), SourceObject_NewState.GetReference(), NewGameState);
		}
	}

	//ApplyEffectsToWorld(AbilityContext, SourceObject_OriginalState, ShootAbilityState, NewGameState, AbilityTemplate.AbilityMultiTargetEffects, AbilityTemplate.DataName, TELT_AbilityMultiTargetEffects);

	//Apply the cost of the ability
	AbilityTemplate.ApplyCost(AbilityContext, ShootAbilityState, SourceObject_NewState, SourceWeapon_NewState, NewGameState);
}

static function GrimyBuildFocusFire(XComGameState_Unit SourceUnit, XComGameState_Unit TargetUnit) {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom	XComHQ;
	local XComGameState_Unit				UnitState;
	local int i, SquadID;

	History = `XCOMHISTORY;
	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	CallAbilityOnTarget(SourceUnit, TargetUnit);

	for (i = 0; i < XComHQ.Squad.Length; ++i)
	{
		SquadID = XComHQ.Squad[i].ObjectID;
		if ( SquadID > 0 && SquadID != SourceUnit.ObjectID ) {
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(SquadID));
			if ( UnitState.IsAlive() ) {
				CallAbilityOnTarget(UnitState, TargetUnit);
			}
		}
	}
}

static function CallAbilityOnTarget(XComGameState_Unit ActiveUnit, XComGameState_Unit TargetUnit) {
	local XComGameStateHistory History;
	local StateObjectReference AbilityRef;
	local XComGameState_Ability AbilityState;
	local XComGameStateContext_Ability AbilityContext;
	local array<name> ActionPointList;
	
	History = `XCOMHISTORY;
	AbilityRef = ActiveUnit.FindAbility('StandardShot');
	if ( AbilityRef.ObjectID <= 0 ) {
		AbilityRef = ActiveUnit.FindAbility('SniperStandardFire');
	}
	if ( AbilityRef.ObjectID <= 0 ) {
		AbilityRef = ActiveUnit.FindAbility('PistolStandardShot');
	}

	if ( AbilityRef.ObjectId > 0 ) { 
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
		if ( AbilityState != none ) {
			ActionPointList = ActiveUnit.ActionPoints;
			ActiveUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
			ActiveUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
			if (AbilityState.CanActivateAbilityForObserverEvent(TargetUnit) == 'AA_Success') {
				AbilityContext = class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, TargetUnit.ObjectID);
				if( AbilityContext.Validate() ) {
					`TACTICALRULES.SubmitGameStateContext(AbilityContext);
				}
			}
			else {
				ActiveUnit.ActionPoints = ActionPointList;
			}
		}
	}
}