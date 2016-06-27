class GrimyClassAN_HeavyAbilitySet extends X2Ability_HeavyWeapons;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Flamethrower('GrimyFlamethrower'));

	return Templates;
}