class GrimyClassAN_Effect_Healing extends X2Effect;

var int PerUseHP;       //  amount of HP to heal for any application of the effect
var int HealSpread;
var localized string HealedMessage;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Ability Ability;
	local XComGameState_Unit TargetUnit, SourceUnit;
	local XComGameState_Item ItemState;
	local X2GremlinTemplate GremlinTemplate;
	local int SourceObjectID, HealAmount;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	Ability = XComGameState_Ability(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	if (Ability == none)
		Ability = XComGameState_Ability(History.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (Ability != none && TargetUnit != none)
	{
		HealAmount = PerUseHP;
		HealAmount += `SYNC_RAND(HealSpread);

		ItemState = Ability.GetSourceWeapon();
		if (ItemState != none)
		{
			GremlinTemplate = X2GremlinTemplate(ItemState.GetMyTemplate());
			if (GremlinTemplate != none)
				HealAmount += GremlinTemplate.HealingBonus;
		}

		TargetUnit.ModifyCurrentStat(eStat_HP, HealAmount);
		`TRIGGERXP('XpHealDamage', ApplyEffectParameters.SourceStateObjectRef, kNewTargetState.GetReference(), NewGameState);

		SourceObjectID = ApplyEffectParameters.SourceStateObjectRef.ObjectID;
		SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(SourceObjectID));
		if ((SourceObjectID != TargetUnit.ObjectID) && SourceUnit.CanEarnSoldierRelationshipPoints(TargetUnit)) // pmiller - so that you can't have a relationship with yourself
		{
			SourceUnit = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', SourceObjectID));
			SourceUnit.AddToSquadmateScore(TargetUnit.ObjectID, class'X2ExperienceConfig'.default.SquadmateScore_MedikitHeal);
			NewGameState.AddStateObject(SourceUnit);
			TargetUnit.AddToSquadmateScore(SourceUnit.ObjectID, class'X2ExperienceConfig'.default.SquadmateScore_MedikitHeal);
		}
	}
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const name EffectApplyResult)
{
	local XComGameState_Unit OldUnit, NewUnit;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int Healed;
	local string Msg;

	OldUnit = XComGameState_Unit(BuildTrack.StateObject_OldState);
	NewUnit = XComGameState_Unit(BuildTrack.StateObject_NewState);

	if (OldUnit != none && NewUnit != None)
	{
		Healed = NewUnit.GetCurrentStat(eStat_HP) - OldUnit.GetCurrentStat(eStat_HP) + class'GrimyClassAN_SpecialistAbilitySet'.default.CAUTERIZE_DAMAGE;
	
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext()));
		Msg = Repl(default.HealedMessage, "<Heal/>", Healed);
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg, '', eColor_Good);
	}
}

simulated function AddX2ActionsForVisualization_Tick(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const int TickIndex, XComGameState_Effect EffectState)
{
	AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, 'AA_Success');
}