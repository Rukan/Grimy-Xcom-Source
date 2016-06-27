class X2DownloadableContentInfo_GrimyMorale extends X2DownloadableContentInfo config(GrimyMorale);

var config int PostMissionMorale;

static event OnPostMission() {
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit	UnitState;
	local int idx, Willpower;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Post Mission Morale");
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);

	for(idx = 0; idx < XComHQ.Crew.Length; idx++) {
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[idx].ObjectID));

		if(UnitState != none && UnitState.GetMyTemplateName() == 'Soldier' && !XComHQ.IsUnitInSquad(UnitState.GetReference())) {
			UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			Willpower = UnitState.GetCurrentStat(eStat_Will);
			if ( Willpower < UnitState.GetBaseStat(eStat_Will) ) {
				Willpower = Min(Willpower + default.PostMissionMorale, UnitState.GetBaseStat(eStat_Will));
				UnitState.SetCurrentStat(eStat_Will, Willpower);
				NewGameState.AddStateObject(UnitState);
			}
		}
	}

	if( NewGameState.GetNumGameStateObjects() > 0 )
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	else
		History.CleanupPendingGameState(NewGameState);
}

static event OnPostTemplatesCreated() {
	ModifyWeaponTemplates();
	ModifyStaffSlots();
}

static function ModifyWeaponTemplates() {
	local X2ItemTemplateManager		ItemManager;
	local array<X2WeaponTemplate>	WeaponTemplates;
	local X2WeaponTemplate			WeaponTemplate;
	local array<X2DataTemplate>		DifficultyTemplates;
	local X2DataTemplate			DifficultyTemplate;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	WeaponTemplates = ItemManager.GetAllWeaponTemplates();

	foreach WeaponTemplates(WeaponTemplate) {
		ItemManager.FindDataTemplateAllDifficulties(WeaponTemplate.DataName,DifficultyTemplates);
		foreach DifficultyTemplates(DifficultyTemplate) {
			if ( DifficultyTemplate.IsA('X2WeaponTemplate') ) {
				X2WeaponTemplate(DifficultyTemplate).BonusWeaponEffects.AddItem(new class'GrimyMorale_Effect_Willpower');
			}
			else if ( DifficultyTemplate.IsA('X2GrenadeTemplate') ) {
				X2GrenadeTemplate(DifficultyTemplate).ThrownGrenadeEffects.AddItem(new class'GrimyMorale_Effect_Willpower');
				X2GrenadeTemplate(DifficultyTemplate).LaunchedGrenadeEffects.AddItem(new class'GrimyMorale_Effect_Willpower');
			}
		}
	}
}

static function ModifyStaffSlots() {
	local X2StrategyElementTemplateManager	StrategyManager;
	local X2FacilityTemplate				FacilityTemplate;
	local array<X2DataTemplate>				DifficultyTemplates;
	local X2DataTemplate					DifficultyTemplate;

	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StrategyManager.FindDataTemplateAllDifficulties('BarMemorial',DifficultyTemplates);

	foreach DifficultyTemplates(DifficultyTemplate) {
		FacilityTemplate = X2FacilityTemplate(DifficultyTemplate);
		if ( FacilityTemplate != none ) {
			FacilityTemplate.StaffSlots.AddItem('GrimyBarSlot');
			FacilityTemplate.StaffSlots.AddItem('GrimyBarSlot');
			FacilityTemplate.StaffSlots.AddItem('GrimyBarSlot');
			FacilityTemplate.StaffSlots.AddItem('GrimyBarSlot');
		}
	}
}