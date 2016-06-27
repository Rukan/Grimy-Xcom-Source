class GrimyClassFury_Effect_WillToSurvive extends X2Effect_ModifyStats;

var float WillMult;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local StatChange NewChange;
	local array<StatChange>	m_aStatChanges;

	NewChange.StatType = eStat_HP;
	NewChange.StatAmount = XComGameState_Unit(kNewTargetState).GetMaxStat(eStat_Will) * WillMult;
	NewChange.ModOp = MODOP_Addition;
	m_aStatChanges.AddItem(NewChange);

	NewEffectState.StatChanges = m_aStatChanges;
	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}