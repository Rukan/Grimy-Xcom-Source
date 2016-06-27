class Grimy_SaveListener extends UIScreenListener;

var UISaveGame SaveScreen;

event OnInit(UIScreen Screen) {
	SaveScreen = UISaveGame(Screen);
	RefreshSaveScreen();
}

event OnRefresh(UIScreen Screen) {
	RefreshSaveScreen();
}

function RefreshSaveScreen() {
	local int i;

	for ( i=0; i<SaveScreen.m_arrListItems.length; i++ ) {
		SaveScreen.m_arrListItems[i].RenameButton.bIsNavigable = true;
		SaveScreen.m_arrListItems[i].RenameButton.InitButton('Button2', SaveScreen.m_arrListItems[i].m_sRenameLabel, OnRename);
		SaveScreen.m_arrListItems[i].RenameButton.Show();
	}
}

simulated public function OnRename(optional UIButton control)
{
	local TInputDialogData kData;

	kData.strTitle = SaveScreen.m_sNameSave;
	kData.iMaxChars = 40;
	kData.strInputBoxText = SaveScreen.GetCurrentSelectedFilename();
	kData.fnCallbackAccepted = SetCurrentSelectedFilename;
	
	SaveScreen.Movie.Pres.UIInputDialog(kData);
}


simulated function SetCurrentSelectedFilename(string text)
{	
	text = Repl(text, "\n", "", false);
	SaveScreen.m_arrListItems[SaveScreen.m_iCurrentSelection].UpdateSaveName(text);

	`ONLINEEVENTMGR.SetPlayerDescription(text); // Will be cleared by the saving process
	Save();		
}

simulated function Save()
{
	`ONLINEEVENTMGR.Save(GetSaveID(m_iCurrentSelection), false, false, SaveGameComplete);
}

defaultproperties
{
	ScreenClass = class'UISaveGame';
}