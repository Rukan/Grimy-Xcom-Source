class GrimyGameState_Unit_TrainingRoulette extends XComGameState_BaseObject config(GrimyTrainingRoulette);

var config array<name> PrimaryWeaponNames, SecondaryWeaponNames;
var config array<int> HighOffense, MedOffense, LowOffense, HighHP, MedHP, HighHacking, MedHacking, HighPsiOffense;
var config int TreeHeight, TreeWidth;

var config array<GrimySkill> RouletteSkills, SquaddieRouletteSkills;

var array<SoldierClassRank>			SoldierRanks;
var name							OriginalTemplateName;

// This function generates a new set of SoldierRanks and AllowedWeapons
function RandomizeWeaponsAndPerks(X2SoldierClassTemplate OldClassTemplate) {
	local SoldierClassRank					ClassRank;
	local array<SoldierClassAbilityType>	AbilityList, ForceSkills;
	local name								PrimaryWeapon, SecondaryWeapon;
	local int i, j, k;
	
	OriginalTemplateName = OldClassTemplate.DataName;

	PrimaryWeapon = GetWeapon(OldClassTemplate.default.AllowedWeapons, eInvSlot_PrimaryWeapon);
	SecondaryWeapon = GetWeapon(OldClassTemplate.default.AllowedWeapons, eInvSlot_SecondaryWeapon);

	// Generate the list of abilities
	ForceSkills = GetForceAbilities(OldClassTemplate);
	AbilityList = ShuffleList(GetNewAbilities(PrimaryWeapon, SecondaryWeapon));

	//clear previous entries before adding a new set of items
	ClassRank.aStatProgression.length = 0;
	ClassRank.aAbilityTree.length = 0;

	ClassRank.aStatProgression.addItem(GetCombatSimStat());
	ClassRank.aStatProgression.addItem(GetOffenseStat(PrimaryWeapon, SecondaryWeapon, 0));
	ClassRank.aStatProgression.addItem(GetHPStat(PrimaryWeapon, SecondaryWeapon, 0));
	ClassRank.aStatProgression.addItem(GetHackingStat(SecondaryWeapon, 0));
	ClassRank.aStatProgression.addItem(GetPsiStat(SecondaryWeapon, 0));
	for ( i = 0; i < ForceSkills.length; i++ ) {
		ClassRank.aAbilityTree.addItem(ForceSkills[i]);
	}
	// provide a free skill when appropriate
	if ( SecondaryWeapon == 'pistol' || ClassRank.aAbilityTree.length == 0 ) {
		ClassRank.aAbilityTree.addItem(AbilityList[0]);
	}
	SoldierRanks.additem(ClassRank);

	k = 1;
	for ( i = 1; i < default.TreeHeight; i++ ) {
		//clear previous entries before adding a new set of items
		ClassRank.aStatProgression.length = 0;
		ClassRank.aAbilityTree.length = 0;
		ClassRank.aStatProgression.addItem(GetOffenseStat(PrimaryWeapon, SecondaryWeapon, i));
		ClassRank.aStatProgression.addItem(GetHPStat(PrimaryWeapon, SecondaryWeapon, i));
		ClassRank.aStatProgression.addItem(GetHackingStat(SecondaryWeapon, i));
		ClassRank.aStatProgression.addItem(GetPsiStat(SecondaryWeapon, i));
		for ( j = 0; j < default.TreeWidth; j++ ) {
			ClassRank.aAbilityTree.addItem(AbilityList[k++]);
		}
		//ClassRank.aAbilityTree.addItem();
		SoldierRanks.additem(ClassRank);
		
	}
}

function name GetWeapon(array<SoldierClassWeaponType> WeaponTypes, EInventorySlot SlotType) {
	local SoldierClassWeaponType WeaponType;
	local name WeaponName;

	WeaponName = '';
	foreach WeaponTypes(WeaponType) {
		if ( WeaponType.SlotType == SlotType ) {
			if ( WeaponType.WeaponType == 'rifle' ) {
				WeaponName = 'rifle';
			}
			else {
				return WeaponType.WeaponType;
			}
		}
	}
	return WeaponName;
}

