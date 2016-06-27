class UtilitySlotSidearms extends X2Item_DefaultWeapons config(UtilitySlotSidearms);

var config bool bEnablePistols, bEnableSwords, bEnableGremlins, bEnablePsiAmps;
var config array<name> PistolAbilities, SwordAbilities, GremlinAbilities, PsiAmpAbilities;
var config bool bEnableCraftableAlienRulers;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate> Weapons;

	if ( default.bEnablePistols ) {
		Weapons.AddItem(CreateTemplate_UtilityPistol_Conventional());
		Weapons.AddItem(CreateTemplate_UtilityPistol_Magnetic());
		Weapons.AddItem(CreateTemplate_UtilityPistol_Beam());
		Weapons.AddItem(CreateTemplate_PairedPistol_Conventional());
		Weapons.AddItem(CreateTemplate_PairedPistol_Magnetic());
		Weapons.AddItem(CreateTemplate_PairedPistol_Beam());
	}
	if ( default.bEnableSwords ) {
		Weapons.AddItem(CreateTemplate_UtilitySword_Conventional());
		Weapons.AddItem(CreateTemplate_UtilitySword_Magnetic());
		Weapons.AddItem(CreateTemplate_UtilitySword_Beam());
		Weapons.AddItem(CreateTemplate_PairedSword_Conventional());
		Weapons.AddItem(CreateTemplate_PairedSword_Magnetic());
		Weapons.AddItem(CreateTemplate_PairedSword_Beam());
	}
	if ( default.bEnableGremlins ) {
		Weapons.AddItem(CreateTemplate_UtilityGremlinDrone_Conventional());
		Weapons.AddItem(CreateTemplate_UtilityGremlinDrone_Magnetic());
		Weapons.AddItem(CreateTemplate_UtilityGremlinDrone_Beam());
		Weapons.AddItem(CreateTemplate_PairedGremlinDrone_Conventional());
		Weapons.AddItem(CreateTemplate_PairedGremlinDrone_Magnetic());
		Weapons.AddItem(CreateTemplate_PairedGremlinDrone_Beam());
	}
	if ( default.bEnablePsiAmps ) {
		Weapons.AddItem(CreateTemplate_UtilityPsiAmp_Conventional());
		Weapons.AddItem(CreateTemplate_UtilityPsiAmp_Magnetic());
		Weapons.AddItem(CreateTemplate_UtilityPsiAmp_Beam());
		Weapons.AddItem(CreateTemplate_PairedPsiAmp_Conventional());
		Weapons.AddItem(CreateTemplate_PairedPsiAmp_Magnetic());
		Weapons.AddItem(CreateTemplate_PairedPsiAmp_Beam());
	}

	return Weapons;
}

static function X2DataTemplate CreateTemplate_UtilityPistol_Conventional() {
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilityPistol_CV');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = 0;

	Template.RangeAccuracy = default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.PISTOL_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.PISTOL_CONVENTIONAL_AIM;
	Template.CritChance = default.PISTOL_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.PISTOL_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.PistolAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_CV.WP_Pistol_CV";

	Template.iPhysicsImpulse = 5;
	
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityPistol_Magnetic() {
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilityPistol_MG');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 2;

	Template.RangeAccuracy = default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = default.PISTOL_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.PISTOL_MAGNETIC_AIM;
	Template.CritChance = default.PISTOL_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.PISTOL_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.PistolAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_MG.WP_Pistol_MG";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityPistol_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityPistol_Beam() {
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilityPistol_BM');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = 4;

	Template.RangeAccuracy = default.SHORT_BEAM_RANGE;
	Template.BaseDamage = default.PISTOL_BEAM_BASEDAMAGE;
	Template.Aim = default.PISTOL_BEAM_AIM;
	Template.CritChance = default.PISTOL_BEAM_CRITCHANCE;
	Template.iClipSize = default.PISTOL_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.PistolAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_BM.WP_Pistol_BM";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityPistol_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;
	
	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_UtilitySword_Conventional() {
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilitySword_CV');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.Sword";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_CV.WP_Sword_CV";
	Template.AddDefaultAttachment('Sheath', "ConvSword.Meshes.SM_ConvSword_Sheath", true);
	Template.Tier = 0;
	foreach default.SwordAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = default.RANGERSWORD_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.RANGERSWORD_CONVENTIONAL_AIM;
	Template.CritChance = default.RANGERSWORD_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = default.RANGERSWORD_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.RANGERSWORD_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';
	
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilitySword_Magnetic() {
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilitySword_MG');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagSword";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_MG.WP_Sword_MG";
	Template.AddDefaultAttachment('R_Back', "MagSword.Meshes.SM_MagSword_Sheath", false);
	Template.Tier = 2;
	foreach default.SwordAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = default.RANGERSWORD_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.RANGERSWORD_MAGNETIC_AIM;
	Template.CritChance = default.RANGERSWORD_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = default.RANGERSWORD_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.RANGERSWORD_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.RANGERSWORD_MAGNETIC_STUNCHANCE, false));

	Template.CreatorTemplateName = 'Sword_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilitySword_CV'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , default.RANGERSWORD_MAGNETIC_STUNCHANCE, , , "%");

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilitySword_Beam() {
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilitySword_BM');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamSword";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_BM.WP_Sword_BM";
	Template.AddDefaultAttachment('R_Back', "BeamSword.Meshes.SM_BeamSword_Sheath", false);
	Template.Tier = 4;
	foreach default.SwordAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = default.RANGERSWORD_BEAM_BASEDAMAGE;
	Template.Aim = default.RANGERSWORD_BEAM_AIM;
	Template.CritChance = default.RANGERSWORD_BEAM_CRITCHANCE;
	Template.iSoundRange = default.RANGERSWORD_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.RANGERSWORD_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));
	
	Template.CreatorTemplateName = 'Sword_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilitySword_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';
	
	return Template;
}


