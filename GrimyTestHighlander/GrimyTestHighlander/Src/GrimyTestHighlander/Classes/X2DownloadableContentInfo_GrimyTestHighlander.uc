class X2DownloadableContentInfo_GrimyTestHighlander extends X2DownloadableContentInfo;

static event OnLoadedSavedGame() {
	class'Grimy_Utility_TrainingRoulette'.static.PopulateModSkills();
	class'Grimy_Utility_TrainingRoulette'.static.UpdateBarracks();
}

static event InstallNewCampaign(XComGameState StartState) {
	class'Grimy_Utility_TrainingRoulette'.static.PopulateModSkills();
}