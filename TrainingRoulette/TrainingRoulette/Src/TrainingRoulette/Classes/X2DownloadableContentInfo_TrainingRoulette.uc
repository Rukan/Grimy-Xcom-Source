class X2DownloadableContentInfo_TrainingRoulette extends X2DownloadableContentInfo;

static event OnLoadedSavedGame() {
	class'Grimy_Utility_TrainingRoulette'.static.PopulateModSkills();
}

static event InstallNewCampaign(XComGameState StartState) {
	class'Grimy_Utility_TrainingRoulette'.static.PopulateModSkills();
}

static event OnPostMission()
{
	class'Grimy_Utility_TrainingRoulette'.static.UpdateBarracks();
}