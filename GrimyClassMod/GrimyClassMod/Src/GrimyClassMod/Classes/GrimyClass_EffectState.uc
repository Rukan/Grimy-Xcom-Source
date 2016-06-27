class GrimyClass_EffectState extends XComGameState_Effect;

var array<int> TargetIDs;
var private float DamageTakenThisFullTurn2;
var private int GrantsThisTurn2;

function bool TickEffect(XComGameState NewGameState, bool FirstApplication)
{
	local GrimyClass_EffectState NewEffectState;
	local X2Effect_Persistent EffectTemplate;
	local bool bContinueTicking;

	EffectTemplate = GetX2Effect();

	NewEffectState = GrimyClass_EffectState(NewGameState.CreateStateObject(Class, ObjectID));
	NewEffectState.DamageTakenThisFullTurn2 = 0;
	NewEffectState.GrantsThisTurn2 = 0;
	NewEffectState.TargetIDs.length = 0;

	//Apply the tick effect to our target / source	
	bContinueTicking = EffectTemplate.OnEffectTicked(  ApplyEffectParameters,
															 NewEffectState,
															 NewGameState,
															 FirstApplication );

	NewGameState.AddStateObject(NewEffectState);

	// If the effect removes itself return false, stop the ticking of the effect
	// If the effect does not return iteslf, then the effect will be ticked again if it is infinite or there is time remaining
	return bContinueTicking;
}

function EventListenerReturn OnSourceUnitTookEffectDamage(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local X2Effect_Sustained SustainedEffectTemplate;
	local UnitValue LastEffectDamage;
	local XComGameState_Unit SustainedEffectSourceUnit;
	local XComGameState NewGameState;
	local XComGameStateHistory History;
	local XComGameStateContext_EffectRemoved EffectRemovedState;
	local X2TacticalGameRuleset TacticalRules;

	// If this effect is already removed, don't do it again
	if( !bRemoved )
	{
		History = `XCOMHISTORY;

		SustainedEffectTemplate = X2Effect_Sustained(GetX2Effect());
		//removed assert, this function is now used also for other effects other than sustained effects.
		//`assert(SustainedEffectTemplate != none);
		if(SustainedEffectTemplate != none)
		{
			SustainedEffectSourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			SustainedEffectSourceUnit.GetUnitValue('LastEffectDamage', LastEffectDamage);

			DamageTakenThisFullTurn2 += LastEffectDamage.fValue;
			if (!(SustainedEffectTemplate.FragileAmount > 0 && (DamageTakenThisFullTurn2 >= SustainedEffectTemplate.FragileAmount)))
			{
				// The sustained effect's source unit has not taken enough damge, the sustain is kept, we just break out
				return ELR_NoInterrupt;
			}
		}

		EffectRemovedState = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(self);
		NewGameState = History.CreateNewGameState(true, EffectRemovedState);
		RemoveEffect(NewGameState, GameState);

		if( NewGameState.GetNumGameStateObjects() > 0 )
		{
			TacticalRules = `TACTICALRULES;
			TacticalRules.SubmitGameState(NewGameState);
			//  effects may have changed action availability - if a unit died, took damage, etc.
		}
		else
		{
			History.CleanupPendingGameState(NewGameState);
		}
	}

	return ELR_NoInterrupt;
}

function EventListenerReturn CoveringFireCheck(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState_Unit AttackingUnit, CoveringUnit;
	local XComGameStateHistory History;
	local GrimyClass_Effect_CoveringFire CoveringFireEffect;
	local StateObjectReference AbilityRef;
	local XComGameState_Ability AbilityState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState NewGameState;
	local GrimyClass_EffectState NewEffectState;

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if (AbilityContext != none)
	{
		History = `XCOMHISTORY;
		CoveringUnit = XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
		AttackingUnit = class'X2TacticalGameRulesetDataStructures'.static.GetAttackingUnitState(GameState);
		if (AttackingUnit != none && AttackingUnit.IsEnemyUnit(CoveringUnit))
		{
			CoveringFireEffect = GrimyClass_Effect_CoveringFire(GetX2Effect());
			`assert(CoveringFireEffect != none);

			if (CoveringFireEffect.bOnlyDuringEnemyTurn)
			{
				//  make sure it's the enemy turn if required
				if (`TACTICALRULES.GetCachedUnitActionPlayerRef().ObjectID != AttackingUnit.ControllingPlayer.ObjectID)
					return ELR_NoInterrupt;
			}

			if (CoveringFireEffect.bPreEmptiveFire)
			{
				//  for pre emptive fire, only process during the interrupt step
				if (AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt)
					return ELR_NoInterrupt;
			}
			else
			{
				//  for non-pre emptive fire, don't process during the interrupt step
				if (AbilityContext.InterruptionStatus == eInterruptionStatus_Interrupt)
					return ELR_NoInterrupt;
			}

			if (CoveringFireEffect.bDirectAttackOnly)
			{
				//  do nothing if the covering unit was not fired upon directly
				if (AbilityContext.InputContext.PrimaryTarget.ObjectID != CoveringUnit.ObjectID)
					return ELR_NoInterrupt;
			}

			if ( CoveringFireEffect.bOncePerTarget && TargetIDs.find(AttackingUnit.ObjectID) != INDEX_NONE ) {
				return ELR_NoInterrupt;
			}

			AbilityRef = CoveringUnit.FindAbility(CoveringFireEffect.AbilityToActivate);
			AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
			if (AbilityState != none)
			{
				if (CoveringFireEffect.GrantActionPoint != '' && (CoveringFireEffect.MaxPointsPerTurn > GrantsThisTurn2 || CoveringFireEffect.MaxPointsPerTurn <= 0))
				{
					NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState(string(GetFuncName()));
					NewEffectState = GrimyClass_EffectState(NewGameState.CreateStateObject(Class, ObjectID));
					NewEffectState.GrantsThisTurn2++;
					NewEffectState.TargetIDs.AddItem(AttackingUnit.ObjectID);
					NewGameState.AddStateObject(NewEffectState);

					CoveringUnit = XComGameState_Unit(NewGameState.CreateStateObject(CoveringUnit.Class, CoveringUnit.ObjectID));
					CoveringUnit.ReserveActionPoints.AddItem(CoveringFireEffect.GrantActionPoint);
					NewGameState.AddStateObject(CoveringUnit);

					if (AbilityState.CanActivateAbilityForObserverEvent(AttackingUnit, CoveringUnit) != 'AA_Success')
					{
						History.CleanupPendingGameState(NewGameState);
					}
					else
					{
						`TACTICALRULES.SubmitGameState(NewGameState);

						if (CoveringFireEffect.bUseMultiTargets)
						{
							AbilityState.AbilityTriggerAgainstSingleTarget(CoveringUnit.GetReference(), true);
						}
						else
						{
							AbilityContext = class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, AttackingUnit.ObjectID);
							if( AbilityContext.Validate() )
							{
								`TACTICALRULES.SubmitGameStateContext(AbilityContext);
							}
						}
					}
				}
				else if (AbilityState.CanActivateAbilityForObserverEvent(AttackingUnit) == 'AA_Success')
				{
					if (CoveringFireEffect.bUseMultiTargets)
					{
						AbilityState.AbilityTriggerAgainstSingleTarget(CoveringUnit.GetReference(), true);
					}
					else
					{
						AbilityContext = class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, AttackingUnit.ObjectID);
						if( AbilityContext.Validate() )
						{
							`TACTICALRULES.SubmitGameStateContext(AbilityContext);
						}
					}
				}
			}
		}
	}
	return ELR_NoInterrupt;
}