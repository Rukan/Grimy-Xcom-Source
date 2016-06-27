class CantExecuteRulers_AbilitySet extends X2Ability;

static function array<X2DataTemplate> CreateTemplates() {
	return class'X2DownloadableContentInfo_CantExecuteRulers'.static.GetTemplates();
}

static function X2AbilityTemplate GrimyRepeaterBonusDamage(name TemplateName, int Bonus, EInventorySlot SlotType) {
	local X2AbilityTemplate						Template;
	local CantExecuteRulers_Effect				BonusDamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;
		
	BonusDamageEffect = new class'CantExecuteRulers_Effect';
	BonusDamageEffect.BuildPersistentEffect(1, true, false, false);
	BonusDamageEffect.Bonus = Bonus;
	BonusDamageEffect.Slot = SlotType;
	Template.AddTargetEffect(BonusDamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}