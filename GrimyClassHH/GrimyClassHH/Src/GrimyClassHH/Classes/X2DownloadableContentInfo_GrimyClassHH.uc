class X2DownloadableContentInfo_GrimyClassHH extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	UpdateFacilities();
	UpdateAbilities();
	UpdateItems();
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
		X2FacilityTemplate(DifficultyTemplate).SoldierUnlockTemplates.AddItem('GrimyHexHunterUnlock');
	}
}

static function UpdateSoldierNicknames() {
	local X2SoldierClassTemplateManager	SoldierManager;
	local X2SoldierClassTemplate		HeadHunterClass, SharpshooterClass;

	SoldierManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	SharpshooterClass = SoldierManager.FindSoldierClassTemplate('Sharpshooter');
	HeadHunterClass = Soldiermanager.FindSoldierClassTemplate('HeadHunter');
	HeadHunterClass.RandomNicknames = SharpshooterClass.RandomNicknames;
	HeadHunterClass.RandomNicknames_Male = SharpshooterClass.RandomNicknames_Male;
	HeadHunterClass.RandomNicknames_Female = SharpshooterClass.RandomNicknames_Female;
}

static function UpdateAbilities() {
	local X2AbilityTemplateManager		AbilityManager;
	local X2AbilityTemplate				AbilityTemplate;
	local X2AbilityMultiTarget_Radius	RadiusMultiTarget;
	local X2AbilityTarget_Cursor        CursorTarget;
	local X2AbilityCost_ActionPoints    ActionPointCost;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityManager.FindAbilityTemplate('Grapple');
	AbilityTemplate.TargetingMethod = class'GrimyClassHH_TargetingMethod_RocketLauncher';

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = 1.0;
	AbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.FixedAbilityRange = 15;
	AbilityTemplate.AbilityTargetStyle = CursorTarget;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	AbilityTemplate.AbilityCosts[0] = ActionPointCost;

	AbilityTemplate.AbilityCooldown = none;

	AbilityTemplate.AbilityShooterConditions.Remove(1,1);
}

static function UpdateItems() {
	local X2ItemTemplateManager			ItemManager;
	local array<X2DataTemplate>			DifficultyTemplates;
	local X2DataTemplate				DifficultyTemplate;
	local X2ArmorTemplate				ArmorTemplate;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemManager.FindDataTemplateAllDifficulties('LightAlienArmor',DifficultyTemplates);
	foreach DifficultyTemplates(DifficultyTemplate) {
		ArmorTemplate = X2ArmorTemplate(DifficultyTemplate);
		if ( ArmorTemplate != none ) {
			ArmorTemplate.Abilities.RemoveItem('Grapple');
			ArmorTemplate.Abilities.AddItem('GrapplePowered');
		}
	}
	ItemManager.FindDataTemplateAllDifficulties('LightPlatedArmor',DifficultyTemplates);
	foreach DifficultyTemplates(DifficultyTemplate) {
		ArmorTemplate = X2ArmorTemplate(DifficultyTemplate);
		if ( ArmorTemplate != none ) {
			ArmorTemplate.Abilities.RemoveItem('Grapple');
			ArmorTemplate.Abilities.AddItem('GrapplePowered');
		}
	}
}