static function X2DataTemplate CreateTemplate_UtilityGremlinDrone_Conventional() {
	local X2GremlinTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, 'UtilityGremlin_CV');
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Gremlin_Drone";
	Template.EquipSound = "Gremlin_Equip";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.GremlinAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.CosmeticUnitTemplate = "GremlinMk1";
	Template.Tier = 0;

	Template.ExtraDamage = default.GREMLINMK1_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLIN_HACKBONUS;
	Template.AidProtocolBonus = 0;
	Template.HealingBonus = 0;
	Template.BaseDamage.Damage = 2;     //  combat protocol
	Template.BaseDamage.Pierce = 1000;  //  ignore armor

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Electrical';

	Template.bHideDamageStat = true;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLIN_HACKBONUS, true);

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityGremlinDrone_Magnetic() {
	local X2GremlinTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, 'UtilityGremlin_MG');
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagGremlin";
	Template.EquipSound = "Gremlin_Equip";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.GremlinAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.CosmeticUnitTemplate = "GremlinMk2";
	Template.Tier = 2;

	Template.ExtraDamage = default.GREMLINMK2_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLINMK2_HACKBONUS;
	Template.AidProtocolBonus = 10;
	Template.HealingBonus = 1;
	Template.BaseDamage.Damage = 4;     //  combat protocol
	Template.BaseDamage.Pierce = 1000;  //  ignore armor

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Gremlin_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityGremlin_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Electrical';

	Template.bHideDamageStat = true;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLINMK2_HACKBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityGremlinDrone_Beam() {
	local X2GremlinTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, 'UtilityGremlin_BM');
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamGremlin";
	Template.EquipSound = "Gremlin_Equip";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	foreach default.GremlinAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}

	Template.CosmeticUnitTemplate = "GremlinMk3";
	Template.Tier = 4;

	Template.ExtraDamage = default.GREMLINMK3_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLINMK3_HACKBONUS;
	Template.AidProtocolBonus = 20;
	Template.HealingBonus = 2;
	Template.RevivalChargesBonus = 1;
	Template.ScanningChargesBonus = 1;
	Template.BaseDamage.Damage = 6;     //  combat protocol
	Template.BaseDamage.Pierce = 1000;  //  ignore armor

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Gremlin_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityGremlin_MG'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Electrical';
	
	Template.bHideDamageStat = true;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLINMK3_HACKBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityPsiAmp_Conventional()
{
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilityPsiAmp_CV');
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponCat = 'psiamp';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.PsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = 0;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_CV.WP_PsiAmp_CV";
	
	foreach default.PsiAmpAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}
	Template.Abilities.AddItem('PsiAmpCV_BonusStats');
	
	Template.ExtraDamage = default.PSIAMPT1_ABILITYDAMAGE;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	// Show In Armory Requirements
	Template.ArmoryDisplayRequirements.RequiredTechs.AddItem('Psionics');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_CV_STATBONUS, true);

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityPsiAmp_Magnetic()
{
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilityPsiAmp_MG');
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = 2;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_MG.WP_PsiAmp_MG";
	
	foreach default.PsiAmpAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}
	Template.Abilities.AddItem('PsiAmpMG_BonusStats');

	Template.ExtraDamage = default.PSIAMPT2_ABILITYDAMAGE;

	Template.CreatorTemplateName = 'PsiAmp_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityPsiAmp_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_MG_STATBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_UtilityPsiAmp_Beam()
{
	local X2WeaponTemplate Template;
	local name AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UtilityPsiAmp_BM');
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_QuaternaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = 4;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_BM.WP_PsiAmp_BM";
	
	foreach default.PsiAmpAbilities(AbilityName) {
		Template.Abilities.AddItem(AbilityName);
	}
	Template.Abilities.AddItem('PsiAmpBM_BonusStats');

	Template.ExtraDamage = default.PSIAMPT3_ABILITYDAMAGE;

	Template.CreatorTemplateName = 'PsiAmp_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'UtilityPsiAmp_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_BM_STATBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedPistol_Conventional() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedPistol_CV');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityPistol_CV';
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = 0;
	
	Template.InventorySlot = eInvSlot_Utility;
	
	// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Pistol_CV.WP_Pistol_CV";
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedPistol_Magnetic() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedPistol_MG');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityPistol_MG';
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 2;

	Template.InventorySlot = eInvSlot_Utility;
	
	// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Pistol_MG.WP_Pistol_MG";

	Template.CreatorTemplateName = 'Pistol_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedPistol_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedPistol_Beam() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedPistol_BM');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityPistol_BM';
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = 4;
	
	Template.InventorySlot = eInvSlot_Utility;
	
	// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Pistol_BM.WP_Pistol_BM";

	Template.CreatorTemplateName = 'Pistol_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedPistol_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_PairedSword_Conventional() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedSword_CV');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilitySword_CV';
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.Sword";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Sword_CV.WP_Sword_CV";
	Template.AddDefaultAttachment('Sheath', "ConvSword.Meshes.SM_ConvSword_Sheath", true);
	Template.Tier = 0;
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedSword_Magnetic() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedSword_MG');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilitySword_MG';
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagSword";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Sword_MG.WP_Sword_MG";
	Template.AddDefaultAttachment('R_Back', "MagSword.Meshes.SM_MagSword_Sheath", false);
	Template.Tier = 2;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.RANGERSWORD_MAGNETIC_STUNCHANCE, false));

	Template.CreatorTemplateName = 'Sword_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedSword_CV'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedSword_Beam() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedSword_BM');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilitySword_BM';
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamSword";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Sword_BM.WP_Sword_BM";
	Template.AddDefaultAttachment('R_Back', "BeamSword.Meshes.SM_BeamSword_Sheath", false);
	Template.Tier = 4;
	
	Template.CreatorTemplateName = 'Sword_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedSword_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	return Template;
}


