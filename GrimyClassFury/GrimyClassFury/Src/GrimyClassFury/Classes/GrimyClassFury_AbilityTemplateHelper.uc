class GrimyClassFury_AbilityTemplateHelper extends X2AbilityTemplate;

static function InjectTargetEffect(X2AbilityTemplate AkTemplate, X2Effect akEffect, int Index) {
	akTemplate.AbilityTargetEffects[Index] = akEffect;
}