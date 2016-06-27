class Grimy_LoadListener extends UIScreenListener;

var UILoadGame LoadScreen;

event OnInit(UIScreen Screen) {
	LoadScreen = UILoadGame(Screen);
	RefreshLoadScreen();
}

event OnRefresh(UIScreen Screen) {
	RefreshLoadScreen();
}

function RefreshLoadScreen() {
	local int i;

	for ( i=0; i<LoadScreen.m_arrListItems.length; i++ ) {
		LoadScreen.m_arrListItems[i].RenameButton.bIsNavigable = true;
		LoadScreen.m_arrListItems[i].RenameButton.InitButton('Button2', LoadScreen.m_arrListItems[i].m_sRenameLabel, OnRename);
		LoadScreen.m_arrListItems[i].RenameButton.Show();
	}
}

simulated public function OnRename(optional UIButton control)
{
	local TInputDialogData kData;
	local UISaveGame SaveScreen; // not initialized, just used to access its localization

	kData.strTitle = SaveScreen.m_sNameSave;
	kData.iMaxChars = 40;
	kData.strInputBoxText = LoadScreen.GetCurrentSelectedFilename();
	kData.fnCallbackAccepted = SetCurrentSelectedFilename;
	
	LoadScreen.Movie.Pres.UIInputDialog(kData);
}

simulated function SetCurrentSelectedFilename(string text)
{	
	text = Repl(text, "\n", "", false);
	LoadScreen.m_arrListItems[LoadScreen.m_iCurrentSelection].UpdateSaveName(text);

	`ONLINEEVENTMGR.SetPlayerDescription(text); // Will be cleared by the saving process
	//Save();		
}

defaultproperties
{
	ScreenClass = class'UILoadGame';
}