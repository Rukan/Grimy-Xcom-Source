class GrimyFNG_AcademyUnlocks extends X2StrategyElement config(GrimyFNG);

struct FNGUnlockData
{
	var name TemplateName;
	var string DisplayName;
	var int SupplyCost;
	var int RankRequirement;
	var int DeadKills;
};

var config array<FNGUnlockData> FNGAcademyData;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;
	local FNGUnlockData FNGData;
	local int Index;

	Index = 0;
	foreach default.FNGAcademyData(FNGData) {
		Templates.AddItem(GrimyFNGUnlock(FNGData, Index));
		Index++;
	}

	return Templates;
}

static function X2SoldierUnlockTemplate GrimyFNGUnlock(FNGUnlockData FNGData, int Index) {
	local X2SoldierUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierUnlockTemplate', Template, FNGData.TemplateName);

	Template.bAllClasses = true;
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_FNG";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = FNGData.RankRequirement;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	switch ( Index ) {
		case 0:
			Template.Requirements.SpecialRequirementsFn = DeathReq1;
			break;
		case 1:
			Template.Requirements.SpecialRequirementsFn = DeathReq2;
			break;
		case 2:
			Template.Requirements.SpecialRequirementsFn = DeathReq3;
			break;
		case 3:
			Template.Requirements.SpecialRequirementsFn = DeathReq4;
			break;
		case 4:
			Template.Requirements.SpecialRequirementsFn = DeathReq5;
			break;
		case 5:
			Template.Requirements.SpecialRequirementsFn = DeathReq6;
			break;
	}

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = FNGData.SupplyCost;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

function bool DeathReq1() { return DeathReq(0); }
function bool DeathReq2() { return DeathReq(1); }
function bool DeathReq3() { return DeathReq(2); }
function bool DeathReq4() { return DeathReq(3); }
function bool DeathReq5() { return DeathReq(4); }
function bool DeathReq6() { return DeathReq(5); }

function bool DeathReq(int Rank) {
	return GetDeadXP() >= default.FNGAcademyData[Rank].DeadKills;
}

function int GetDeadXP() {
	local XComGameState_HeadquartersXCom XComHQ;
	local StateObjectReference	DeadSoldier;
	local XComGameState_Unit	UnitState;
	local XComGameStateHistory	History;
	local int XPCounter;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	if ( XComHQ == none ) { return -1; }

	XPCounter = 0;
	foreach XComHQ.DeadCrew(DeadSoldier) {
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(DeadSoldier.ObjectID));
		if ( UnitState != none ) {
			XPCounter += UnitState.GetNumKills();
		}
	}

	return XPCounter;
}

static function int GetFNGRank() {
	local FNGUnlockData FNGData;
	local XComGameState_HeadquartersXCom XComHQ;
	local int Rank;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	Rank = 0;

	foreach default.FNGAcademyData(FNGData) {
		if ( XComHQ.HasSoldierUnlockTemplate(FNGData.TemplateName) ) {
			Rank++;
		}
	}

	return Rank;
}

static function UpdateOTS() {
	local X2StrategyElementTemplateManager		StrategyManager;
	local FNGUnlockData FNGData;
	
	local array<X2DataTemplate>					DifficultyTemplates;
	local X2DataTemplate						DifficultyTemplate;

	// Add Strategy Unlocks
	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	StrategyManager.FindDataTemplateAllDifficulties('OfficerTrainingSchool',DifficultyTemplates);	

	foreach DifficultyTemplates(DifficultyTemplate) {
		foreach default.FNGAcademyData(FNGData) {
			X2FacilityTemplate(DifficultyTemplate).SoldierUnlockTemplates.AddItem(FNGData.TemplateName);
		}
	}
}