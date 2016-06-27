class FOVSlider_MCMListener extends UIScreenListener config(FOVSlider_NullConfig);

`include(FOVSlider/Src/ModConfigMenuAPI/MCM_API_Includes.uci)
`include(FOVSlider/Src/ModConfigMenuAPI/MCM_API_CfgHelpers.uci)

var config bool CFG_CLICKED;

var config float RushCamFOV;
var config float AlienFOV;
var config float HumanFOV;

var MCM_API APIInst;

var MCM_API_Slider Slider1;
var MCM_API_Slider Slider2;
var MCM_API_Slider Slider3;

var MCM_API_SettingsPage Page1;

var config int CONFIG_VERSION;

`MCM_CH_VersionChecker(class'FOVSlider_Defaults'.default.VERSION,CONFIG_VERSION)

event OnInit(UIScreen Screen)
{
    // Since it's listening for all UI classes, check here for the right screen, which will implement MCM_API.
    if (MCM_API(Screen) != none)
    {
        `log("Detected the options screen.");
        // Use the macro because it automates the version check based on the API version you're compiling against.
        `MCM_API_Register(Screen, ClientModCallback);
    }
}

simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode)
{
    local MCM_API_SettingsGroup P1G1;

    // Workaround that's needed in order to be able to "save" files.
    LoadInitialValues();

    if (GameMode == eGameMode_MainMenu || GameMode == eGameMode_Strategy)
    {   
        Page1 = ConfigAPI.NewSettingsPage("FOV Slider");
        Page1.SetPageTitle("FOVSlider");
        Page1.SetSaveHandler(SaveButtonClicked);
        Page1.SetCancelHandler(RevertButtonClicked);
        Page1.EnableResetButton(ResetButtonClicked);
        
        P1G1 = Page1.AddGroup('MCDT1', "FOV Slider");

        Slider1 = P1G1.AddSlider('slider', "Rush Cam FOV", "Rush Cam FOV", 20.0, 180.0, 1.0, RushCamFOV, RushCamSaveLogger);
        Slider2 = P1G1.AddSlider('slider', "Alien Cam FOV", "Alien Cam FOV", 20.0, 180.0, 1.0, AlienFOV, AlienSaveLogger);
        Slider3 = P1G1.AddSlider('slider', "Human Cam FOV", "Human Cam FOV", 20.0, 180.0, 1.0, HumanFOV, HumanSaveLogger);

        Page1.ShowSettings();
    }
}

`MCM_API_BasicSliderSaveHandler(RushCamSaveLogger, RushCamFOV)
`MCM_API_BasicSliderSaveHandler(AlienSaveLogger, AlienFOV)
`MCM_API_BasicSliderSaveHandler(HumanSaveLogger, HumanFOV)

`MCM_API_BasicButtonHandler(ButtonClickedHandler)
{
    // Tests the slider positioning error.
    Slider1.SetBounds(20.0, 180.0, 1.0, Slider1.GetValue(), true);
    Slider2.SetBounds(20.0, 180.0, 1.0, Slider2.GetValue(), true);
    Slider3.SetBounds(20.0, 180.0, 1.0, Slider3.GetValue(), true);

    CFG_CLICKED = true;
}

simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
    `log("MCM: Save button clicked");
    
    self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
    self.SaveConfig();
}

simulated function ResetButtonClicked(MCM_API_SettingsPage Page)
{
    `log("MCM: Reset button clicked");

    // Revert all of the settings.
    CFG_CLICKED = false;
    Slider1.SetValue(RushCamFOV, true);
    Slider2.SetValue(AlienFOV, true);
    Slider3.SetValue(HumanFOV, true);
}

simulated function RevertButtonClicked(MCM_API_SettingsPage Page)
{
    // Don't need to do anything since values aren't written until at save-time when you use save handlers.
    `log("MCM: Cancel button clicked");
}

// This shows how to either pull default values from a source config, or to use more user-defined values, gated by a version number mechanism.
simulated function LoadInitialValues()
{
    CFG_CLICKED = false;  
    RushCamFOV = `MCM_CH_GetValue(class'FOVSlider_Defaults'.default.RushCamFOV,RushCamFOV);
    AlienFOV = `MCM_CH_GetValue(class'FOVSlider_Defaults'.default.AlienFOV,AlienFOV);
    HumanFOV = `MCM_CH_GetValue(class'FOVSlider_Defaults'.default.HumanFOV,HumanFOV);
}

defaultproperties
{
    ScreenClass = class'MCM_OptionsScreen'
}
