class X2DownloadableContentInfo_DisableMoreVO extends X2DownloadableContentInfo config(DisableMoreVO);

var config array<name> FacilityNames, EquipmentNames, TechNames, CharacterNames, ObjectiveNames;
var config bool DisableCinematics, DisableFacilityWalkthroughs;

static event InstallNewCampaign(XComGameState StartState) {
	DisableClassVOs();
}

static function DisableClassVOs() {
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;

	History = `XCOMHISTORY;

	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ.bHasSeenFirstGrenadier = true;
	XComHQ.bHasSeenFirstPsiOperative = true;
	XComHQ.bHasSeenFirstRanger = true;
	XComHQ.bHasSeenFirstSharpshooter = true;
	XComHQ.bHasSeenFirstSpecialist = true;
}

static event OnPostTemplatesCreated()
{
	local name									TemplateName;
	
	local X2CharacterTemplateManager			CharacterManager;
	local X2CharacterTemplate					CharacterTemplate;

	local X2StrategyElementTemplateManager		StrategyManager;
	local X2FacilityTemplate					FacilityTemplate;
	
	local X2ItemTemplateManager					ItemManager;
	local X2EquipmentTemplate					EquipmentTemplate;
	
	local X2TechTemplate						TechTemplate;
	
	local array<X2DataTemplate>					DifficultyTemplates;
	local X2DataTemplate						DifficultyTemplate;

	CharacterManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	ItemManager = class'X2itemTemplateManager'.static.GetItemTemplateManager();

	// Disable Character VOs
	foreach default.CharacterNames(TemplateName) {
		CharacterManager.FindDataTemplateAllDifficulties(TemplateName, DifficultyTemplates);
		foreach DifficultyTemplates(DifficultyTemplate) {
			CharacterTemplate = X2CharacterTemplate(DifficultyTemplate);
			if ( CharacterTemplate != none ) {
				CharacterTemplate.SightedNarrativeMoments.length = 0;
			}
		}
	}

	// Disable Facility VOs
	foreach default.FacilityNames(TemplateName) {
		StrategyManager.FindDataTemplateAllDifficulties(TemplateName, DifficultyTemplates);
		foreach DifficultyTemplates(DifficultyTemplate) {
			FacilityTemplate = X2FacilityTemplate(DifficultyTemplate);
			if ( FacilityTemplate != none ) {
				FacilityTemplate.FacilityCompleteNarrative = "";
				FacilityTemplate.FacilityUpgradedNarrative = "";
				FacilityTemplate.ConstructionStartedNarrative = "";
			}
		}
	}
	
	// Disable Equipment VOs
	foreach default.EquipmentNames(TemplateName) {
		EquipmentTemplate = X2EquipmentTemplate(ItemManager.FindItemTemplate(TemplateName));
		if ( EquipmentTemplate != none ) {
			EquipmentTemplate.EquipNarrative = "";
		}
	}
	
	// Disable Tech VOs
	foreach default.TechNames(TemplateName) {
		TechTemplate = X2TechTemplate(StrategyManager.FindStrategyElementTemplate(TemplateName));
		if ( TechTemplate != none ) {
			TechTemplate.TechStartedNarrative = "";
		}
	}

	if ( default.DisableCinematics ) { DisableCinematicVOs(); }
	if ( default.DisableFacilityWalkthroughs ) { DisableFacilityWalkthroughVOs(); }
}

static function DisableCinematicVOs() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local X2ObjectiveTemplate					Template;
	
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	Template = X2ObjectiveTemplate(StrategyManager.FindStrategyElementTemplate('N_GPCinematics'));
	Template.NarrativeTriggers.length = 0;

	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_Retaliation", NAW_OnAssignment, 'RetaliationMissionSpawned', '', ELD_OnStateSubmitted, NPC_Once, '');
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_BuildOutpost", NAW_OnAssignment, 'RegionBuiltOutpost', '', ELD_OnStateSubmitted, NPC_Once, '');
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_AvengerAttacked", NAW_OnAssignment, 'AvengerAttacked', '', ELD_OnStateSubmitted, NPC_Once, '');
	// Victory cinematic triggered by mission now
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_Victory", NAW_OnAssignment, 'XComVictory', '', ELD_OnStateSubmitted, NPC_Once, '');
	Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_Loss", NAW_OnAssignment, 'XComLoss', '', ELD_OnStateSubmitted, NPC_Once, '', UILose);

	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Arid_Day", NAW_OnAssignment, 'RegionContacted_Arid_Day', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Arid_Night", NAW_OnAssignment, 'RegionContacted_Arid_Night', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Arid_Sunset", NAW_OnAssignment, 'RegionContacted_Arid_Sunset', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Tundra_Day", NAW_OnAssignment, 'RegionContacted_Tundra_Day', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Tundra_Night", NAW_OnAssignment, 'RegionContacted_Tundra_Night', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Tundra_Sunset", NAW_OnAssignment, 'RegionContacted_Tundra_Sunset', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Wild_Day", NAW_OnAssignment, 'RegionContacted_Temperate_Day', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Wild_Night", NAW_OnAssignment, 'RegionContacted_Temperate_Night', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_FirstContact_Wild_Sunset", NAW_OnAssignment, 'RegionContacted_Temperate_Sunset', '', ELD_OnStateSubmitted, NPC_Multiple, '', CinematicComplete);
	
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.WeaponIntro_Magnetic", NAW_OnAssignment, 'OnResearchReport', 'MagnetizedWeapons', ELD_OnStateSubmitted, NPC_Once, '');
	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.WeaponIntro_Beam", NAW_OnAssignment, 'OnResearchReport', 'PlasmaRifle', ELD_OnStateSubmitted, NPC_Once, '');
}

function UILose()
{
	`HQPRES.UIYouLose();
}

static function DisableFacilityWalkthroughVOs() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local name									ObjectiveName;
	local X2ObjectiveTemplate					Template;
	
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	foreach default.ObjectiveNames(ObjectiveName) {
		Template = X2ObjectiveTemplate(StrategyManager.FindStrategyElementTemplate(ObjectiveName));
		if ( Template != none ) {
			Template.NarrativeTriggers.length = 0;
		}
	}
}