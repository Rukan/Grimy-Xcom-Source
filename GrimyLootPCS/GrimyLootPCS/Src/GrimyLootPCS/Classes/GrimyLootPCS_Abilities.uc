class GrimyLootPCS_Abilities extends X2Ability_DefaultAbilitySet config(GrimyLootPCS_ItemData);

var config int GRIMY_AMPBOOSTER_BONUS;
var config int GRIMY_NEUROWHIP_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(AmpBooster());
	Templates.AddItem(GrimyNeuroWhip());
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventTrooperBsc','CorpseAdventTrooper',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventTrooperAdv','CorpseAdventTrooper',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventTrooperSup','CorpseAdventTrooper',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventOfficerBsc','CorpseAdventOfficer',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventOfficerAdv','CorpseAdventOfficer',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventOfficerSup','CorpseAdventOfficer',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventTurretBsc','CorpseAdventTurret',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventTurretAdv','CorpseAdventTurret',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventTurretSup','CorpseAdventTurret',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventStunLancerBsc','CorpseAdventStunLancer',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventStunLancerAdv','CorpseAdventStunLancer',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventStunLancerSup','CorpseAdventStunLancer',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventShieldbearerBsc','CorpseAdventShieldbearer',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventShieldbearerAdv','CorpseAdventShieldbearer',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventShieldbearerSup','CorpseAdventShieldbearer',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventMECBsc','CorpseAdventMEC',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventMECAdv','CorpseAdventMEC',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventMECSup','CorpseAdventMEC',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAndromedonBsc','CorpseAndromedon',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAndromedonAdv','CorpseAndromedon',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAndromedonSup','CorpseAndromedon',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusViperBsc','CorpseViper',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusViperAdv','CorpseViper',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusViperSup','CorpseViper',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusArchonBsc','CorpseArchon',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusArchonAdv','CorpseArchon',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusArchonSup','CorpseArchon',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusMutonBsc','CorpseMuton',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusMutonAdv','CorpseMuton',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusMutonSup','CorpseMuton',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusChryssalidBsc','CorpseChryssalid',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusChryssalidAdv','CorpseChryssalid',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusChryssalidSup','CorpseChryssalid',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusSectopodBsc','CorpseSectopod',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusSectopodAdv','CorpseSectopod',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusSectopodSup','CorpseSectopod',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusFacelessBsc','CorpseFaceless',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusFacelessAdv','CorpseFaceless',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusFacelessSup','CorpseFaceless',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusCyberusBsc','CorpseCyberus',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusCyberusAdv','CorpseCyberus',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusCyberusSup','CorpseCyberus',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusGatekeeperBsc','CorpseGatekeeper',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusGatekeeperAdv','CorpseGatekeeper',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusGatekeeperSup','CorpseGatekeeper',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusBerserkerBsc','CorpseBerserker',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusBerserkerAdv','CorpseBerserker',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusBerserkerSup','CorpseBerserker',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventPsiWitchBsc','CorpseAdventPsiWitch',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventPsiWitchAdv','CorpseAdventPsiWitch',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusAdventPsiWitchSup','CorpseAdventPsiWitch',3));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusSectoidBsc','CorpseSectoid',1));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusSectoidAdv','CorpseSectoid',2));
	Templates.AddItem(GrimyCorpseBonus('GrimyCorpseBonusSectoidSup','CorpseSectoid',3));

	return Templates;
}

static function X2AbilityTemplate GrimyCorpseBonus(name TemplateName, name CorpseName, int Bonus) {
	local X2AbilityTemplate						Template;
	local GrimyLootPCS_Effect_BonusDamageCorpse	CorpseEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AmpBooster');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	CorpseEffect = new class'GrimyLootPCS_Effect_BonusDamageCorpse';
	CorpseEffect.BuildPersistentEffect(1, true, false, false);
	CorpseEffect.CorpseName = CorpseName;
	CorpseEffect.Bonus = Bonus;
	Template.AddTargetEffect(CorpseEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}


static function X2AbilityTemplate AmpBooster() {
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

static function X2AbilityTemplate GrimyNeuroWhip() {
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