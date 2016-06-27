class LootIndicator extends UIUnitFlag
	dependson(XComGameState_Unit) config(LootIndicator);

var UIText HPText, ArmorText, ShieldText, AimText, MobilityText, DamageText, NameText;
var UIIcon LootIcon, AimIcon, MobilityIcon, HPIcon, DamageIcon;
var config bool SHOW_HP, SHOW_ARMOR, SHOW_SHIELD, SHOW_LOOT, SHOW_AIM, SHOW_MOBILITY, SHOW_DAMAGE, REQUIRE_SCANNING, SHOW_STATS_ON_FRIENDLY;
var config bool SHOW_FRIENDLY_NAME, SHOW_ENEMY_NAME;
var config int LOOT_OFFSET_X, LOOT_OFFSET_Y;
var config int HP_OFFSET_X, HP_OFFSET_Y;
var config int AIM_OFFSET_X, AIM_OFFSET_Y;
var config int MOBILITY_OFFSET_X, MOBILITY_OFFSET_Y;
var config int DAMAGE_OFFSET_X, DAMAGE_OFFSET_Y;
var config int NAME_OFFSET_X, NAME_OFFSET_Y, NAME_FONT_SIZE, INFO_FONT_SIZE;
var config int SHIELD_OFFSET_X, ARMOR_OFFSET_X;
var config string NAME_COLOR, STAT_COLOR, ARMOR_COLOR, SHIELD_COLOR;
var config int SHIELD_SHIFT_Y, ALIENRULER_SHIFT_Y;

simulated function SetHitPoints( int _currentHP, int _maxHP )
{
	local ASValue myValue;
	local Array<ASValue> myArray;
	local int currentHP, maxHP, iMultiplier;
	local XComGameState_Unit UnitState;

	iMultiplier = `GAMECORE.HP_PER_TICK;

	if ( _currentHP < 1 )
	{
		m_bIsDead = true;
		Remove();
	}
	else
	{
		if( !m_bIsFriendly && !`XPROFILESETTINGS.Data.m_bShowEnemyHealth ) // Profile is set to hide enemy health 
		{			
			myValue.Type = AS_Number;
			myValue.n = 0;
			myArray.AddItem( myValue );
			myValue.n = 0;
			myArray.AddItem( myValue );
		}
		else
		{

			//Always round up for display when using the gamecore multiplier, per Jake's request. 
			if( iMultiplier > 0 )
			{
				currentHP = FCeil(float(_currentHP) / float(iMultiplier)); 
				maxHP = FCeil(float(_maxHP) / float(iMultiplier)); 
			}
		
			myValue.Type = AS_Number;
			myValue.n = currentHP;
			myArray.AddItem( myValue );
			myValue.n = maxHP;
			myArray.AddItem( myValue );

			// NEW CODE STARTS HERE

			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(StoredObjectID));

			if ( default.SHOW_LOOT && !m_bIsFriendly && ( !REQUIRE_SCANNING || UnitState.IsUnitAffectedByEffectName('ScanningProtocol') ) )
			{
				if ( LootIcon == none )
				{
					LootIcon = Spawn(class'UIIcon', self).InitIcon('GrimyLootIcon',"img:///GrimyPackage.Grimy_Loot",false,false,default.INFO_FONT_SIZE);
					LootIcon.SetX(default.LOOT_OFFSET_X);
					LootIcon.SetY(default.LOOT_OFFSET_Y + GetShieldShift());
					LootIcon.Hide();
				}
				if ( LootIcon != none && UnitState.PendingLoot.LootToBeCreated.Length > 0 )
				{
					LootIcon.Show();
				}
				else
				{
					LootIcon.Hide();
				}
			}

			if ( default.SHOW_DAMAGE )
			{
				if ( !m_bIsFriendly || default.SHOW_STATS_ON_FRIENDLY )
				{
					if ( DamageIcon == none )
					{
						DamageIcon = Spawn(class'UIIcon', self).InitIcon('GrimyDamageIcon',"img:///GrimyPackage.Grimy_Bullet",false,false,default.INFO_FONT_SIZE);
						DamageIcon.SetX(default.DAMAGE_OFFSET_X);
						DamageIcon.SetY(default.DAMAGE_OFFSET_Y + GetShieldShift());
					}
					if ( DamageText == none ) {
						DamageText = Spawn(class'UIText', self).InitText('GrimyDamageText');
						DamageText.SetX(default.DAMAGE_OFFSET_X+25);
						DamageText.SetY(default.DAMAGE_OFFSET_Y + GetShieldShift());
						DamageText.SetColor(default.STAT_COLOR);
					}
					if ( DamageText != none  && X2WeaponTemplate(UnitState.GetPrimaryWeapon().GetMyTemplate()) != none ) {
						DamageText.SetText(GetDamageString( X2WeaponTemplate(UnitState.GetPrimaryWeapon().GetMyTemplate()) ));
					}
				}
			}

			if ( default.SHOW_AIM )
			{
				if ( !m_bIsFriendly || default.SHOW_STATS_ON_FRIENDLY)
				{
					if ( AimIcon == none )
					{
						AimIcon = Spawn(class'UIIcon', self).InitIcon('GrimyAimIcon',"img:///GrimyPackage.Grimy_Aim",false,false,default.INFO_FONT_SIZE);
						AimIcon.SetX(default.AIM_OFFSET_X);
						AimIcon.SetY(default.AIM_OFFSET_Y + GetShieldShift());
					}
					if ( AimText == none ) {
						AimText = Spawn(class'UIText', self).InitText('GrimyAimText');
						AimText.SetX(default.AIM_OFFSET_X+25);
						AimText.SetY(default.AIM_OFFSET_Y + GetShieldShift());
						AimText.SetColor(default.STAT_COLOR);
					}
					if ( AimText != none ) {
						AimText.SetText(string(int(UnitState.GetCurrentStat(eStat_Offense))));
					}
				}
			}

			if ( default.SHOW_MOBILITY )
			{
				if ( !m_bIsFriendly || default.SHOW_STATS_ON_FRIENDLY )
				{
					if ( MobilityIcon == none )
					{
						MobilityIcon = Spawn(class'UIIcon', self).InitIcon('GrimyMobilityIcon',"img:///GrimyPackage.Grimy_Mobility",false,false,default.INFO_FONT_SIZE);
						MobilityIcon.SetX(default.MOBILITY_OFFSET_X);
						MobilityIcon.SetY(default.MOBILITY_OFFSET_Y + GetShieldShift());
					}
					if ( MobilityText == none ) {
						MobilityText = Spawn(class'UIText', self).InitText('GrimyMobilityText');
						MobilityText.SetX(default.MOBILITY_OFFSET_X+25);
						MobilityText.SetY(default.MOBILITY_OFFSET_Y + GetShieldShift());
						MobilityText.SetColor(default.STAT_COLOR);
					}
					if ( MobilityText != none ) {
						MobilityText.SetText(string(int(UnitState.GetCurrentStat(eStat_Mobility))));
					}
				}
			}
			
			if ( default.SHOW_HP )
			{
				if ( !m_bIsFriendly || default.SHOW_STATS_ON_FRIENDLY )
				{
					if ( HPText == none ) {
						HPText = Spawn(class'UIText', self).InitText('GrimyHPText');
						HPText.SetColor(default.STAT_COLOR);
						HPText.SetX(default.HP_OFFSET_X+25);
						HPText.SetY(default.HP_OFFSET_Y + GetShieldShift());
					}
					if ( HPText != none ) {
						HPText.SetText(_currentHP $ "/" $ _maxHP);
					}
					if ( HPIcon == none ) {
						HPIcon = Spawn(class'UIIcon', self).InitIcon('GrimyHPIcon',"img:///GrimyPackage.Grimy_HP",false,false,default.INFO_FONT_SIZE);
						HPIcon.SetX(default.HP_OFFSET_X);
						HPIcon.SetY(default.HP_OFFSET_Y + GetShieldShift());
					}
				}
			}
			// NEW CODE ENDS HERE
		}
		Invoke("SetHitPoints", myArray);
	}
}

