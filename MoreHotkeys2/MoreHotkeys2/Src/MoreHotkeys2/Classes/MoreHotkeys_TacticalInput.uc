class MoreHotkeys_TacticalInput extends XComTacticalInput;

var MoreHotkeys_ItemCard			F1ItemCard;
var UITextContainer					AbilityText, StatText;
var UIText							StatValues;

var localized string kAbilityHeader, kStatsHeader;
var localized array<string> kStatLabels;

function CacheUI(UITacticalHUD HUD) {
	if ( StatText == none ) {
		StatText = HUD.Spawn(class'UITextContainer', HUD);
		StatText.InitTextContainer('F1Stats',,,,240,650,true);
	}

	if ( StatValues == none ) {
		StatValues = StatText.Spawn(class'UIText', StatText);
		StatValues.InitText('F1StatValues');
	}
		
	if ( AbilityText == none ) {
		AbilityText = HUD.Spawn(class'UITextContainer', HUD);
		AbilityText.InitTextContainer('F1Abilities',,,,800,650,true);
	}

	if ( F1ItemCard == none ) {
		F1ItemCard = HUD.Spawn(class'MoreHotkeys_ItemCard',HUD);
		F1ItemCard.InitItemCard();
	}	
}

exec function ShowEnemyAbilities() {
	local XComPresentationLayer Pres;
	local UITacticalHUD HUD;
	local AvailableAction SelectedUIAction;
	local X2TargetingMethod TargetingMethod;
	local int TargetIndex;
	local XComGameState_Unit TargetUnit;
	local XComGameState_Item ItemState;

	Pres = `PRES;
	HUD = Pres.GetTacticalHUD();
	if (HUD == none)
		return;
	
	TargetingMethod = HUD.GetTargetingMethod();
	if( TargetingMethod != None )
	{
		SelectedUIAction = HUD.GetSelectedAction();
		TargetIndex = TargetingMethod.GetTargetIndex();
		if( SelectedUIAction.AvailableTargets.Length > 0 && TargetIndex < SelectedUIAction.AvailableTargets.Length ) {
			TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(SelectedUIAction.AvailableTargets[TargetIndex].PrimaryTarget.ObjectID));
		}
	}
	
	if ( TargetUnit == none ) {
		TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(XComTacticalController(HUD.PC).GetActiveUnitStateRef().ObjectID));
	}
	
	if ( TargetUnit != none ) {
		ItemState = TargetUnit.GetPrimaryWeapon();
		if ( ItemState == none )
			ItemState = TargetUnit.GetSecondaryWeapon();

		CacheUI(HUD);

		GetStatValues(TargetUnit);
		StatText.AnchorCenter();
		StatText.SetPosition(-815,-420);
		StatText.Show();
		StatValues.SetPosition(168,8);
		StatValues.Show();

		AbilityText.SetText(GetAbilityString(TargetUnit));
		AbilityText.AnchorCenter();
		AbilityText.SetPosition(-515,-420);
		AbilityText.Show();
		
		F1ItemCard.SetSize(805,805);
		F1ItemCard.AnchorCenter();
		F1ItemCard.SetPosition(345,-420);
		F1ItemCard.PopulateItemCard(ItemState.GetMyTemplate(), ItemState.GetReference());
		F1ItemCard.Show();
	}
}

function string GetAbilityString(XComGameState_Unit kGameStateUnit) {
	local string RetString;

	local XComGameStateHistory		History;
	local StateObjectReference		AbilityRef;
	local XComGameState_Ability		AbilityState;
	local X2AbilityTemplate			AbilityTemplate;

	History = `XCOMHISTORY;
	foreach kGameStateUnit.Abilities(AbilityRef) {

		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
		AbilityTemplate = AbilityState.GetMyTemplate();
		if ( !AbilityTemplate.bDontDisplayInAbilitySummary ) {
			if ( AbilityTemplate.LocFriendlyName != "" ) {
				RetString = RetString $ class'UIUtilities_Colors'.static.ColorString(AbilityTemplate.LocFriendlyName,MakeColor(83,180,94,0)) $ "\n";
				RetString = RetString $ AbilityTemplate.LocHelpText $ "\n";
			}
		}
	}
	RetString = class'UIUtilities_Text'.static.GetSizedText(RetString,20);
	RetString = kGameStateUnit.GetFullName() $ default.kAbilityHeader $ "\n" $ RetString $ "\n";
	return RetString;
}

