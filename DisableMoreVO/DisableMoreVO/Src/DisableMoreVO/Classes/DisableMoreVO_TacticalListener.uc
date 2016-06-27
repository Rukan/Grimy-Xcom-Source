class DisableMoreVO_TacticalListener extends UIScreenListener config(DisableMoreVO);

var config bool DisableNarrativeMoments;
var config array<name> DisableCharacterSightedMoments;

event OnInit(UIScreen Screen) {
	local XComTacticalMissionManager			MissionManager;
	local X2MissionNarrativeTemplateManager		TemplateManager;
	local X2MissionNarrativeTemplate			NarrativeTemplate;
//	local XComGameState_HeadquartersXCom		XComHQ;
	local int									i;
	
//	local X2CharacterTemplateManager			CharacterManager;
//	local X2CharacterTemplate					CharacterTemplate;
//	local name									TemplateName;

	if ( default.DisableNarrativeMoments ) {
		MissionManager = `TACTICALMISSIONMGR;
		TemplateManager = class'X2MissionNarrativeTemplateManager'.static.GetMissionNarrativeTemplateManager();
		NarrativeTemplate = TemplateManager.FindMissionNarrativeTemplate(MissionManager.ActiveMission.sType, MissionManager.MissionQuestItemTemplate);

		for ( i=0; i<NarrativeTemplate.NarrativeMoments.length; i++ ) {
			NarrativeTemplate.NarrativeMoments[i] = "";
		}
	}

	/*
	// Disable Character VOs
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
	CharacterManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	foreach default.DisableCharacterSightedMoments(TemplateName) {
		CharacterTemplate = CharacterManager.FindCharacterTemplate(TemplateName);
		if ( XComHQ.SeenCharacterTemplates.Find(CharacterTemplate.CharacterGroupName) == INDEX_NONE ) {
			XComHQ.AddSeenCharacterTemplate(CharacterTemplate);
		}
	}*/
}

defaultProperties
{
    ScreenClass = class'UITacticalHUD'
}