simulated function SetShieldPoints( int _currentShields, int _maxShields )
{
	local ASValue myValue;
	local Array<ASValue> myArray;
	local int currentShields, maxShields, iMultiplier;

	iMultiplier = `GAMECORE.HP_PER_TICK;

	if( !m_bIsFriendly && !`XPROFILESETTINGS.Data.m_bShowEnemyHealth ) // Profile is set to hide enemy health 
	{			
		myValue.Type = AS_Number;
		myValue.n = 0;
		myArray.AddItem( myValue );
		myValue.n = 0;
		myArray.AddItem( myValue );
	}
	else
	{
		//Always round up for display when using the gamecore multiplier, per Jake's request. 
		if( iMultiplier > 0 )
		{
			currentShields = FCeil(float(_currentShields) / float(iMultiplier));
			maxShields = FCeil(float(_maxShields) / float(iMultiplier));
		}
	
		myValue.Type = AS_Number;
		myValue.n = currentShields;
		myArray.AddItem( myValue );
		myValue.n = maxShields;
		myArray.AddItem( myValue );
	}
	
	// START OF NEW CODE
	if ( default.SHOW_SHIELD )
	{
		if ( ShieldText == none ) {
			ShieldText = Spawn(class'UIText', self).InitText('GrimyShieldText');
			ShieldText.SetColor(default.SHIELD_COLOR);
			ShieldText.SetX(default.HP_OFFSET_X + default.SHIELD_OFFSET_X);
			ShieldText.SetY(default.HP_OFFSET_Y);
		}

		if ( _currentShields > 0 )
			ShieldText.SetText(string(_currentShields));
		else
			ShieldText.SetText("");
	}

	if ( LootIcon != none ) { LootIcon.SetY(default.LOOT_OFFSET_Y + GetShieldShift()); }
	if ( DamageIcon != none ) { DamageIcon.SetY(default.DAMAGE_OFFSET_Y + GetShieldShift()); }
	if ( DamageText != none ) { DamageText.SetY(default.DAMAGE_OFFSET_Y + GetShieldShift()); }
	if ( AimIcon != none ) { AimIcon.SetY(default.AIM_OFFSET_Y + GetShieldShift()); }
	if ( AimText != none ) { AimText.SetY(default.AIM_OFFSET_Y + GetShieldShift()); }
	if ( MobilityIcon != none ) { MobilityIcon.SetY(default.MOBILITY_OFFSET_Y + GetShieldShift()); }
	if ( MobilityText != none ) { MobilityText.SetY(default.MOBILITY_OFFSET_Y + GetShieldShift()); }
	if ( HPText != none ) { HPText.SetY(default.HP_OFFSET_Y + GetShieldShift()); }
	if ( HPIcon != none ) { HPIcon.SetY(default.HP_OFFSET_Y + GetShieldShift()); }
	if ( ArmorText != none ) { ArmorText.SetY(default.HP_OFFSET_Y); }
	if ( NameText != none ) { NameText.SetY(default.NAME_OFFSET_Y + GetShieldShift()); }
	// END OF NEW CODE

	Invoke("SetShieldPoints", myArray);

	// Disable hitpoints preview visualization - sbatista 6/24/2013
	SetShieldPointsPreview();
}