function GetStatValues(XComGameState_Unit kGameStateUnit) {
	local string ValueString, LabelString;
	local int BaseStat, CurrentStat;

	LabelString = kGameStateUnit.GetFullName() $ default.kStatsHeader $ "\n"; 

	LabelString = LabelString $ default.kStatLabels[0] $ "\n";
	BaseStat = kGameStateUnit.GetMaxStat(eStat_HP);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_HP);
	ValueString = "\n" $ class'UIUtilities_Colors'.static.ColorString(CurrentStat $ "/" $ BaseStat, ColorHP(CurrentStat, BaseStat)) $ "\n"; 

	BaseStat = kGameStateUnit.GetBaseStat(eStat_ShieldHP);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_ShieldHP);
	if ( CurrentStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[1] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}

	BaseStat = kGameStateUnit.GetBaseStat(eStat_ArmorMitigation);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_ArmorMitigation);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[2] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
		
		BaseStat = kGameStateUnit.GetBaseStat(eStat_ArmorChance);
		CurrentStat = kGameStateUnit.GetCurrentStat(eStat_ArmorChance);
		if ( CurrentStat < 100 || BaseStat < 100 ) {
			LabelString = LabelString $ default.kStatLabels[3] $ "\n";
			ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
		}
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Defense);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_Defense);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[4] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
		
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Dodge);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[5] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, kGameStateUnit.GetCurrentStat(eStat_Dodge)) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Mobility);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_Mobility);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[6] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Offense);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_Offense);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[7] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_CritChance);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_CritChance);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[8] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_FlankingAimBonus);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_FlankingAimBonus);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[9] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_FlankingCritChance);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_FlankingCritChance);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[10] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_ArmorPiercing);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_ArmorPiercing);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[11] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_PsiOffense);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_PsiOffense);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[12] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Will);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_Will);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[13] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Hacking);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_Hacking);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[14] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_HackDefense);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_HackDefense);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[15] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_DetectionRadius);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_DetectionRadius);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[16] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_SightRadius);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_SightRadius);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[17] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}
	
	BaseStat = kGameStateUnit.GetBaseStat(eStat_Strength);
	CurrentStat = kGameStateUnit.GetCurrentStat(eStat_Strength);
	if ( CurrentStat > 0 || BaseStat > 0 ) {
		LabelString = LabelString $ default.kStatLabels[18] $ "\n";
		ValueString = ValueString $ ColorAndStringForStats(BaseStat, CurrentStat) $ "\n";
	}

	StatText.SetText(LabelString);
	StatValues.SetText(ValueString);
}

exec function HideEnemyAbilities() {
	F1ItemCard.Hide();
	StatText.Hide();
	AbilityText.Hide();
}

exec function CallAbility(name AbilityName, optional bool QuickCast = false) {
	local UITacticalHUD TacticalHUD;
	local int AbilityIndex;
	
	TacticalHUD = XComPresentationLayer(XComTacticalController(Outer).Pres).GetTacticalHUD();
	AbilityIndex = TacticalHUD.m_kAbilityHUD.GetAbilityIndexByName(AbilityName);
	if (AbilityIndex == INDEX_NONE) {
		PlaySound( SoundCue'SoundUI.NegativeSelection2Cue', true , true );
		return;
	}

	if ( QuickCast || TacticalHUD.m_kAbilityHUD.GetSelectedIndex() == AbilityIndex ) {
		TacticalHUD.m_kAbilityHUD.DirectConfirmAbility(AbilityIndex, true);
	}
	else {
		TacticalHUD.m_kAbilityHUD.DirectSelectAbility(AbilityIndex);
	}
}

