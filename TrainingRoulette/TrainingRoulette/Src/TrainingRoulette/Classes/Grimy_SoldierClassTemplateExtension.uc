class Grimy_SoldierClassTemplateExtension extends X2SoldierClassTemplate;

static function SetSoldierRanks(X2SoldierClassTemplate ClassTemplate, array<SoldierClassRank> NewSoldierRanks) {
	local SoldierClassRank RankIndex;
	ClassTemplate.SoldierRanks.length = 0;
	foreach NewSoldierRanks(RankIndex) {
		ClassTemplate.SoldierRanks.additem(RankIndex);
	}
}