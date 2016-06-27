class GrimyClassHH_Effect_BonusPointBlank extends X2Effect_Persistent;

var name AbilityName;
var int AimBonus;
var int CritBonus;
var float DamageBonus;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ModInfo;
	local XComGameState_Item SourceWeapon;
	
	if (AbilityState.GetMyTemplateName() != AbilityName) { return; }

	SourceWeapon = AbilityState.GetSourceWeapon();
	if ( SourceWeapon == none ) { return; }
	if ( SourceWeapon.InventorySlot != eInvSlot_PrimaryWeapon ) { return; }

	ModInfo.ModType = eHit_Success;
	ModInfo.Reason = FriendlyName;
	ModInfo.Value = AimBonus;
	ShotModifiers.AddItem(ModInfo);
		
	ModInfo.ModType = eHit_Crit;
	ModInfo.Reason = FriendlyName;
	ModInfo.Value = CritBonus;
	ShotModifiers.AddItem(ModInfo);
}

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (AbilityState.GetMyTemplateName() != AbilityName) { return 0; }
	return CurrentDamage * DamageBonus;
}