simulated function SetArmorPoints(optional int _iArmor = 0)
{
	local ASValue myValue;
	local Array<ASValue> myArray;
	local int currentArmor, iMultiplier;

	iMultiplier = `GAMECORE.HP_PER_TICK;

	if( m_bIsFriendly ||`XPROFILESETTINGS.Data.m_bShowEnemyHealth ) 
	{			
		//Always round up for display when using the gamecore multiplier, per Jake's request. 
		if( iMultiplier > 0 )
		{
			currentArmor = FCeil(float(_iArmor) / float(iMultiplier));
		}
	
		myValue.Type = AS_Number;
		myValue.n = currentArmor;
		myArray.AddItem( myValue );	
	
		// START OF NEW CODE
		if ( default.SHOW_ARMOR )
		{
			if ( ArmorText == none ) {
				ArmorText = Spawn(class'UIText', self).InitText('GrimyArmorText');
				ArmorText.SetColor(default.ARMOR_COLOR);
				ArmorText.SetX(default.HP_OFFSET_X + default.ARMOR_OFFSET_X);
				ArmorText.SetY(default.HP_OFFSET_Y);
			}

			if ( _iArmor > 0 )
				ArmorText.SetText(string(_iArmor));
			else
				ArmorText.SetText("");
		}
		// END OF NEW CODE
		
		Invoke("ClearAllArmor");
		Invoke("SetArmor", myArray);
	}
	else
	{
		Invoke("ClearAllArmor"); // we dont want to show enemy healthbars so clear armor pips
	}
}

function string GetDamageString(X2WeaponTemplate WeaponTemplate)
{
	local int minDamage, maxDamage;

	minDamage = WeaponTemplate.BaseDamage.Damage - WeaponTemplate.BaseDamage.Spread;
	maxDamage = WeaponTemplate.BaseDamage.Damage + WeaponTemplate.BaseDamage.Spread;
	if ( WeaponTemplate.BaseDamage.PlusOne > 0 )
	{
		maxDamage++;
	}

	return minDamage $ "-" $ maxDamage;
}

function int GetShieldShift() {
	local XComGameState_Unit UnitState;
	local int Shift;

	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(StoredObjectID));
	Shift = 0;
	if ( UnitState.GetCurrentStat( eStat_ShieldHP ) > 0 ) {
		Shift += default.SHIELD_SHIFT_Y;
	}
	if ( UnitState.GetMyTemplateName() == 'ViperKing' ) {
		Shift += default.ALIENRULER_SHIFT_Y * 2;
	}
	else if ( UnitState.GetMyTemplateName() == 'ArchonKing' || UnitState.GetMyTemplateName() == 'BerserkerQueen' ) {
		Shift += default.ALIENRULER_SHIFT_Y * 3;
	}

	return Shift;
}

simulated function SetNames( string unitName, string unitNickName )
{
	local string ThisName;
	
	if ( unitNickName != "" ) { ThisName = unitNickName; }
	else { ThisName = unitName; }

	if ( ( default.SHOW_FRIENDLY_NAME && m_bIsFriendly ) || ( default.SHOW_ENEMY_NAME && !m_bIsFriendly ) )
	{
		if ( NameText == none ) {
			NameText = Spawn(class'UIText', self).InitText('GrimyNameText');
			NameText.SetColor(default.NAME_COLOR);
			NameText.SetText(class'UIUtilities_Text'.static.AddFontInfo(ThisName,false,false,false,default.NAME_FONT_SIZE));
			NameText.SetX(default.NAME_OFFSET_X);
			NameText.SetY(default.NAME_OFFSET_Y + GetShieldShift());
		}
	}
}