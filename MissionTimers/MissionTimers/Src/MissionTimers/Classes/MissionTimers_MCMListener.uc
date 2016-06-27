class MissionTimers_MCMListener extends UIScreenListener config(MissionTimers_NullConfig);

`include(MissionTimers/Src/ModConfigMenuAPI/MCM_API_Includes.uci)
`include(MissionTimers/Src/ModConfigMenuAPI/MCM_API_CfgHelpers.uci)

var config bool CFG_CLICKED;
var config int CONFIG_VERSION;

//================================
//========Slider Parameters=======
//================================
var config int TURN_TIME;
var MCM_API_Slider Slider;

var localized string MOD_NAME, OPTION_HEADER, OPTION_TITLE, OPTION_DESCRIPTION;

`MCM_CH_VersionChecker(class'MissionTimers_UIScreen'.default.Version,CONFIG_VERSION)

event OnInit(UIScreen Screen)
{
	`MCM_API_Register(Screen, ClientModCallback);
}

simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode)
{
	local MCM_API_SettingsPage Page;
    local MCM_API_SettingsGroup Group;

    // Workaround that's needed in order to be able to "save" files.
    LoadInitialValues();

    Page = ConfigAPI.NewSettingsPage(MOD_NAME);
    Page.SetPageTitle(MOD_NAME);
    Page.SetSaveHandler(SaveButtonClicked);
    Page.SetCancelHandler(RevertButtonClicked);
    Page.EnableResetButton(ResetButtonClicked);
        
    Group = Page.AddGroup('MCDT1', OPTION_HEADER);

    Slider = Group.AddSlider('slider', OPTION_TITLE, OPTION_DESCRIPTION, 5.0, 500.0, 1.0, TURN_TIME, TurnTimeSaveLogger);

    Page.ShowSettings();
}

`MCM_API_BasicSliderSaveHandler(TurnTimeSaveLogger, TURN_TIME)

`MCM_API_BasicButtonHandler(ButtonClickedHandler)
{
    // Tests the slider positioning error.
    Slider.SetBounds(5.0, 500.0, 1.0, Slider.GetValue(), true);

    CFG_CLICKED = true;
}

simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
    self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
    self.SaveConfig();
}

simulated function ResetButtonClicked(MCM_API_SettingsPage Page)
{
	CFG_CLICKED = false;
	TURN_TIME = class'MissionTimers_UIScreen'.default.TURN_TIME;
	Slider.SetValue(TURN_TIME, true);
}

simulated function RevertButtonClicked(MCM_API_SettingsPage Page)
{
    // Don't need to do anything since values aren't written until at save-time when you use save handlers.
}

// This shows how to either pull default values from a source config, or to use more user-defined values, gated by a version number mechanism.
simulated function LoadInitialValues()
{
	CFG_CLICKED = false; 
	if ( TURN_TIME > 0 ) {
		TURN_TIME = `MCM_CH_GetValue(class'MissionTimers_UIScreen'.default.TURN_TIME,TURN_TIME);
	}
	else {
		TURN_TIME = class'MissionTimers_UIScreen'.default.TURN_TIME;
	}
}

defaultproperties
{
    ScreenClass = class'MCM_OptionsScreen'
}