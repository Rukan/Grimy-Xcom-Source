class GrimyClassAN_AbilitySet extends X2Ability_GrenadierAbilitySet config(GrimyClassAN);

var config int LIGHT_ORDNANCE_AMMO;
var config float LIGHT_ORDNANCE_DAMAGE;

var config int VILE_CONCOCTIONS_DAMAGE;
var config array<name> VILE_CONCOCTIONS_GRENADES;

var config int SHREDDER_SHRED, SHREDDER_AP;
var config int SKULLMINE_BONUS;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Templates;

	Templates.AddItem(GrimyLightOrdnance('GrimyLightOrdnance',default.LIGHT_ORDNANCE_AMMO,default.LIGHT_ORDNANCE_DAMAGE,"img:///UILibrary_PerkIcons.UIPerk_equalizer"));
	Templates.AddItem(GrimyVileConcoctions('GrimyVileConcoctions',default.VILE_CONCOCTIONS_DAMAGE,"img:///UILibrary_PerkIcons.UIPerk_andromedon_acidblob"));
	Templates.AddItem(GrimyGrenadeShredder('GrimyGrenadeShredder',default.SHREDDER_SHRED, default.SHREDDER_AP, "img:///UILibrary_PerkIcons.UIPerk_barage"));
	Templates.AddItem(GrimySabotage('GrimySabotage',"img:///UILibrary_PerkIcons.UIPerk_codex_techvulnerability"));
	Templates.AddItem(GrimySabotage('GrimyHostageProtocol',"img:///UILibrary_PerkIcons.UIPerk_bioelectricskin"));
	Templates.AddItem(GrimySadist('GrimySadist',default.SKULLMINE_BONUS,"img:///UILibrary_PerkIcons.UIPerk_skulljack"));
	
	Templates.AddItem(PurePassive('GrimyShellShock', "img:///UILibrary_PerkIcons.UIPerk_archon_blast"));
	Templates.AddItem(PurePassive('GrimyAirBurst', "img:///UILibrary_PerkIcons.UIPerk_bigbooms"));
	Templates.AddItem(PurePassive('GrimyDeadlyHaze', "img:///GrimyClassAN_Icons.UIPerk_ToxicCloud"));
	Templates.AddItem(PurePassive('GrimyLongShot', "img:///UILibrary_PerkIcons.UIPerk_bombard"));

	return Templates;
}

static function X2AbilityTemplate GrimySadist(name TemplateName, int Bonus, string ImageIcon) {
	local X2AbilityTemplate									Template;
	local GrimyClassAN_BonusAbilityCharges					AmmoEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.IconImage = ImageIcon;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;

	// This will tick once during application at the start of the player's turn and increase ammo of the specified items by the specified amounts
	AmmoEffect = new class'GrimyClassAN_BonusAbilityCharges';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	AmmoEffect.NumCharges = Bonus;
	AmmoEffect.AbilityName = 'SKULLMINEAbility';
	Template.AddTargetEffect(AmmoEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimySabotage(name TemplateName, string ImageIcon) {
	local X2AbilityTemplate									Template;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.AdditionalAbilities.AddItem('CombatProtocol');
	Template.IconImage = ImageIcon;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyGrenadeShredder(name TemplateName, int BonusShred, int BonusAP, string ImageIcon) {
	local X2AbilityTemplate									Template;
	local GrimyClassAN_Shredder								DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.IconImage = ImageIcon;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.bDisplayInUITacticalText = false;

	DamageEffect = new class'GrimyClassAN_Shredder';
	DamageEffect.BuildPersistentEffect(1, true, true, true);
	DamageEffect.BonusShred = BonusShred;
	DamageEffect.BonusAP = BonusAP;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate GrimyLightOrdnance(name TemplateName, int Bonus, float DamageMult, string ImageIcon) {
	local X2AbilityTemplate									Template;
	local GrimyClassAN_BonusItemCharges						AmmoEffect;
	local GrimyClassAN_Effect_GrenadeDamage					DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.IconImage = ImageIcon;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	// This will tick once during application at the start of the player's turn and increase ammo of the specified items by the specified amounts
	AmmoEffect = new class'GrimyClassAN_BonusItemCharges';
	AmmoEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin); 
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	AmmoEffect.AmmoCount = Bonus;
	AmmoEffect.bUtilityGrenades = true;
	AmmoEffect.bPocketGrenades = true;
	Template.AddTargetEffect(AmmoEffect);

	DamageEffect = new class'GrimyClassAN_Effect_GrenadeDamage';
	DamageEffect.BuildPersistentEffect(1, true, true, true);
	DamageEffect.DamageMult = DamageMult;
	Template.AddTargetEffect(DamageEffect);

	Template.OverrideAbilities.AddItem('ThrowGrenade');

	Template.SoldierAbilityPurchasedFn = LightOrdnancePurchased;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

function LightOrdnancePurchased(XComGameState NewGameState, XComGameState_Unit UnitState)
{
	local X2ItemTemplate FreeItem;
	local XComGameState_Item ItemState;
	local XComGameState_HeadquartersXCom XComHQ;

	if (UnitState.IsMPCharacter())
		return;
	
	if (!UnitState.HasGrenadePocket())
	{
		`RedScreen("GrenadePocketPurchased called but the unit doesn't have one? -jbouscher / @gameplay" @ UnitState.ToString());		
		return;
	}

	XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();

	if ( XComHQ.IsTechResearched('AdvancedGrenades') ) {
		FreeItem = class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate('GasGrenadeMk2');
	}
	else {
		FreeItem = class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate('GasGrenade');
	}

	if (FreeItem == none)
	{
		`RedScreen("Free grenade '" $ default.FreeGrenadeForPocket $ "' is not a valid item template.");
		return;
	}
	ItemState = FreeItem.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(ItemState);
	UnitState.RemoveItemFromInventory(UnitState.GetItemInSlot(eInvSlot_GrenadePocket), NewGameState);
	if (!UnitState.AddItemToInventory(ItemState, eInvSlot_GrenadePocket, NewGameState))
	{
		`RedScreen("Unable to add free grenade to unit's inventory. Sadness." @ UnitState.ToString());
		return;
	}
}

static function X2AbilityTemplate GrimyVileConcoctions(name TemplateName, int BonusDamage, string ImageIcon) {
	local X2AbilityTemplate									Template;
	local GrimyClassAN_Effect_GrenadeDamage					DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.IconImage = ImageIcon;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageEffect = new class'GrimyClassAN_Effect_GrenadeDamage';
	DamageEffect.BuildPersistentEffect(1, true, true, true);
	DamageEffect.BonusDamage = BonusDamage;
	DamageEffect.bDOTOnly = true;
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}