exec function CallHiddenAbilityOnSelf(name AbilityName, optional int WeaponType = 0) {
	local UITacticalHUD TacticalHUD;
	local XComGameStateHistory History;
	local XComGameState_Unit ActiveUnit;
	local StateObjectReference AbilityRef;
	local XComGameState_Ability AbilityState;
	local XComGameStateContext_Ability AbilityContext;
	local string                        ConfirmSound;
	
	History = `XCOMHISTORY;
	TacticalHUD = XComPresentationLayer(XComTacticalController(Outer).Pres).GetTacticalHUD();
	ActiveUnit = XComGameState_Unit(History.GetGameStateForObjectID(XComTacticalController(TacticalHUD.m_kAbilityHUD.PC).GetActiveUnitStateRef().ObjectID));

	Switch ( WeaponType ) {
		case 1:
			AbilityRef = ActiveUnit.FindAbility(AbilityName, ActiveUnit.GetPrimaryWeapon().GetReference());
			break;
		case 2:
			AbilityRef = ActiveUnit.FindAbility(AbilityName, ActiveUnit.GetSecondaryWeapon().GetReference());
			break;
		default:
			AbilityRef = ActiveUnit.FindAbility(AbilityName);
	}
	if ( AbilityRef.ObjectId > 0 ) { 
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
		if ( AbilityState != none ) {
			if (AbilityState.CanActivateAbilityForObserverEvent(ActiveUnit) == 'AA_Success') {
				AbilityContext = class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, ActiveUnit.ObjectID);
				if( AbilityContext.Validate() ) {
					`TACTICALRULES.SubmitGameStateContext(AbilityContext);
					ConfirmSound = AbilityState.GetMyTemplate().AbilityConfirmSound;
					if (ConfirmSound != "")
						`SOUNDMGR.PlaySoundEvent(ConfirmSound);
					return;
				}
			}
		}
	}
	//PlaySound( SoundCue'SoundUI.NegativeSelection2Cue', true , true );
}

exec function GrimyTriggerEvent(name EventName) {
	`XEVENTMGR.TriggerEvent(EventName);
}

exec function ZoomCameras(float ZoomAmount) {
	`CAMERASTACK.ZoomCameras(ZoomAmount);
}

exec function YawCameras(float Degrees) {
	`CAMERASTACK.YawCameras(Degrees);
}

exec function PitchCameras(float Degrees) {
	`CAMERASTACK.PitchCameras(Degrees);
}

exec function AscendFloor() {
	if ( !AbilityText.bIsVisible )
		XComTacticalController(Outer).GetCursor().AscendFloor();
}

exec function DescendFloor() {
	if ( !AbilityText.bIsVisible )
		XComTacticalController(Outer).GetCursor().DescendFloor();
}

function string ColorAndStringForStats(int statbase, int statcurrent) 
{
	local Color Tcolor;
	local string CText;

	CText = "(" $ StatChange(statbase, statcurrent) $ ")"; 
	
	if ((statbase - statcurrent) == 0) 
		return string(statbase);

	Tcolor = StatChangeColor(statbase, statcurrent);

	return (statbase $ " " $ class'UIUtilities_Colors'.static.ColorString(CText, Tcolor));
} 

function string StatChange(int statbase, int statcurrent)  
{
	if (statbase > statcurrent) 
		return "-" $ (statbase - statcurrent);

	else
		return "+" $ (statcurrent - statbase);
}

function Color ColorHP(float CurrentHP, float MaxHP) 
{

	if (CurrentHP/MaxHP > 0.66) 
		return MakeColor(83,180,94,0);

	else if (CurrentHP/MaxHP < 0.33) 
		return MakeColor(191,30,46,0);

	else 
		return MakeColor(200,100,0,0);
}

function Color StatChangeColor(Float BaseStat, Float CurrentStat)
{
	if (BaseStat > CurrentStat) 
		return MakeColor(191,30,46,0);

	else 
		return MakeColor(83,180,94,0);

}