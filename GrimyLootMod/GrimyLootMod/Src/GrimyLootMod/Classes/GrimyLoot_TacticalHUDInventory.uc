class GrimyLoot_TacticalHUDInventory extends UITacticalHUD_Inventory;

public function Update( optional bool bForceUpdate = false )
{
	local XGUnit		kActiveUnit;
	local XComGameState_Unit kGameStateUnit;
	local XComGameState_Item kPrimaryWeapon;
	local string WeaponName;

	// If not shown or ready, leave.
	if( !bIsInited )
		return;
	
	// Only update if new unit
	kActiveUnit = XComTacticalController(PC).GetActiveUnit();
	if( kActiveUnit == none )
	{
		Hide();
	} 
	else if( bForceUpdate || (kActiveUnit != none && kActiveUnit != m_kCurrentUnit) )
	{
		m_kCurrentUnit = kActiveUnit;
		
		kGameStateUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kActiveUnit.ObjectID));
		kPrimaryWeapon = kGameStateUnit.GetPrimaryWeapon();

		if( kPrimaryWeapon != none && kPrimaryWeapon.ShouldDisplayWeaponAndAmmo() )
		{
			m_kWeapon.SetWeaponAndAmmo(kPrimaryWeapon);
			WeaponName = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(kPrimaryWeapon.GetMyTemplate().GetItemFriendlyName(kPrimaryWeapon.ObjectID));
			WeaponName = Repl(WeaponName,"</b></font>","");
			WeaponName = Split(WeaponName,"<B>",true);
			AS_SetWeaponName(WeaponName);
			//AS_SetWeaponName(class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(kPrimaryWeapon.GetMyTemplate().GetItemFriendlyName(kPrimaryWeapon.ObjectID)));
			Show();
		}
		else
		{
			AS_SetWeaponName("");
			Hide();
		}
	}
	
	Movie.Pres.m_kTooltipMgr.ForceUpdateByPartialPath( string(MCPath) );
}