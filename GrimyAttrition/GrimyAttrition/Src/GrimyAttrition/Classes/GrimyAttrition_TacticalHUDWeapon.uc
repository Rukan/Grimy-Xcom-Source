class GrimyAttrition_TacticalHUDWeapon extends UITacticalHUD_Weapon config(GrimyAttrition);

var UIText ReserveText;
var UIIcon ReserveIcon;
var config bool EnableReserveIcon;
var config int Icon_Offset_X, Icon_Offset_Y;

simulated function SetWeaponAndAmmo( XComGameState_Item kWeapon )
{
	//If it's an overheating-type of weapon
	if ( (kWeapon != none) && kWeapon.ShouldDisplayWeaponAndAmmo() )
	{
		// Display the Weapon and Ammo if the weapon exists AND the template allows it to be displayed
		Show();

		m_kWeapon = kWeapon;
		AS_X2SetWeapon(kWeapon.GetWeaponPanelImages());
		if(m_kWeapon.HasInfiniteAmmo())
		{
			AS_X2SetAmmo(1, 1, 0, false);
		}
		else
		{
			AS_X2SetAmmo(kWeapon.Ammo, kWeapon.GetClipSize(), GetPotentialAmmoCost(), true);
		}
	}
	else
	{
		Hide();

		AS_X2SetWeapon();
		AS_X2SetAmmo(0, 0, 0, false);
	}
	UpdateReserveWillIcons( m_kWeapon );
}

function UpdateReserveWillIcons(XComGameState_Item WeaponState) {
	local XComGameState_Unit UnitState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(WeaponState.OwnerStateObject.ObjectID));

	if ( default.EnableReserveIcon ) {
		if ( ReserveText == none ) {
			ReserveText = Spawn(class'UIText', Self).InitText('GrimyReserveText');
			ReserveText.AnchorBottomRight();
			ReserveText.SetX(default.Icon_Offset_X);
			ReserveText.SetY(default.Icon_Offset_Y);
			ReserveText.SetColor("9acbcb");
		}
		ReserveText.SetText( class'UIUtilities_Text'.static.GetSizedText(string(XComGameState_Ability(History.GetGameStateForObjectID(UnitState.FindAbility('reload',WeaponState.GetReference()).ObjectID)).iCharges ),28) );

		if ( ReserveIcon == none ) {
			ReserveIcon = Spawn(class'UIIcon', Self).InitIcon('GrimyReserveIcon',"img:///GrimyAttritionPackage.Ammo_Icons",false,false,32);
			Reserveicon.AnchorBottomRight();
			ReserveIcon.SetX(default.Icon_Offset_X-35);
			ReserveIcon.SetY(default.Icon_Offset_Y);
		}
	}
	/*
	if ( default.EnableWillIcon ) {
		if ( WillText == none ) {
			WillText = Spawn(class'UIText', Self).InitText('GrimyWillText');
			WillText.AnchorBottomRight();
			WillText.SetX(default.Icon_Offset_X-100);
			WillText.SetY(default.Icon_Offset_Y);
			WillText.SetColor("bf1e2e");
		}
		WillText.SetText(int(UnitState.GetCurrentStat(eStat_Will)) $ "/" $ int(UnitState.GetMaxStat(eStat_Will)) );

		if ( WillIcon == none ) {
			WillIcon = Spawn(class'UIIcon', Self).InitIcon('GrimyWillIcon',"img:///UILibrary_Common.Implants_will",false,false,25);
			WillIcon.AnchorBottomRight();
			WillIcon.SetX(default.Icon_Offset_X-30);
			WillIcon.SetY(default.Icon_Offset_Y-30);
		}
	}*/
}