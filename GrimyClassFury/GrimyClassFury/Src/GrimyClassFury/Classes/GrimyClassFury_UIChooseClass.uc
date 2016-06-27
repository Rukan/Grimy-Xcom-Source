class GrimyClassFury_UIChooseClass extends UIScreenListener;

var UIChooseClass MyScreen;

event OnInit(UIScreen Screen)
{
	MyScreen = UIChooseClass(Screen);

	if ( !HasPsiChamber() ) {
		MyScreen.arrItems = ConvertClassesToCommodities();
		//MyScreen.SetChooseResearchLayout();
		MyScreen.PopulateData();
	}
}

function bool HasPsiChamber() {
	local X2StrategyElementTemplateManager	StrategyManager;
	local X2FacilityTemplate				FacilityTemplate;

	StrategyManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	FacilityTemplate = X2FacilityTemplate(StrategyManager.FindStrategyElementTemplate('PsiChamber'));

	return MyScreen.XComHQ.HasFacility(FacilityTemplate);
}

function array<Commodity> ConvertClassesToCommodities()
{
	local X2SoldierClassTemplate ClassTemplate;
	local int iClass;
	local array<Commodity> arrCommodoties;
	local Commodity ClassComm;

	MyScreen.m_arrClasses.Remove(0, MyScreen.m_arrClasses.Length);
	MyScreen.m_arrClasses = GetClasses();
	MyScreen.m_arrClasses.Sort(MyScreen.SortClassesByName);

	for (iClass = 0; iClass < MyScreen.m_arrClasses.Length; iClass++)
	{
		ClassTemplate = MyScreen.m_arrClasses[iClass];

		ClassComm.Title = ClassTemplate.DisplayName;
		ClassComm.Image = ClassTemplate.IconImage;
		ClassComm.Desc = ClassTemplate.ClassSummary;
		ClassComm.OrderHours = MyScreen.XComHQ.GetTrainRookieDays() * 24;

		arrCommodoties.AddItem(ClassComm);
	}

	return arrCommodoties;
}

simulated function array<X2SoldierClassTemplate> GetClasses()
{
	local X2SoldierClassTemplateManager SoldierClassTemplateMan;
	local X2SoldierClassTemplate SoldierClassTemplate;
	local X2DataTemplate Template;
	local array<X2SoldierClassTemplate> ClassTemplates;

	SoldierClassTemplateMan = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();

	foreach SoldierClassTemplateMan.IterateTemplates(Template, none)
	{		
		SoldierClassTemplate = X2SoldierClassTemplate(Template);
		
		if (SoldierClassTemplate.NumInForcedDeck > 0 && !SoldierClassTemplate.bMultiplayerOnly && SoldierClassTemplate.DataName != 'Fury' )
			ClassTemplates.AddItem(SoldierClassTemplate);
	}

	return ClassTemplates;
}

defaultproperties
{
	ScreenClass = class'UIChooseClass';
}