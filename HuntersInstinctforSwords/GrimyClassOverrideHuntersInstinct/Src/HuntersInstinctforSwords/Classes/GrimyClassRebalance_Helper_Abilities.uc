class GrimyClassRebalance_Helper_Abilities extends X2AbilityTemplate;

static function GrimyInjectTargetEffect(X2AbilityTemplate AbilityTemplate, X2Effect NewEffect, int Index) {
	AbilityTemplate.AbilityTargetEffects[Index] = NewEffect;
}