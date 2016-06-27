class GrimyClass_Effect_CoveringFire extends X2Effect_CoveringFire;

var bool bOncePerTarget;

DefaultProperties
{
	EffectName = "ReturnFire"
	DuplicateResponse = eDupe_Ignore
	AbilityToActivate = "PistolReturnFire"
	GrantActionPoint = "returnfire"
	bDirectAttackOnly = true
	bPreEmptiveFire = false
	bOnlyDuringEnemyTurn = true
}