class GrimyMorale_Effect_Willpower extends X2Effect config(GrimyMorale);

var config int EXTRA_WILL_SPREAD;
var config float MISS_MULT, DODGE_MULT, HIT_MULT, CRIT_MULT;
var config float SQUAD_WILL_LOSS_MULT, RESTORE_WILL_MULT, SQUAD_RESTORE_WILL_MULT;

var localized string MoraleMessage;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState) {
	local EAbilityHitResult					HitResult;
	local XComGameState_Unit				TargetUnit;
	local XComGameState_Item				SourceWeapon;
	local WeaponDamageValue					DamageValue;
	local int								NewWill;

	//Initialize some information we will need to use
	HitResult = ApplyEffectParameters.AbilityResultContext.HitResult;
	TargetUnit = XComGameState_Unit(kNewTargetState);
	SourceWeapon = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.ItemStateObjectRef.ObjectID));
	SourceWeapon.GetBaseWeaponDamageValue(TargetUnit,DamageValue);

	NewWill = GetDamagedWillpower(DamageValue, HitResult, TargetUnit);
	TargetUnit.SetCurrentStat(eStat_Will,NewWill);

	NewGameState.AddStateObject(TargetUnit);
}

simulated function int GetDamagedWillpower(WeaponDamageValue DamageValue, EAbilityHitResult HitResult, XComGameState_Unit TargetUnit) {
	local int WillMin, WillMax, WillMod, Armor;

	Armor = TargetUnit.GetCurrentStat(eStat_ArmorMitigation);
	WillMin = DamageValue.Damage - DamageValue.Spread - Armor;
	WillMax = DamageValue.Damage + DamageValue.Spread - Armor;

	if ( DamageValue.PlusOne > 0 )
		WillMax++;
		
	switch ( HitResult ) {
		case eHit_Crit:
			WillMin *= default.CRIT_MULT;
			WillMax *= default.CRIT_MULT;
			break;
		case eHit_Graze:
			WillMin *= default.DODGE_MULT;
			WillMax *= default.DODGE_MULT;
			break;
		case eHit_Success:
			WillMin *= default.HIT_MULT;
			WillMax *= default.HIT_MULT;
			break;
		case eHit_Miss:
			WillMin *= default.MISS_MULT;
			WillMax *= default.MISS_MULT;
			break;
	}

	WillMin -= default.EXTRA_WILL_SPREAD;
	WillMax += default.EXTRA_WILL_SPREAD;
	
	if ( WillMin < 0 )
		WillMin = 0;

	if ( WillMax < 0 )
		WillMax = 0;

	WillMod = `SYNC_RAND(WillMax-WillMin)+WillMin;

	WillMod = TargetUnit.GetCurrentStat(eStat_Will) - WillMod;
	
	if ( WillMod < 0 )
		WillMod = 0;

	ProcessAffliction(TargetUnit);
	
	return WillMod;
}

simulated function ProcessAffliction(XComGameState_Unit TargetUnit) {
	
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const name EffectApplyResult) {
	local XComGameState_Unit OldUnit, NewUnit;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int WillDmg;

	OldUnit = XComGameState_Unit(BuildTrack.StateObject_OldState);
	NewUnit = XComGameState_Unit(BuildTrack.StateObject_NewState);
	WillDmg = OldUnit.GetCurrentStat(eStat_Will) - NewUnit.GetCurrentStat(eStat_Will);

	if (OldUnit != none && NewUnit != None && NewUnit.IsAlive() && WillDmg != 0 ) {
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext()));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, WillDmg $ default.MoraleMessage, '', eColor_Green);
	}
}

simulated function AddX2ActionsForVisualization_Tick(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const int TickIndex, XComGameState_Effect EffectState) {
	AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, 'AA_Success');
}