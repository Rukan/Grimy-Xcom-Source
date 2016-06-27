class TacticalXP extends UITacticalHUD_SoldierInfo config(TacticalXP);

var config int CUTOFF_RANK;
var config bool SUBTRACT_ASSISTS;

simulated function SetStats( XGUnit kActiveUnit )
{
	local XComGameState_Unit StateUnit;
	local string charName, charNickname, charRank, charClass;
	local bool isLeader, isLeveledUp, showBonus, showPenalty;
	local float aimPercent;
	local array<UISummary_UnitEffect> BonusEffects, PenaltyEffects; 
	local X2SoldierClassTemplateManager SoldierTemplateManager;

	StateUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kActiveUnit.ObjectID));

	if( StateUnit.GetMyTemplateName() == 'AdvPsiWitchM2' )
	{
		charName = StateUnit.GetName(eNameType_Full);

		charRank = "img:///UILibrary_Common.rank_fieldmarshall";
		SoldierTemplateManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
		charClass = SoldierTemplateManager.FindSoldierClassTemplate('PsiOperative').IconImage;
		aimPercent = StateUnit.GetCurrentStat(eStat_Offense);
	}
	else 
	{
		charName = StateUnit.GetName(eNameType_Full);
		if ( StateUnit.GetNickName() == "" )
		{
			charNickname = GetKillString(StateUnit);
		}
		else
		{
			charNickname = StateUnit.GetNickName() $ ", " $ GetKillString(StateUnit);
		}

		if( StateUnit.IsSoldier() )
		{
			charRank = class'UIUtilities_Image'.static.GetRankIcon(StateUnit.GetRank(), StateUnit.GetSoldierClassTemplateName());
			charClass = StateUnit.GetSoldierClassTemplate().IconImage;
			isLeveledUp = StateUnit.CanRankUpSoldier();
			aimPercent = StateUnit.GetCurrentStat(eStat_Offense);
		}
		else if( StateUnit.IsCivilian() )
		{
			//charRank = string(-2); // TODO: show civilian icon 
			//charClass = "";
			aimPercent = -1;
		}
		else // is enemy
		{
			//charRank = string(99); //TODO: show alien icon 
			//charClass = "none";
			aimPercent = -1;
		}
	}

	// TODO:
	isLeader = false;

	BonusEffects = StateUnit.GetUISummary_UnitEffectsByCategory(ePerkBuff_Bonus);
	PenaltyEffects = StateUnit.GetUISummary_UnitEffectsByCategory(ePerkBuff_Penalty);

	showBonus = (BonusEffects.length > 0 ); 
	showPenalty = (PenaltyEffects.length > 0);

	AS_SetStats(charName, charNickname, charRank, charClass, isLeader, isLeveledUp, aimPercent, showBonus, showPenalty);
}

function string GetKillString(XComGameState_Unit UnitState)
{
	local int NumKills, ReqKills;

//	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(StateObjectRef.ObjectID));
	NumKills = UnitState.GetNumKills();

	//  Increase kills for WetWork bonus if appropriate
	NumKills += Round(UnitState.WetWorkKills * class'X2ExperienceConfig'.default.NumKillsBonus);

	// Get kills needed for level
	ReqKills = class'X2ExperienceConfig'.static.GetRequiredKills(UnitState.GetRank() + 1);

	if ( default.SUBTRACT_ASSISTS )
	{
		ReqKills -= UnitState.GetNumKillsFromAssists();
	}
	else
	{
		//  Add number of kills from assists
		NumKills += UnitState.GetNumKillsFromAssists();
	}

    if(ReqKills != 0 && !UnitState.IsPsiOperative() && UnitState.GetRank() < default.CUTOFF_RANK )
	{
		return "Kills: " $ string(NumKills) $ "/" $ ReqKills;
	}
	else
	{
		return "Kills: " $ string(NumKills);
	}
}