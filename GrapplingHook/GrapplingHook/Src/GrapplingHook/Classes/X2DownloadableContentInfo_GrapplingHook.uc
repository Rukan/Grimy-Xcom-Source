class X2DownloadableContentInfo_GrapplingHook extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2CharacterTemplateManager	CharManager;
	local X2CharacterTemplate			CharTemplate;

	local array<X2DataTemplate>		DifficultyTemplates;
	local X2DataTemplate			DifficultyTemplate;

	local X2AbilityTemplateManager	AbilityManager;
	local X2AbilityTemplate			AbilityTemplate;
	
	local X2AbilityMultiTarget_Radius       RadiusMultiTarget;

	CharManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	CharManager.FindDataTemplateAllDifficulties('Soldier',DifficultyTemplates);
	
	foreach DifficultyTemplates(DifficultyTemplate) {
		CharTemplate = X2CharacterTemplate(DifficultyTemplate);
		if ( CharTemplate != none ) {
			CharTemplate.Abilities.AddItem('Grapple');
		}
	}

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplate = AbilityManager.FindAbilityTemplate('Grapple');
	AbilityTemplate.TargetingMethod = class'X2TargetingMethod_VoidRift';
	//AbilityTemplate.TargetingMethod = class'X2TargetingMethod_RocketLauncher';
	//AbilityTemplate.TargetingMethod = class'X2TargetingMethod_MimicBeacon';
	//AbilityTemplate.TargetingMethod = class'X2TargetingMethod_EvacZone';
	//AbilityTemplate.TargetingMethod = class'X2TargetingMethod_GrimyGrapple';
	AbilityTemplate.AbilityShooterConditions.Remove(1,1);
	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = 1.0;
	AbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;
}