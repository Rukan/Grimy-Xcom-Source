class Grimy_CutContent_PsionicAbilityTemplates extends X2Ability dependson (XComGameStateContext_Ability) config(CutContentPsionics);

var config int GRIMY_AMPBOOSTER_BONUS;
var config int GRIMY_NEUROWHIP_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(AmpBooster());
	Templates.AddItem(GrimyNeuroWhip());

	return Templates;
}

static function X2AbilityTemplate AmpBooster()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PersistentStatChange         PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AmpBooster');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	//PersistentStatChangeEffect.EffectName = 'MindShieldStats';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_PsiOffense, default.GRIMY_AMPBOOSTER_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate GrimyNeuroWhip()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PersistentStatChange         PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyNeuroWhip');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	//PersistentStatChangeEffect.EffectName = 'MindShieldStats';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_PsiOffense, default.GRIMY_NEUROWHIP_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}