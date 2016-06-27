class Grimy_Ability_DeadShot extends X2Ability_SharpshooterAbilitySet config(GameData_SoldierSkills);

//******** Hit Where It Hurts Ability **********
static function X2AbilityTemplate AddHitWhereItHurtsAbility()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTargetStyle                  TargetStyle;
	local X2AbilityTrigger						Trigger;
	local X2Effect_ToHitModifier                ToHitModifier;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HitWhereItHurts');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hithurts";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	ToHitModifier = new class'X2Effect_ToHitModifier';
	ToHitModifier.BuildPersistentEffect(1, true, true, true);
	ToHitModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	ToHitModifier.AddEffectHitModifier(eHit_Crit, default.HITWHEREITHURTS_CRIT, Template.LocFriendlyName, /*StandardAim*/, false, true, true, true);
	ToHitModifier.AddEffectHitModifier(eHit_Graze, -100, Template.LocFriendlyName, /*StandardAim*/, false, true, true, true);
	Template.AddTargetEffect(ToHitModifier);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}