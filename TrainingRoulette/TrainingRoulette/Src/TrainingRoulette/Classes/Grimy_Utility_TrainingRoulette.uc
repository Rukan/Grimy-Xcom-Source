class Grimy_Utility_TrainingRoulette extends object config(GrimyTrainingRoulette);

struct GrimySkill {
	var name AbilityName;
	var EInventorySlot ApplyToWeaponSlot;
	var name UtilityCat;
	var name WeaponCat;
};

var config array<GrimySkill> ModRouletteSkills;

static function UpdateBarracks() {
	local array<XComGameState_Unit> SoldierList;
	local XComGameState_HeadquartersXCom XcomHQ;
	local XComGameState_Unit		SoldierUnit;
	local GrimyGameState_Unit_TrainingRoulette RouletteState;
	local name ClassTemplate;
	local X2SoldierClassTemplateManager ClassManager;
	local XComGameState NewGameState;

	XComHQ = `XCOMHQ;
	if (XComHQ != none ) {
		ClassManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
		SoldierList = XComHQ.GetSoldiers();
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Roulette Soldiers");

		foreach SoldierList(SoldierUnit) {
			if ( SoldierUnit.GetSoldierRank() > 0 && SoldierUnit.GetSoldierClassTemplateName() != 'PsiOperative' && SoldierUnit.GetSoldierClassTemplateName() != '' ) {
				RouletteState = GrimyGameState_Unit_TrainingRoulette(SoldierUnit.FindComponentObject(class'GrimyGameState_Unit_TrainingRoulette'));
				if ( RouletteState == none ) {
					MakeRouletteSoldier(SoldierUnit, NewGameState);
				}
				else if ( RouletteState.OriginalTemplateName == '' ) {
					MakeRouletteSoldier(SoldierUnit, NewGameState);
				}
				else if ( ClassManager.FindSoldierClassTemplate(SoldierUnit.GetSoldierClassTemplateName()) == none ) {
					ClassTemplate = RouletteState.AddToManager();
					SoldierUnit.SetSoldierClassTemplate(ClassTemplate);
				}
			}
		}
		
		`XCOMHISTORY.AddGameStateToHistory(NewGameState);
	}
}

static function MakeRouletteSoldier(XComGameState_Unit Soldier, XComGameState NewGameState) {
	local GrimyGameState_Unit_TrainingRoulette RouletteState;
	local XComGameState_Unit NewUnitState;
	local name ClassTemplate;

	RouletteState = GrimyGameState_Unit_TrainingRoulette(NewGameState.CreateStateObject(class'GrimyGameState_Unit_TrainingRoulette'));
	NewUnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', Soldier.ObjectID));

	RouletteState.RandomizeWeaponsAndPerks(Soldier.GetSoldierClassTemplate());
	ClassTemplate = RouletteState.AddToManager();
	NewUnitState.AddComponentObject(RouletteState);
	NewUnitState.SetSoldierClassTemplate(ClassTemplate);

	NewGameState.AddStateObject(RouletteState);
	NewGameState.AddStateObject(NewUnitState);
}

// Utility Functions
static function PopulateModSkills() {
	local X2SoldierClassTemplateManager ClassManager;
	local array<X2SoldierClassTemplate> ClassTemplates;
	local X2SoldierClassTemplate		ClassTemplate;
	
	ClassManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	ClassTemplates = ClassManager.GetAllSoldierClassTemplates(true);

	// disregard the vanilla classes
	ClassTemplates.RemoveItem(ClassManager.FindSoldierClassTemplate('Ranger'));
	ClassTemplates.RemoveItem(ClassManager.FindSoldierClassTemplate('Sharpshooter'));
	ClassTemplates.RemoveItem(ClassManager.FindSoldierClassTemplate('Grenadier'));
	ClassTemplates.RemoveItem(ClassManager.FindSoldierClassTemplate('Specialist'));
	ClassTemplates.RemoveItem(ClassManager.FindSoldierClassTemplate('PsiOperative'));

	// Clear the modded skill lists
	default.ModRouletteSkills.length = 0;

	// iterate through all the mod added class types
	Foreach ClassTemplates(ClassTemplate) {
		PopulateModSkillsFromClass(ClassTemplate);
	}

	StaticSaveConfig();
}
		
static function PopulateModSkillsFromClass(X2SoldierClassTemplate ClassTemplate) {
	local array<SoldierClassAbilityType>	ClassAbilityTypes;
	local SoldierClassAbilityType			ClassAbilityType;
	local X2AbilityTemplateManager			AbilityManager;
	local X2AbilityTemplate					AbilityTemplate;

	local int i;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	//start from index 1 so we don't pick up mandatory skills like slash
	for ( i = 1; i < ClassTemplate.GetMaxConfiguredRank(); i++ ) {
		ClassAbilityTypes = ClassTemplate.GetAbilityTree(i);
		Foreach ClassAbilityTypes(ClassAbilityType) {
			AbilityTemplate = AbilityManager.FindAbilityTemplate(ClassAbilityType.AbilityName);
			if ( AbilityTemplate.bCrossClassEligible ) {
				if ( default.ModRouletteSkills.find('AbilityName', ClassAbilityType.AbilityName) == INDEX_NONE && class'GrimyGameState_Unit_TrainingRoulette'.default.squaddierouletteskills.find('AbilityName', ClassAbilityType.AbilityName) == INDEX_NONE && class'GrimyGameState_Unit_TrainingRoulette'.default.Rouletteskills.find('AbilityName', ClassAbilityType.AbilityName) == INDEX_NONE ) {
					CompileGrimySkill(ClassTemplate, ClassAbilityType);
				}
			}
		}
	}
}

static function CompileGrimySkill(X2SoldierClassTemplate ClassTemplate, SoldierClassAbilityType AbilityType) {
	local SoldierClassWeaponType	WeaponType;
	local GrimySkill				GrimySkillStruct;

	foreach ClassTemplate.AllowedWeapons(WeaponType) {
		if ( AbilityType.ApplyToWeaponSlot == WeaponType.SlotType || ( AbilityType.ApplyToWeaponSlot != eInvSlot_PrimaryWeapon && AbilityType.ApplyToWeaponSlot != eInvSlot_SecondaryWeapon ) ) {
			GrimySkillStruct.AbilityName = AbilityType.AbilityName;
			GrimySkillStruct.ApplyToWeaponSlot = AbilityType.ApplyToWeaponSlot;
			GrimySkillStruct.UtilityCat = AbilityType.UtilityCat;
			GrimySkillStruct.WeaponCat = WeaponType.WeaponType;
			default.ModRouletteSkills.AddItem(GrimySkillStruct);
		}
	}
}
