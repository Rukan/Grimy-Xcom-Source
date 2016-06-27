class LimitedPsiUsage_AmbientHook extends X2AmbientNarrativeCriteria config(LimitedPsiUsage);

var config int DOMINATION_CHARGES, VOID_RIFT_CHARGES, NULL_LANCE_CHARGES, INSPIRE_CHARGES, INSANITY_CHARGES, STASIS_CHARGES, FUSE_CHARGES, SOULFIRE_CHARGES;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>			Templates;
	local X2AbilityTemplateManager		AbilityManager;
	local X2AbilityTemplate				PsiAbility;
	local X2AbilityCharges              Charges;
	local X2AbilityCost_Charges         ChargeCost;

	AbilityManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	if ( default.SOULFIRE_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('Soulfire');

		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.SOULFIRE_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}

	if ( default.STASIS_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('Stasis');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.STASIS_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}

	if ( default.INSANITY_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('Insanity');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.INSANITY_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}

	if ( default.INSPIRE_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('Inspire');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.INSPIRE_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}
	
	if ( default.FUSE_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('Fuse');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.FUSE_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}

	if ( default.NULL_LANCE_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('NullLance');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.NULL_LANCE_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}

	if ( default.VOID_RIFT_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('VoidRift');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.VOID_RIFT_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		PsiAbility.AbilityCosts.AddItem(ChargeCost);
	}

	if ( default.DOMINATION_CHARGES > 0 ) {
		PsiAbility = AbilityManager.FindAbilityTemplate('Domination');
		
		PsiAbility.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
		PsiAbility.HideErrors.AddItem('AA_CannotAfford_Charges');

		Charges = new class'X2AbilityCharges';
		Charges.InitialCharges = default.DOMINATION_CHARGES;
		PsiAbility.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		ChargeCost.bOnlyOnHit = true;
		PsiAbility.AbilityCosts[1] = ChargeCost;
	}
	else {
		PsiAbility.AbilityCosts.Remove(1,1);
	}


	Templates.length = 0;

	return Templates;
}