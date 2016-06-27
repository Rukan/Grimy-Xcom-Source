class GrimyUITweaks extends UITacticalHUD_ShotHUD config(GrimyUITweaks);

var UIBGBox GrimyBox1, GrimyBox2, GrimyBox3, GrimyBox4;
var config int BAR_HEIGHT, BAR_OFFSET_X, BAR_OFFSET_Y, BAR_ALPHA;
var config string HIT_COLOR, CRIT_COLOR, DODGE_COLOR, MISS_COLOR;
var config bool EXCESS_AIM_MOD, PREVIEW_MINIMUM, SHOW_DODGE_PERCENT;

simulated function Update()
{
	local bool isValidShot;
	local string ShotName, ShotDescription, ShotDamage;
	local int HitChance, CritChance, TargetIndex, MinDamage, MaxDamage, AllowsShield;
	local ShotBreakdown kBreakdown;
	local StateObjectReference Shooter, Target, EmptyRef; 
	local XComGameState_Ability SelectedAbilityState;
	local X2AbilityTemplate SelectedAbilityTemplate;
	local AvailableAction SelectedUIAction;
	local AvailableTarget kTarget;
	local XGUnit ActionUnit;
	local UITacticalHUD TacticalHUD;
	local UIUnitFlag UnitFlag; 
	local WeaponDamageValue MinDamageValue, MaxDamageValue;
	local X2TargetingMethod TargetingMethod;
	local bool WillBreakConcealment, WillEndTurn;
	
	// New from Grimy Shot Bar
	local int GrimyHitChance, GrimyCritChance, GrimyDodgeChance; 
	local int GrimyHitWidth, GrimyCritWidth, GrimyDodgeWidth, GrimyMissWidth;

	TacticalHUD = UITacticalHUD(Screen);

	SelectedUIAction = TacticalHUD.GetSelectedAction();
	if (SelectedUIAction.AbilityObjectRef.ObjectID > 0) //If we do not have a valid action selected, ignore this update request
	{
		SelectedAbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(SelectedUIAction.AbilityObjectRef.ObjectID));
		SelectedAbilityTemplate = SelectedAbilityState.GetMyTemplate();
		ActionUnit = XGUnit(`XCOMHISTORY.GetGameStateForObjectID(SelectedAbilityState.OwnerStateObject.ObjectID).GetVisualizer());
		TargetingMethod = TacticalHUD.GetTargetingMethod();
		if( TargetingMethod != None )
		{
			TargetIndex = TargetingMethod.GetTargetIndex();
			if( SelectedUIAction.AvailableTargets.Length > 0 && TargetIndex < SelectedUIAction.AvailableTargets.Length )
				kTarget = SelectedUIAction.AvailableTargets[TargetIndex];
		}

		//Update L3 help and OK button based on ability.
		//*********************************************************************************
		if (SelectedUIAction.bFreeAim)
		{
			AS_SetButtonVisibility(Movie.IsMouseActive(), false);
			isValidShot = true;
		}
		else if (SelectedUIAction.AvailableTargets.Length == 0 || SelectedUIAction.AvailableTargets[0].PrimaryTarget.ObjectID < 1)
		{
			AS_SetButtonVisibility(Movie.IsMouseActive(), false);
			isValidShot = false;
		}
		else
		{
			AS_SetButtonVisibility(Movie.IsMouseActive(), Movie.IsMouseActive());
			isValidShot = true;
		}

		//Set shot name / help text
		//*********************************************************************************
		ShotName = SelectedAbilityState.GetMyFriendlyName();

		if (SelectedUIAction.AvailableCode == 'AA_Success')
		{
			ShotDescription = SelectedAbilityState.GetMyHelpText();
			if (ShotDescription == "") ShotDescription = "Missing 'LocHelpText' from ability template.";
		}
		else
		{
			ShotDescription = class'X2AbilityTemplateManager'.static.GetDisplayStringForAvailabilityCode(SelectedUIAction.AvailableCode);
		}


		WillBreakConcealment = SelectedAbilityState.MayBreakConcealmentOnActivation();
		WillEndTurn = SelectedAbilityState.WillEndTurn();

		AS_SetShotInfo(ShotName, ShotDescription, WillBreakConcealment, WillEndTurn);

		// Disable Shot Button if we don't have a valid target.
		AS_SetShotButtonDisabled(!isValidShot);

		ResetDamageBreakdown();

		// In the rare case that this ability is self-targeting, but has a multi-target effect on units around it,
		// look at the damage preview, just not against the target (self).
		if( SelectedAbilityTemplate.AbilityTargetStyle.IsA('X2AbilityTarget_Self')
		   && SelectedAbilityTemplate.AbilityMultiTargetStyle != none 
		   && SelectedAbilityTemplate.AbilityMultiTargetEffects.Length > 0 )
		{
			SelectedAbilityState.GetDamagePreview(EmptyRef, MinDamageValue, MaxDamageValue, AllowsShield);
		}
		else
		{
			SelectedAbilityState.GetDamagePreview(kTarget.PrimaryTarget, MinDamageValue, MaxDamageValue, AllowsShield);
		}
		MinDamage = MinDamageValue.Damage;
		MaxDamage = MaxDamageValue.Damage;
		
		if (MinDamage > 0 && MaxDamage > 0)
		{
			if (MinDamage == MaxDamage)
				ShotDamage = String(MinDamage);
			else
				ShotDamage = MinDamage $ "-" $ MaxDamage;

			AddDamage(class'UIUtilities_Text'.static.GetColoredText(ShotDamage, eUIState_Good, 36), true);
		}

		//Set up percent to hit / crit values 
		//*********************************************************************************

		if (SelectedAbilityTemplate.AbilityToHitCalc != none && SelectedAbilityState.iCooldown == 0)
		{
			Shooter = SelectedAbilityState.OwnerStateObject;
			Target = kTarget.PrimaryTarget;

			SelectedAbilityState.LookupShotBreakdown(Shooter, Target, SelectedAbilityState.GetReference(), kBreakdown);
			HitChance = Clamp(((kBreakdown.bIsMultishot) ? kBreakdown.MultiShotHitChance : kBreakdown.FinalHitChance), 0, 100);
			CritChance = kBreakdown.ResultTable[eHit_Crit];
			
			if ( GrimyBox1 != none )
			{
				GrimyBox1.Remove();
			}
			if ( GrimyBox2 != none )
			{
				GrimyBox2.Remove();
			}
			if ( GrimyBox3 != none )
			{
				GrimyBox3.Remove();
			}
			if ( GrimyBox4 != none )
			{
				GrimyBox4.Remove();
			}

			if (HitChance > -1 && !kBreakdown.HideShotBreakdown)
			{
				// GRIMY SHOT BAR GOES HERE
				GrimyHitChance = ((kBreakdown.bIsMultishot) ? kBreakdown.MultiShotHitChance : kBreakdown.FinalHitChance);
				GrimyCritChance = kBreakdown.ResultTable[eHit_Crit];
				GrimyDodgeChance = kBreakdown.ResultTable[eHit_Graze];
			
				if ( !default.EXCESS_AIM_MOD && (GrimyHitChance - GrimyDodgeChance > 100) )
				{
					GrimyCritChance -= (GrimyHitChance - GrimyDodgeChance - 100 );
				}
				if ( GrimyHitChance > 100 )
				{
					GrimyDodgeChance = clamp(GrimyDodgeChance - (GrimyHitChance - 100),0,100);
				}
				GrimyCritChance = clamp(GrimyCritChance,0,100-GrimyDodgeChance);

				if ( default.SHOW_DODGE_PERCENT && GrimyDodgeChance > 0 )
				{
					AS_SetShotInfo(ShotName, "Dodge: "$string(GrimyDodgeChance)$"%", WillBreakConcealment, WillEndTurn);
				}

				GrimyHitWidth = clamp( 5 * (GrimyHitChance - GrimyCritChance - GrimyDodgeChance), 0, 500 );
				GrimyCritWidth = 5 * GrimyCritChance;
				GrimyDodgeWidth = 5 * GrimyDodgeChance;
				GrimyMissWidth = 500 - 5 * HitChance;

				if ( default.BAR_HEIGHT > 0 )
				{
					if ( GrimyHitWidth > 0 )
					{
						GrimyBox1 = Spawn(class'UIBGBox', self);
						GrimyBox1.InitBG('GrimyBox1').SetBGColor(HIT_COLOR);
						GrimyBox1.SetHighlighed(true);
						GrimyBox1.AnchorCenter();
						GrimyBox1.SetAlpha(default.BAR_ALPHA);
						GrimyBox1.SetPosition(default.BAR_OFFSET_X,default.BAR_OFFSET_Y);
						GrimyBox1.SetSize(GrimyHitWidth,default.BAR_HEIGHT);
					}

					if ( GrimyCritWidth > 0 )
					{
						GrimyBox2 = Spawn(class'UIBGBox', self);
						GrimyBox2.InitBG('GrimyBox2').SetBGColor(CRIT_COLOR);
						GrimyBox2.SetHighlighed(true);
						GrimyBox2.AnchorCenter();
						GrimyBox2.SetAlpha(default.BAR_ALPHA);
						GrimyBox2.SetPosition(default.BAR_OFFSET_X + GrimyHitWidth,default.BAR_OFFSET_Y);
						GrimyBox2.SetSize(GrimyCritWidth,default.BAR_HEIGHT);
					}

					if ( GrimyDodgeWidth > 0 )
					{
						GrimyBox3 = Spawn(class'UIBGBox', self);
						GrimyBox3.InitBG('GrimyBox3').SetBGColor(DODGE_COLOR);
						GrimyBox3.SetHighlighed(true);
						GrimyBox3.AnchorCenter();
						GrimyBox3.SetAlpha(default.BAR_ALPHA);
						GrimyBox3.SetPosition(default.BAR_OFFSET_X + GrimyHitWidth + GrimyCritWidth,default.BAR_OFFSET_Y);
						GrimyBox3.SetSize(GrimyDodgeWidth,default.BAR_HEIGHT);
					}

					if ( GrimyMissWidth > 0 && GrimyMissWidth < 500 )
					{
						GrimyBox4 = Spawn(class'UIBGBox', self);
						GrimyBox4.InitBG('GrimyBox4').SetBGColor(MISS_COLOR);
						GrimyBox4.SetHighlighed(true);
						GrimyBox4.AnchorCenter();
						GrimyBox4.SetAlpha(default.BAR_ALPHA);
						GrimyBox4.SetPosition(default.BAR_OFFSET_X + GrimyHitWidth + GrimyCritWidth + GrimyDodgeWidth,default.BAR_OFFSET_Y);
						GrimyBox4.SetSize(GrimyMissWidth,default.BAR_HEIGHT);
					}
				}
				// End of Grimy Shot Bar

				AS_SetShotChance(class'UIUtilities_Text'.static.GetColoredText(m_sShotChanceLabel, eUIState_Header), HitChance);
				AS_SetCriticalChance(class'UIUtilities_Text'.static.GetColoredText(m_sCritChanceLabel, eUIState_Header), CritChance);
				TacticalHUD.SetReticleAimPercentages(float(HitChance) / 100.0f, float(CritChance) / 100.0f);
			}
			else
			{
				AS_SetShotChance("", -1);
				AS_SetCriticalChance("", -1);
				TacticalHUD.SetReticleAimPercentages(-1, -1);
			}
		}
		else
		{
			AS_SetShotChance("", -1);
			AS_SetCriticalChance("", -1);
		}
		TacticalHUD.m_kShotInfoWings.Show();
		
		UnitFlag = XComPresentationLayer(Owner.Owner).m_kUnitFlagManager.GetFlagForObjectID(Target.ObjectID);
		//Show preview points, must be negative
		if ( default.PREVIEW_MINIMUM )
		{
			if( UnitFlag != none )
			{
				SetAbilityMinDamagePreview(UnitFlag, SelectedAbilityState, kTarget.PrimaryTarget);
			}
		}
		else
		{
			if( UnitFlag != none )
			{
				XComPresentationLayer(Owner.Owner).m_kUnitFlagManager.SetAbilityDamagePreview(UnitFlag, SelectedAbilityState, kTarget.PrimaryTarget);
			}
		}

		//@TODO - jbouscher - ranges need to be implemented in a template friendly way.
		//Hide any current range meshes before we evaluate their visibility state
		if (!ActionUnit.GetPawn().RangeIndicator.HiddenGame)
		{
			ActionUnit.RemoveRanges();
		}
	}

	if (`REPLAY.bInTutorial)
	{
		if (SelectedAbilityTemplate != none && `TUTORIAL.IsNextAbility(SelectedAbilityTemplate.DataName) && `TUTORIAL.IsTarget(Target.ObjectID))
		{
			ShowShine();
		}
		else
		{
			HideShine();
		}
	}
}


