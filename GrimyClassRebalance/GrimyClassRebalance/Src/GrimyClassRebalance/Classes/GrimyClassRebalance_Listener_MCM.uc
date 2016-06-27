class GrimyClassRebalance_Listener_MCM extends UIScreenListener config(GrimyClassRebalance_NullConfig);

`include(MissionTimers/Src/ModConfigMenuAPI/MCM_API_Includes.uci)
`include(MissionTimers/Src/ModConfigMenuAPI/MCM_API_CfgHelpers.uci)

var config bool CFG_CLICKED, SETTINGS_CHANGED;
var config int CONFIG_VERSION;

//================================
//========Slider Parameters=======
//================================
var config int SNEAK_COOLDOWN;
var config int GUNSMACK_DAMAGE, GUNSMACK_SPREAD, GUNSMACK_CHANCE;
var config int FLUSH_AIM;
var config float FLUSH_DAMAGE;
var config bool bAddGunSmack, bAddSuppression, bAddFlush, bAddSneak, bSniperOverwatchAfterMoving, bDisableVolatileMixDOT;
var config bool bDisableTileSnap;
var config int MAX_PSI_ABILITIES;
var config int TRIAGE_SHIELD_BONUS;

var localized string MOD_NAME, WARNING_HEADER;

var MCM_API_Slider SNEAK_SLIDER;
var localized string SNEAK_HEADER, SNEAK_TITLE, SNEAK_DESCRIPTION;
var MCM_API_Checkbox SNEAK_CHECKBOX;
var localized string SNEAK_TITLE0, SNEAK_DESCRIPTION0;

var MCM_API_Slider GUNSMACK_SLIDER1, GUNSMACK_SLIDER2, GUNSMACK_SLIDER3;
var localized string GUNSMACK_HEADER;
var localized string GUNSMACK_TITLE1, GUNSMACK_TITLE2, GUNSMACK_TITLE3;
var localized string GUNSMACK_DESCRIPTION1, GUNSMACK_DESCRIPTION2, GUNSMACK_DESCRIPTION3;
var MCM_API_Checkbox GUNSMACK_CHECKBOX;
var localized string GUNSMACK_TITLE0, GUNSMACK_DESCRIPTION0;

var MCM_API_Slider FLUSH_SLIDER1, FLUSH_SLIDER2;
var localized string FLUSH_HEADER;
var localized string FLUSH_TITLE1, FLUSH_TITLE2;
var localized string FLUSH_DESCRIPTION1, FLUSH_DESCRIPTION2;
var MCM_API_Checkbox FLUSH_CHECKBOX;
var localized string FLUSH_TITLE0, FLUSH_DESCRIPTION0;

var MCM_API_SLIDER PSI_ABILITY_SLIDER;
var localized string PSI_ABILITY_HEADER, PSI_ABILITY_TITLE, PSI_ABILITY_DESCRIPTION;

var MCM_API_SLIDER TRIAGE_SLIDER;
var localized string TRIAGE_HEADER, TRIAGE_TITLE, TRIAGE_DESCRIPTION;

var MCM_API_CHECKBOX SUPPRESSION_CHECKBOX, SNIPEROVERWATCH_CHECKBOX, VOLATILEMIXDOT_CHECKBOX, TILESNAP_CHECKBOX;
var localized string MISC_HEADER;
var localized string SUPPRESSION_TITLE, SUPPRESSION_DESCRIPTION;
var localized string SNIPEROVERWATCH_TITLE, SNIPEROVERWATCH_DESCRIPTION;
var localized string VOLATILEMIXDOT_TITLE, VOLATILEMIXDOT_DESCRIPTION;
var localized string TILESNAP_TITLE, TILESNAP_DESCRIPTION;

`MCM_CH_VersionChecker(class'GrimyClassRebalance_AbilitySet'.default.Version,CONFIG_VERSION)

event OnInit(UIScreen Screen)
{
	`MCM_API_Register(Screen, ClientModCallback);
}

simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode)
{
	local MCM_API_SettingsPage Page;
	local MCM_API_SettingsGroup SNEAK_GROUP, GUNSMACK_GROUP, FLUSH_GROUP, PSI_ABILITY_GROUP, TRIAGE_GROUP, MISC_GROUP;

	// Workaround that's needed in order to be able to "save" files.
	LoadInitialValues();

	Page = ConfigAPI.NewSettingsPage(MOD_NAME);
	Page.SetPageTitle(MOD_NAME);
	Page.SetSaveHandler(SaveButtonClicked);
	Page.SetCancelHandler(RevertButtonClicked);
	Page.EnableResetButton(ResetButtonClicked);

	Page.AddGroup('MCDT1', WARNING_HEADER);
	SNEAK_GROUP = Page.AddGroup('MCDT1', SNEAK_HEADER);
	GUNSMACK_GROUP = Page.AddGroup('MCDT1', GUNSMACK_HEADER);
	FLUSH_GROUP = Page.AddGroup('MCDT1', FLUSH_HEADER);
	PSI_ABILITY_GROUP = Page.AddGroup('MCDT1', PSI_ABILITY_HEADER);
	MISC_GROUP = Page.AddGroup('MCDT1', MISC_HEADER);
	TRIAGE_GROUP = Page.AddGroup('MCDT1', TRIAGE_HEADER);

	SNEAK_CHECKBOX = SNEAK_GROUP.AddCheckbox('checkbox', SNEAK_TITLE0, SNEAK_DESCRIPTION0, bAddSneak, SneakCheckSaveLogger);
	SNEAK_SLIDER = SNEAK_GROUP.AddSlider('slider', SNEAK_TITLE, SNEAK_DESCRIPTION, 0.0, 9.0, 10.0, SNEAK_COOLDOWN, SneakCooldownSaveLogger);
	
	GUNSMACK_CHECKBOX = GUNSMACK_GROUP.AddCheckbox('checkbox', GUNSMACK_TITLE0, GUNSMACK_DESCRIPTION0, bAddGunSmack, GunsmackCheckSaveLogger);
	GUNSMACK_SLIDER1 = GUNSMACK_GROUP.AddSlider('slider', GUNSMACK_TITLE1, GUNSMACK_DESCRIPTION1, 0.0, 9.0, 10.0, GUNSMACK_DAMAGE, GunsmackDamageSaveLogger);
	GUNSMACK_SLIDER2 = GUNSMACK_GROUP.AddSlider('slider', GUNSMACK_TITLE2, GUNSMACK_DESCRIPTION2, 0.0, 9.0, 10.0, GUNSMACK_SPREAD, GunsmackSpreadSaveLogger);
	GUNSMACK_SLIDER3 = GUNSMACK_GROUP.AddSlider('slider', GUNSMACK_TITLE3, GUNSMACK_DESCRIPTION3, 0.0, 100.0, 100.0 / 101.0, GUNSMACK_CHANCE, GunsmackStunSaveLogger);

	FLUSH_CHECKBOX = FLUSH_GROUP.AddCheckbox('checkbox', FLUSH_TITLE0, FLUSH_DESCRIPTION0, bAddFlush, FlushCheckSaveLogger);
	FLUSH_SLIDER1 = FLUSH_GROUP.AddSlider('slider', FLUSH_TITLE1, FLUSH_DESCRIPTION1, 0.0, 99.0, 1.0, FLUSH_AIM, FlushAimSaveLogger);
	FLUSH_SLIDER2 = FLUSH_GROUP.AddSlider('slider', FLUSH_TITLE2, FLUSH_DESCRIPTION2, -0.99, 0.0, 1.0, FLUSH_DAMAGE, FlushDamageSaveLogger);
	
	PSI_ABILITY_SLIDER = PSI_ABILITY_GROUP.AddSlider('slider', PSI_ABILITY_TITLE, PSI_ABILITY_DESCRIPTION, 0.0, 14.0, 100.0 / 15.0, MAX_PSI_ABILITIES, PsiAbilitySaveLogger);

	TRIAGE_SLIDER = TRIAGE_GROUP.AddSlider('slider', TRIAGE_TITLE, TRIAGE_DESCRIPTION, 0.0, 99.0, 1.0, TRIAGE_SHIELD_BONUS, TriageShieldSaveLogger);

	TILESNAP_CHECKBOX = MISC_GROUP.ADdCheckbox('checkbox', TILESNAP_TITLE, TILESNAP_DESCRIPTION, bDisableTileSnap, TileSnapSaveLogger);
	SUPPRESSION_CHECKBOX = MISC_GROUP.AddCheckbox('checkbox', SUPPRESSION_TITLE, SUPPRESSION_DESCRIPTION, bAddSuppression, SuppressionCheckSaveLogger);
	SNIPEROVERWATCH_CHECKBOX = MISC_GROUP.AddCheckbox('checkbox', SNIPEROVERWATCH_TITLE, SNIPEROVERWATCH_DESCRIPTION, bSniperOverwatchAfterMoving, SniperOverwatchCheckSaveLogger);
	VOLATILEMIXDOT_CHECKBOX = MISC_GROUP.AddCheckbox('checkbox', VOLATILEMIXDOT_TITLE, VOLATILEMIXDOT_DESCRIPTION, bDisableVolatileMixDOT, VolatileMixDotCheckSaveLogger);

	Page.ShowSettings();
}

