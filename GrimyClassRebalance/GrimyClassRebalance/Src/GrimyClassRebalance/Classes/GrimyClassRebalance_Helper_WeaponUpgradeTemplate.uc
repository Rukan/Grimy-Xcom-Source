class GrimyClassRebalance_Helper_WeaponUpgradeTemplate extends X2ItemTemplate;

static function ReplaceBriefSummary(X2ItemTemplate Template, string RepString, string NewString) {
	Template.BriefSummary = Repl(Template.BriefSummary, RepString, NewString);
}