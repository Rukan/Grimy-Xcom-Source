class MissionTimers_Abilities extends X2Ability config(MissionTimers);

var config float UPGRADE_BONUS_BSC, UPGRADE_BONUS_ADV, UPGRADE_BONUS_SUP;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;

	Templates.AddItem(BonusTimeAbility('GrimyBonusTimeBsc',0));
	Templates.AddItem(BonusTimeAbility('GrimyBonusTimeAdv',1));
	Templates.AddItem(BonusTimeAbility('GrimyBonusTimeSup',2));

	return Templates;
}

static function X2AbilityTemplate BonusTimeAbility(name TemplateName, int UpgradeIndex) {
	local X2AbilityTemplate									Template;
	local MissionTimers_Effect_BonusTime					TimeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	InitializeAbilityTemplate(Template);

	// This will tick once during application at the start of the player's turn and increase ammo of the specified items by the specified amounts
	TimeEffect = new class'MissionTimers_Effect_BonusTime';
	TimeEffect.BuildPersistentEffect(1, true, true, , eGameRule_PlayerTurnBegin); 
	TimeEffect.UpgradeIndex = UpgradeIndex;
	TimeEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(TimeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function InitializeAbilityTemplate(X2AbilityTemplate Template)
{
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;
}