// This function creates a new class template based on this component, then adds it to the manager
function name AddToManager() {
	local X2SoldierClassTemplateManager ClassManager;
	local X2SoldierClassTemplate ClassTemplate, OriginalTemplate;

	ClassManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	OriginalTemplate = ClassManager.FindSoldierClassTemplate(OriginalTemplateName);
	UpdateGTS();

	`CREATE_X2TEMPLATE(class'X2SoldierClassTemplate', ClassTemplate, GenerateTemplateName());
	class'Grimy_SoldierClassTemplateExtension'.static.SetSoldierRanks(ClassTemplate, SoldierRanks);
	ClassTemplate.AllowedWeapons = OriginalTemplate.default.AllowedWeapons;
	ClassTemplate.AllowedArmors = OriginalTemplate.default.AllowedArmors;
	ClassTemplate.ExcludedAbilities = OriginalTemplate.default.ExcludedAbilities;
	ClassTemplate.SquaddieLoadout = OriginalTemplate.default.SquaddieLoadout;
	ClassTemplate.IconImage = OriginalTemplate.default.IconImage;
	ClassTemplate.NumInForcedDeck = 0;
	ClassTemplate.NumInDeck = 0;
	ClassTemplate.ClassPoints = OriginalTemplate.default.ClassPoints;    // Number of "points" associated with using this class type, i.e. Multiplayer or Daily Challenge
	ClassTemplate.KillAssistsPerKill = OriginalTemplate.default.KillAssistsPerKill;     //  Number of kill assists that count as a kill for ranking up
	ClassTemplate.PsiCreditsPerKill = OriginalTemplate.default.PsiCreditsPerKill;      //  Number of psi credits that count as a kill for ranking up
	ClassTemplate.bAllowAWCAbilities = OriginalTemplate.default.bAllowAWCAbilities;
	ClassTemplate.bUniqueTacticalToStrategyTransfer = OriginalTemplate.default.bUniqueTacticalToStrategyTransfer;
	ClassTemplate.bIgnoreInjuries = OriginalTemplate.default.bIgnoreInjuries;
	ClassTemplate.bBlockRankingUp = OriginalTemplate.default.bBlockRankingUp;
	ClassTemplate.CannotEditSlots = OriginalTemplate.default.CannotEditSlots;
//	ClassTemplate.bMultiplayerOnly = bMultiplayerOnly; don't edit this, it's write only
//	ClassTemplate.bHideInCharacterPool = OriginalTemplate.default.bHideInCharacterPool;

	ClassTemplate.DisplayName = OriginalTemplate.DisplayName;
	ClassTemplate.ClassSummary = OriginalTemplate.ClassSummary;
	ClassTemplate.LeftAbilityTreeTitle = OriginalTemplate.LeftAbilityTreeTitle;
	ClassTemplate.RightAbilityTreeTitle = OriginalTemplate.RightAbilityTreeTitle;
	ClassTemplate.RankNames = OriginalTemplate.RankNames;
	ClassTemplate.ShortNames = OriginalTemplate.ShortNames;
	ClassTemplate.RankIcons = OriginalTemplate.RankIcons;
	ClassTemplate.RandomNickNames = OriginalTemplate.RandomNickNames;        //  Selected randomly when the soldier hits a certain rank, if the player has not set one already.
	ClassTemplate.RandomNickNames_Female = OriginalTemplate.RandomNickNames_Female; //  Female only nicknames.
	ClassTemplate.RandomNickNames_Male = OriginalTemplate.RandomNickNames_Male;   //  Male only nicknames.

	ClassManager.AddSoldierClassTemplate(ClassTemplate,true);
	return ClassTemplate.DataName;
}

function UpdateGTS() {
	local array<X2StrategyElementTemplate> StrategyUnlocks;
	local X2StrategyElementTemplate StrategyUnlock;
	local X2SoldierAbilityUnlockTemplate AcademyUnlock;
	local name MyName;

	StrategyUnlocks = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().GetAllTemplatesOfClass(class'X2SoldierAbilityUnlockTemplate');
	MyName = GenerateTemplateName();
	foreach StrategyUnlocks(StrategyUnlock) {
		AcademyUnlock = X2SoldierAbilityUnlockTemplate(StrategyUnlock);
		if ( AcademyUnlock.AllowedClasses.find(OriginalTemplateName) != INDEX_NONE && AcademyUnlock.AllowedClasses.find(MyName) == INDEX_NONE ) {
			AcademyUnlock.AllowedClasses.AddItem(MyName);
		}
	}
}

// UTILITY FUNCTIONS

function array<SoldierClassAbilityType> ShuffleList(array<SoldierClassAbilityType> InputList) {
	local array<SoldierClassAbilityType>	OutputList;
	local int randIndex;

	OutputList.length = 0;
	while ( InputList.length > 0 ) {
		randIndex = `SYNC_RAND(InputList.length);
		OutputList.AddItem(InputList[randIndex]);
		InputList.Remove(randIndex,1);
	}

	//`REDSCREEN("SHUFFLE LIST STARTS HERE");
	for ( randIndex=0; randIndex<OutputList.length; randIndex++ ) {
		//`REDSCREEN("SHUFFLE LIST OUTPUT - " $ OutputList[randIndex].AbilityName);
	}

	return OutputList;
}

