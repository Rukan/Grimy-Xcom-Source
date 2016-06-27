class X2DownloadableContentInfo_GrimyAttrition extends X2DownloadableContentInfo config(GrimyAttrition);

struct BONUS_AMMO_DATA
{
	var name AbilityName;
	var int Ammo;
	var bool bPrimary;
};

//var config int RESTOCK_AMMO_AMOUNT;
var config array<BONUS_AMMO_DATA> BONUS_AMMO_ABILITIES;

static event OnPostTemplatesCreated() {
	UpdateAbilities();
	UpdateFacilities();
}

static function UpdateAbilities() {
	local X2AbilityTemplateManager				AbilityManager;
	local X2AbilityTemplate						EditAbility;
	local GrimyAttrition_AbilityCharges			Charges;
	local GrimyAttrition_AbilityCost			ChargesCost;
	local GrimyAttrition_WeaponCondition		WeaponCondition;
	local BONUS_AMMO_DATA						AmmoData;
	local GrimyAttrition_BonusReserves			AmmoEffect;

	//local X2AbilityCost_Ammo					AmmoCost;
	
	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	
	// Edit Existing Abilities
	AmmoEffect = new class'GrimyAttrition_BonusReserves';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	foreach default.BONUS_AMMO_ABILITIES(AmmoData) {
		EditAbility = AbilityManager.FindAbilityTemplate(AmmoData.AbilityName);
		if ( EditAbility != none ) {
			AmmoEffect.AmmoCount = AmmoData.Ammo;
			AmmoEffect.ForPrimary = AmmoData.bPrimary;
			EditAbility.AddTargetEffect(AmmoEffect);
			EditAbility.LocHelpText = EditAbility.LocHelpText $ " +" $ AmmoData.Ammo $ " Reserve Ammo.";
			EditAbility.LocLongDescription = EditAbility.LocLongDescription $ "\n+" $ AmmoData.Ammo $ " Reserve Ammo.";
		}
	}

	// Edit Reload Mechanics
	if ( class'GrimyAttrition_AbilityCharges'.default.DEFAULT_RESERVE > 0 ) {
		EditAbility = AbilityManager.FindAbilityTemplate('Reload');

		EditAbility.BuildNewGameStateFn = GrimyReloadAbility_BuildGameState;

		Charges = new class'GrimyAttrition_AbilityCharges';
		EditAbility.AbilityCharges = Charges;

		ChargesCost = new class'GrimyAttrition_AbilityCost';
		EditAbility.AbilityCosts.AddItem(ChargesCost);

		WeaponCondition = new class'GrimyAttrition_WeaponCondition';
		WeaponCondition.WantsReload = true;
		EditAbility.AbilityShooterConditions[1]=WeaponCondition;

		EditAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		EditAbility.HideErrors.additem('AA_AmmoUnlimited');
		EditAbility.HideErrors.AddItem('AA_CannotAfford_Charges');
		EditAbility.HideErrors.AddItem('AA_AmmoAlreadyFull');
	}

	// Edit Loot Ability to Refund Ammo
	//EditAbility = AbilityManager.FindAbilityTemplate('Loot');

	//EditAbility.BuildNewGameStateFn = GrimyLootAbility_BuildGameState;
	
	// Add ammo costs to pistols
	/*
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;

	EditAbility = AbilityManager.FindAbilityTemplate('PistolReturnFire');
	EditAbility.AbilityCosts.AddItem(AmmoCost);

	EditAbility = AbilityManager.FindAbilityTemplate('PistolOverwatchShot');
	EditAbility.AbilityCosts.AddItem(AmmoCost);
	// need to add faceoff/fanfire/etc
	// decided against implementing this for the time being
	*/
}

static function UpdateFacilities() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local array<X2DataTemplate>					DifficultyTemplates;
	local X2DataTemplate						DifficultyTemplate;

	// Add Strategy Unlocks
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StrategyManager.FindDataTemplateAllDifficulties('OfficerTrainingSchool',DifficultyTemplates);	
	foreach DifficultyTemplates(DifficultyTemplate) {
		X2FacilityTemplate(DifficultyTemplate).SoldierUnlockTemplates.AddItem('GrimyDeepReservesUnlock');
	}
}

simulated function XComGameState GrimyReloadAbility_BuildGameState( XComGameStateContext Context )
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Ability AbilityState;
	local XComGameState_Item WeaponState, NewWeaponState;
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local bool bFreeReload;
	local int i;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);	
	AbilityContext = XComGameStateContext_Ability(Context);	
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID( AbilityContext.InputContext.AbilityRef.ObjectID ));

	WeaponState = AbilityState.GetSourceWeapon();
	NewWeaponState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', WeaponState.ObjectID));

	UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));	
	
	if ( AbilityState.iCharges > NewWeaponState.GetClipSize() ) {
		NewWeaponState.Ammo = NewWeaponState.GetClipSize();
		AbilityState.iCharges -= NewWeaponState.GetClipSize() - WeaponState.Ammo;
	}
	else {
		NewWeaponState.Ammo = AbilityState.iCharges;
		AbilityState.iCharges = 0;
	}

	//  check for free reload upgrade
	bFreeReload = false;
	WeaponUpgrades = WeaponState.GetMyWeaponUpgradeTemplates();
	for (i = 0; i < WeaponUpgrades.Length; ++i)
	{
		if (WeaponUpgrades[i].FreeReloadCostFn != none && WeaponUpgrades[i].FreeReloadCostFn(WeaponUpgrades[i], AbilityState, UnitState))
		{
			bFreeReload = true;
			break;
		}
	}
	if (!bFreeReload)
		AbilityState.GetMyTemplate().ApplyCost(AbilityContext, AbilityState, UnitState, NewWeaponState, NewGameState);	

	//  refill the weapon's ammo	
	
	NewGameState.AddStateObject(UnitState);
	NewGameState.AddStateObject(NewWeaponState);

	return NewGameState;	
}

/*
simulated function XComGameState GrimyLootAbility_BuildGameState(XComGameStateContext Context)
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_BaseObject TargetState;
	local XComGameState_Unit UnitState;
	local StateObjectReference AbilityRef;
	local XComGameState_Ability AbilityState;

	// first, build game state like normal
	NewGameState = class'X2Ability'.static.TypicalAbility_BuildGameState(Context);

	// then complete the loot action
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(Context);

	TargetState = History.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID);
	if( TargetState != none )
	{
		TargetState = NewGameState.CreateStateObject(TargetState.Class, TargetState.ObjectID);
		NewGameState.AddStateObject(TargetState);

		// award all loot on the hacked object to the hacker
		Lootable(TargetState).MakeAvailableLoot(NewGameState);
		class'Helpers'.static.AcquireAllLoot(Lootable(TargetState), AbilityContext.InputContext.SourceObject, NewGameState);
	}
	
	UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));	
	foreach UnitState.Abilities(AbilityRef) {
		AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID( AbilityRef.ObjectID ));
		if ( AbilityState.GetMyTemplateName() == 'Reload' ) {
			AbilityState.iCharges += default.RESTOCK_AMMO_AMOUNT;
		}
	}

	return NewGameState;
}
*/