`MCM_API_BasicCheckboxSaveHandler(TileSnapSaveLogger, bDisableTileSnap);
`MCM_API_BasicCheckboxSaveHandler(GunsmackCheckSaveLogger, bAddGunSmack);
`MCM_API_BasicCheckboxSaveHandler(SuppressionCheckSaveLogger, bAddSuppression);
`MCM_API_BasicCheckboxSaveHandler(FlushCheckSaveLogger, bAddFlush);
`MCM_API_BasicCheckboxSaveHandler(SneakCheckSaveLogger, bAddSneak);
`MCM_API_BasicCheckboxSaveHandler(SniperOverwatchCheckSaveLogger, bSniperOverwatchAfterMoving);
`MCM_API_BasicCheckboxSaveHandler(VolatileMixDotCheckSaveLogger, bDisableVolatileMixDOT);
`MCM_API_BasicSliderSaveHandler(SneakCooldownSaveLogger, SNEAK_COOLDOWN)
`MCM_API_BasicSliderSaveHandler(GunsmackDamageSaveLogger, GUNSMACK_DAMAGE)
`MCM_API_BasicSliderSaveHandler(GunsmackSpreadSaveLogger, GUNSMACK_SPREAD)
`MCM_API_BasicSliderSaveHandler(GunsmackStunSaveLogger, GUNSMACK_CHANCE)
`MCM_API_BasicSliderSaveHandler(FlushAimSaveLogger, FLUSH_AIM)
`MCM_API_BasicSliderSaveHandler(FlushDamageSaveLogger, FLUSH_DAMAGE)
`MCM_API_BasicSliderSaveHandler(PsiAbilitySaveLogger, MAX_PSI_ABILITIES)
`MCM_API_BasicSliderSaveHandler(TriageShieldSaveLogger, TRIAGE_SHIELD_BONUS)

`MCM_API_BasicButtonHandler(ButtonClickedHandler)
{
	SNEAK_SLIDER.SetBounds(0.0, 9.0, 10.0, SNEAK_SLIDER.GetValue(), true);

	GUNSMACK_SLIDER1.SetBounds(0.0, 9.0, 10.0, GUNSMACK_SLIDER1.GetValue(), true);
	GUNSMACK_SLIDER2.SetBounds(0.0, 9.0, 10.0, GUNSMACK_SLIDER2.GetValue(), true);
	GUNSMACK_SLIDER3.SetBounds(0.0, 100.0, 100.0 / 101.0, GUNSMACK_SLIDER3.GetValue(), true);
	
	FLUSH_SLIDER1.SetBounds(0.0, 99.0, 1.0, FLUSH_SLIDER1.GetValue(), true);
	FLUSH_SLIDER2.SetBounds(-0.99, 0.0, 1.0, FLUSH_SLIDER2.GetValue(), true);

	PSI_ABILITY_SLIDER.SetBounds(0.0, 14.0, 100.0 / 15.0, PSI_ABILITY_SLIDER.GetValue(), true);
	
	TRIAGE_SLIDER.SetBounds(0.0, 99.0, 1.0, TRIAGE_SLIDER.GetValue(), true);
	
	CFG_CLICKED = true;
}

simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
	self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
	default.SETTINGS_CHANGED = true;
	self.SaveConfig();
}

simulated function ResetButtonClicked(MCM_API_SettingsPage Page)
{
	CFG_CLICKED = false;
	
	SNEAK_COOLDOWN = class'GrimyClassRebalance_AbilitySet_Ranger'.default.SNEAK_COOLDOWN;
	SNEAK_SLIDER.SetValue(SNEAK_COOLDOWN, true);
	
	GUNSMACK_DAMAGE = class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_DAMAGE;
	GUNSMACK_SLIDER1.SetValue(GUNSMACK_DAMAGE, true);
	GUNSMACK_SPREAD = class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_SPREAD;
	GUNSMACK_SLIDER2.SetValue(GUNSMACK_SPREAD, true);
	GUNSMACK_CHANCE = class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_CHANCE;
	GUNSMACK_SLIDER3.SetValue(GUNSMACK_CHANCE, true);
	
	FLUSH_AIM = class'GrimyClassRebalance_AbilitySet'.default.FLUSH_AIM;
	FLUSH_SLIDER1.SetValue(FLUSH_AIM, true);
	FLUSH_DAMAGE = class'GrimyClassRebalance_AbilitySet'.default.FLUSH_DAMAGE;
	FLUSH_SLIDER2.SetValue(FLUSH_DAMAGE, true);
	
	MAX_PSI_ABILITIES = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.MAX_PSI_ABILITIES;
	PSI_ABILITY_SLIDER.SetValue(MAX_PSI_ABILITIES, true);
	
	TRIAGE_SHIELD_BONUS = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.TRIAGE_SHIELD_BONUS;
	TRIAGE_SLIDER.SetValue(TRIAGE_SHIELD_BONUS, true);

	bAddGunSmack = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddGunSmack;
	GUNSMACK_CHECKBOX.SetValue(bAddGunSmack, true);

	bAddSuppression = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddSuppression;
	SUPPRESSION_CHECKBOX.SetValue(bAddSuppression, true);

	bAddFlush = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddFlush;
	FLUSH_CHECKBOX.SetValue(bAddFlush, true);

	bAddSneak = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddSneak;
	SNEAK_CHECKBOX.SetValue(bAddSneak, true);

	bSniperOverwatchAfterMoving = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bSniperOverwatchAfterMoving;
	SNIPEROVERWATCH_CHECKBOX.SetValue(bSniperOverwatchAfterMoving, true);

	bDisableVolatileMixDOT = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bDisableVolatileMixDOT;
	VOLATILEMIXDOT_CHECKBOX.SetValue(bDisableVolatileMixDOT, true);

	bDisableTileSnap = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bDisableTileSnap;
	TILESNAP_CHECKBOX.SetValue(bDisableTileSnap, true);
}

simulated function RevertButtonClicked(MCM_API_SettingsPage Page)
{
	// Don't need to do anything since values aren't written until at save-time when you use save handlers.
}