// Altered Damage Preview Function
static function SetAbilityMinDamagePreview(UIUnitFlag kFlag, XComGameState_Ability AbilityState, StateObjectReference TargetObject)
{
    local XComGameState_Unit FlagUnit;
    local int shieldPoints, AllowedShield;
    local int possibleHPDamage, possibleShieldDamage;
    local WeaponDamageValue MinDamageValue;
    local WeaponDamageValue MaxDamageValue;
 
    if(kFlag == none || AbilityState == none)
    {
        return;
    }
 
    AbilityState.GetDamagePreview(TargetObject, MinDamageValue, MaxDamageValue, AllowedShield);
 
    FlagUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kFlag.StoredObjectID));
    shieldPoints = FlagUnit != none ? int(FlagUnit.GetCurrentStat(eStat_ShieldHP)) : 0;
 
    possibleHPDamage = MinDamageValue.Damage;
    possibleShieldDamage = 0;
 
    // MaxHP contains extra HP points given by shield
    if(shieldPoints > 0 && AllowedShield > 0)
    {
        possibleShieldDamage = min(shieldPoints, MinDamageValue.Damage);
        possibleShieldDamage = min(possibleShieldDamage, AllowedShield);
        possibleHPDamage = MinDamageValue.Damage - possibleShieldDamage;
    }
 
    if (!AbilityState.DamageIgnoresArmor() && FlagUnit != none)
        possibleHPDamage -= max(0,FlagUnit.GetArmorMitigationForUnitFlag() - MinDamageValue.Pierce);
 
    kFlag.SetShieldPointsPreview( possibleShieldDamage );
    kFlag.SetHitPointsPreview( possibleHPDamage );
    kFlag.SetArmorPointsPreview(MinDamageValue.Shred, MinDamageValue.Pierce);
}