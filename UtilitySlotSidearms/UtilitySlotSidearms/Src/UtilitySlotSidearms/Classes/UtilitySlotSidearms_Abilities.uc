class UtilitySlotSidearms_Abilities extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	if ( class'UtilitySlotSidearms_GrenadeLauncher'.default.bEnableGrenadeLaunchers ) {
		Templates.AddItem(GrimyLoadGrenades());
	}

	return Templates;
}

static function X2AbilityTemplate GrimyLoadGrenades()
{
	local X2AbilityTemplate									Template;
	local UtilitySlotSidearms_LoadGrenades					AmmoEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GrimyLoadGrenades');

	InitializeAbilityTemplate(Template);

	// This will tick once during application at the start of the player's turn and increase ammo of the specified items by the specified amounts
	AmmoEffect = new class'UtilitySlotSidearms_LoadGrenades';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(AmmoEffect);

	if ( class'UtilitySlotSidearms_GrenadeLauncher'.default.bHideThrowGrenade ) {
		Template.OverrideAbilities.AddItem('ThrowGrenade');
	}

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