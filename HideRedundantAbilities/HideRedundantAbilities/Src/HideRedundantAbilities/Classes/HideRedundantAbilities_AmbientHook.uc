class HideRedundantAbilities_AmbientHook extends X2AmbientNarrativeCriteria config(HideRedundantAbilities);

struct HideAbilityItem
{
	var name AbilityName;
	var bool bNewAbilityBehavior;
	var EAbilityIconBehavior NewAbilityBehavior;
	var int KeyBinding;
};

var config array<HideAbilityItem> EDIT_ABILITIES;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>					Templates;
	local X2AbilityTemplateManager				AbilityManager;
	local X2AbilityTemplate						EditAbility;
	local HideAbilityItem						EditItem;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	
	foreach default.EDIT_ABILITIES(EditItem) {
		EditAbility = AbilityManager.FindAbilityTemplate(EditItem.AbilityName);
		if ( EditItem.bNewAbilityBehavior ) {
			EditAbility.eAbilityIconBehaviorHUD = EditItem.NewAbilityBehavior;
		}
		if ( EditItem.KeyBinding > 0 ) {
			EditAbility.DefaultKeyBinding = EditItem.KeyBinding;
		}
	}

	Templates.length = 0;
	return Templates;
}