function name GetSquaddieLoadoutName(name WeaponType, name SecondaryType) {
	return name("Roulette_" $ WeaponType $ "_" $ SecondaryType);
}

function name GenerateTemplateName() {
	return name("GrimyRoulette" $ ObjectID);
}

function array<SoldierClassAbilityType> GetNewAbilities(name WeaponType, name SecondaryType) {
	local array<SoldierClassAbilityType>	AbilityList;
	local SoldierClassAbilityType			AbilityType;
	local GrimySkill						GrimySkillStruct;

	AbilityList.length = 0;

	//`REDSCREEN("Grimy Log - Start of Abilities");
	foreach default.RouletteSkills(GrimySkillStruct) {
		//`REDSCREEN("Grimy Basic Skill Log - " $ string(GrimySkillStruct.AbilityName));
		if ( GrimySkillStruct.WeaponCat == WeaponType || GrimySkillStruct.WeaponCat == SecondaryType || GrimySkillStruct.WeaponCat == '' ) {
			AbilityType.AbilityName = GrimySkillStruct.AbilityName;
			AbilityType.ApplyToWeaponSlot = GrimySkillStruct.ApplyToWeaponSlot;
			AbilityType.UtilityCat = GrimySkillStruct.UtilityCat;
			AbilityList.additem(AbilityType);
		}
	}

	foreach class'Grimy_Utility_TrainingRoulette'.default.ModRouletteSkills(GrimySkillStruct) {
		//`REDSCREEN("Grimy ModRoulette Skill Log - " $ string(GrimySkillStruct.AbilityName));
		if ( GrimySkillStruct.WeaponCat == WeaponType || GrimySkillStruct.WeaponCat == SecondaryType || GrimySkillStruct.WeaponCat == '' ) {
			AbilityType.AbilityName = GrimySkillStruct.AbilityName;
			AbilityType.ApplyToWeaponSlot = GrimySkillStruct.ApplyToWeaponSlot;
			AbilityType.UtilityCat = GrimySkillStruct.UtilityCat;
			AbilityList.additem(AbilityType);
		}
	}

	return AbilityList;
}

function array<SoldierClassAbilityType> GetForceAbilities(X2SoldierClassTemplate OriginalTemplate) {
	return OriginalTemplate.GetAbilityTree(0);
}

function SoldierClassStatType GetCombatSimStat() {
	local SoldierClassStatType		ClassStatType;

	classStatType.StatType = eStat_CombatSims;
	classStatType.StatAmount = 1;

	return ClassStatType;
}

function SoldierClassStatType GetOffenseStat(name WeaponName, name SecondaryName, int rank) {
	local SoldierClassStatType		ClassStatType;
	classStatType.StatType = eStat_Offense;

	if ( WeaponName == 'sniper_rifle' ) { classStatType.StatAmount = HighOffense[rank]; }
	else if ( WeaponName == 'cannon' || SecondaryName == 'psiamp' ) { classStatType.StatAmount = LowOffense[rank]; }
	else { classStatType.StatAmount = MedOffense[rank]; } 

	return classStatType;
}

function SoldierClassStatType GetHPStat(name WeaponName, name SecondaryName, int rank) {
	local SoldierClassStatType		ClassStatType;
	classStatType.StatType = eStat_HP;

	if ( WeaponName == 'sniper_rifle' || SecondaryName == 'psiamp' ) { classStatType.StatAmount = MedHP[rank]; }
	else { classStatType.StatAmount = HighHP[rank]; } 

	return classStatType;
}

function SoldierClassStatType GetHackingStat(name SecondaryName, int rank) {
	local SoldierClassStatType		ClassStatType;
	classStatType.StatType = eStat_Hacking;

	if ( SecondaryName == 'gremlin' ) { classStatType.StatAmount = HighHacking[rank]; }
	else { classStatType.StatAmount = MedHacking[rank]; } 

	return classStatType;
}

function SoldierClassStatType GetPsiStat(name SecondaryName, int rank) {
	local SoldierClassStatType		ClassStatType;
	classStatType.StatType = eStat_PsiOffense;

	if ( SecondaryName == 'psiamp' ) { classStatType.StatAmount = HighPsiOffense[rank]; }
	else { classStatType.StatAmount = 0; } 

	return classStatType;
}