static function X2DataTemplate CreateTemplate_PairedGremlinDrone_Conventional() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedGremlin_CV');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityGremlin_CV';
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gremlin';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Gremlin_Drone";
	Template.EquipSound = "Gremlin_Equip";
	Template.InventorySlot = eInvSlot_Utility;

	//Template.CosmeticUnitTemplate = "GremlinMk1";
	Template.Tier = 0;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedGremlinDrone_Magnetic() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedGremlin_MG');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityGremlin_MG';
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gremlin';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagGremlin";
	Template.EquipSound = "Gremlin_Equip";
	Template.InventorySlot = eInvSlot_Utility;

	//Template.CosmeticUnitTemplate = "GremlinMk2";
	Template.Tier = 2;

	Template.CreatorTemplateName = 'Gremlin_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedGremlin_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedGremlinDrone_Beam() {
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedGremlin_BM');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityGremlin_BM';
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gremlin';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamGremlin";
	Template.EquipSound = "Gremlin_Equip";
	Template.InventorySlot = eInvSlot_Utility;

	//Template.CosmeticUnitTemplate = "GremlinMk3";
	Template.Tier = 4;

	Template.CreatorTemplateName = 'Gremlin_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedGremlin_MG'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedPsiAmp_Conventional()
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedPsiAmp_CV');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityPsiAmp_CV';
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponCat = 'psiamp';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.PsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = 0;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_CV.WP_PsiAmp_CV";

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	// Show In Armory Requirements
	Template.ArmoryDisplayRequirements.RequiredTechs.AddItem('Psionics');

	return Template;
}

static function X2DataTemplate CreateTemplate_PairedPsiAmp_Magnetic()
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedPsiAmp_MG');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityPsiAmp_MG';
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = 2;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_MG.WP_PsiAmp_MG";

	Template.CreatorTemplateName = 'PsiAmp_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedPsiAmp_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	return Template;
}

static function X2DataTemplate CreateTemplate_PairedPsiAmp_Beam()
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, 'PairedPsiAmp_BM');
	Template.PairedSlot = eInvSlot_QuaternaryWeapon;
	Template.PairedTemplateName = 'UtilityPsiAmp_BM';
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = 4;
	// This all the resources; sounds, animations, models, physics, the works.
	
	//Template.GameArchetype = "WP_PsiAmp_BM.WP_PsiAmp_BM";

	Template.CreatorTemplateName = 'PsiAmp_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PairedPsiAmp_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	return Template;
}