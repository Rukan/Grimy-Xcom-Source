class GrimyLoot_AbilityTemplateHelper extends X2AbilityTemplate;

static function ClearTargetEffects(X2AbilityTemplate EditTemplate) {
	EditTemplate.AbilityTargetEffects.length = 0;
}

static function ClearMultiTargetEffects(X2AbilityTemplate EditTemplate) {
	EditTemplate.AbilityMultiTargetEffects.length = 0;
}

static function ClearShooterEffects(X2AbilityTemplate EditTemplate) {
	EditTemplate.AbilityShooterEffects.length = 0;
}