// This shows how to either pull default values from a source config, or to use more user-defined values, gated by a version number mechanism.
simulated function LoadInitialValues()
{
	CFG_CLICKED = false; 

	if ( SNEAK_COOLDOWN > 0 )
		SNEAK_COOLDOWN = `MCM_CH_GetValue(class'GrimyClassRebalance_AbilitySet_Ranger'.default.SNEAK_COOLDOWN,SNEAK_COOLDOWN);
	else
		SNEAK_COOLDOWN = class'GrimyClassRebalance_AbilitySet_Ranger'.default.SNEAK_COOLDOWN;

	if ( GUNSMACK_DAMAGE > 0 )
		GUNSMACK_DAMAGE = `MCM_CH_GetValue(class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_DAMAGE,GUNSMACK_DAMAGE);
	else
		GUNSMACK_DAMAGE = class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_DAMAGE;
		
	if ( GUNSMACK_SPREAD > 0 )
		GUNSMACK_SPREAD = `MCM_CH_GetValue(class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_SPREAD,GUNSMACK_SPREAD);
	else
		GUNSMACK_SPREAD = class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_SPREAD;
		
	if ( GUNSMACK_CHANCE > 0 )
		GUNSMACK_CHANCE = `MCM_CH_GetValue(class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_CHANCE,GUNSMACK_CHANCE);
	else
		GUNSMACK_CHANCE = class'GrimyClassRebalance_AbilitySet'.default.GUNSMACK_CHANCE;
		
	if ( FLUSH_AIM > 0 )
		FLUSH_AIM = `MCM_CH_GetValue(class'GrimyClassRebalance_AbilitySet'.default.FLUSH_AIM,FLUSH_AIM);
	else
		FLUSH_AIM = class'GrimyClassRebalance_AbilitySet'.default.FLUSH_AIM;

	if ( FLUSH_DAMAGE > 0 )
		FLUSH_DAMAGE = `MCM_CH_GetValue(class'GrimyClassRebalance_AbilitySet'.default.FLUSH_DAMAGE,FLUSH_DAMAGE);
	else
		FLUSH_DAMAGE = class'GrimyClassRebalance_AbilitySet'.default.FLUSH_DAMAGE;
		
	if ( MAX_PSI_ABILITIES > 0 )
		MAX_PSI_ABILITIES = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.MAX_PSI_ABILITIES,MAX_PSI_ABILITIES);
	else
		MAX_PSI_ABILITIES = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.MAX_PSI_ABILITIES;
		
	if ( TRIAGE_SHIELD_BONUS > 0 )
		TRIAGE_SHIELD_BONUS = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.TRIAGE_SHIELD_BONUS,TRIAGE_SHIELD_BONUS);
	else
		TRIAGE_SHIELD_BONUS = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.TRIAGE_SHIELD_BONUS;

	if ( SETTINGS_CHANGED ) {
		bAddGunSmack = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddGunSmack, bAddGunSmack);
		bAddSuppression = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddSuppression, bAddSuppression);
		bAddFlush = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddFlush, bAddFlush);
		bAddSneak = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddSneak, bAddSneak);
		bSniperOverwatchAfterMoving = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bSniperOverwatchAfterMoving, bSniperOverwatchAfterMoving);
		bDisableVolatileMixDOT = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bDisableVolatileMixDOT, bDisableVolatileMixDOT);
		bDisableTileSnap = `MCM_CH_GetValue(class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bDisableTileSnap, bDisableTileSnap);
	}
	else {
		bAddGunSmack = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddGunSmack;
		bAddSuppression = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddSuppression;
		bAddFlush = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddFlush;
		bAddSneak = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bAddSneak;
		bSniperOverwatchAfterMoving = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bSniperOverwatchAfterMoving;
		bDisableVolatileMixDOT = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bDisableVolatileMixDOT;
		bDisableTileSnap = class'X2DownloadableContentInfo_GrimyClassRebalance'.default.bDisableTileSnap;
	}
}

defaultproperties
{
	ScreenClass = class'MCM_OptionsScreen'
}