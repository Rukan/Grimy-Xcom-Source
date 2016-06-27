class X2DownloadableContentInfo_HuntersInstinctforSwords extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager							AbilityManager;
	local X2AbilityTemplate									Template;
	local Grimy_Effect_HuntersInstinctDamage				HuntersInstinctEffect;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	Template = AbilityManager.FindAbilityTemplate('HuntersInstinct');
	HuntersInstinctEffect = new class'Grimy_Effect_HuntersInstinctDamage';
	HuntersInstinctEffect.BuildPersistentEffect(1, true, true, true);
	HuntersInstinctEffect.BonusDamage = class'X2Ability_RangerAbilitySet'.default.INSTINCT_DMG;
	HuntersInstinctEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	class'GrimyClassRebalance_Helper_Abilities'.static.GrimyInjectTargetEffect(Template, HuntersInstinctEffect, 0);
}