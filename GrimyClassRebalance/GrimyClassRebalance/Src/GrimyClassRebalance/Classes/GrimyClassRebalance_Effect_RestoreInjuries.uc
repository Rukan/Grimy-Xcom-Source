class GrimyClassRebalance_Effect_RestoreInjuries extends X2Effect;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	TargetUnit.LowestHP = TargetUnit.HighestHP;
}