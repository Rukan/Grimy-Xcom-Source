class GrimyLoot_ScreenListener extends UIScreenListener config(GrimyDynamicConfig);

var localized String m_strRareName, m_strEpicName, m_strLegendaryName;
var localized array<String> ChoiceNames;
var config string RecentName;
var UIAlert MyScreen;
var UIButton Choice1, Choice2, Choice3;

var bool bHaveNotChosen;
var XComGameState_Tech MyTechState;
var array<int> ChoiceIndices;
var GrimyLoot_UIItemCard MyItemCard;

event OnInit(UIScreen Screen)
{
	MyScreen = UIAlert(Screen);
	if ( MyScreen.eAlert == eAlert_ResearchComplete ) {
		MyTechState = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(MyScreen.TechRef.ObjectID));
		if ( GetLockboxRarity() > 0 ) {
			SpawnButtons();
		}
	}
}

function int GetLockboxRarity() {
	switch ( MyTechState.GetMyTemplateName() ) {
		case 'Tech_IdentifyRareLockbox':
			return 1;
		case 'Tech_IdentifyEpicLockbox':
		case 'Tech_IdentifyEpicLockboxInstant':
			return 2;
		case 'Tech_IdentifyLegendaryLockbox':
		case 'Tech_IdentifyLegendaryLockboxInstant':
			return 3;
		default:
			return 0;
	}
}

event OnRemoved(UIScreen Screen) {
	if ( MyScreen.eAlert == eAlert_ResearchComplete && bHaveNotChosen && GetLockboxRarity() > 0 ) {
		class'GrimyLoot_Research'.static.IdentifyByIndex(MyTechState, ChoiceIndices[Rand(3)],GetLockboxRarity());
	}
	MyItemCard.Remove();
	CloseChoices();
	//cleanup after ourselves, no need to do it for primitives though.
	MyTechState = none;
	MyItemCard = none;
	MyScreen = none;
	Choice1 = none;
	Choice2 = none;
	Choice3 = none;
	ChoiceIndices.length = 0;
}

function PickIndices() {
	if ( MyTechState.GetMyTemplateName() == 'Tech_IdentifyRareLockbox' ) {
		ChoiceIndices[0] = class'GrimyLoot_Research'.static.IdentifyIndex(false);
		ChoiceIndices[1] = class'GrimyLoot_Research'.static.IdentifyIndex(false);
		while ( ChoiceIndices[1] == ChoiceIndices[0] ) {
			ChoiceIndices[1] = class'GrimyLoot_Research'.static.IdentifyIndex(false);
		}
		ChoiceIndices[2] = class'GrimyLoot_Research'.static.IdentifyIndex(false);
		while ( ChoiceIndices[2] == ChoiceIndices[1] || ChoiceIndices[2] == ChoiceIndices[0] ) {
			ChoiceIndices[2] = class'GrimyLoot_Research'.static.IdentifyIndex(false);
		}
	}
	else {
		ChoiceIndices[0] = class'GrimyLoot_Research'.static.IdentifyIndex(true);
		ChoiceIndices[1] = class'GrimyLoot_Research'.static.IdentifyIndex(true);
		while ( ChoiceIndices[1] == ChoiceIndices[0] ) {
			ChoiceIndices[1] = class'GrimyLoot_Research'.static.IdentifyIndex(true);
		}
		ChoiceIndices[2] = class'GrimyLoot_Research'.static.IdentifyIndex(true);
		while ( ChoiceIndices[2] == ChoiceIndices[1] || ChoiceIndices[2] == ChoiceIndices[0] ) {
			ChoiceIndices[2] = class'GrimyLoot_Research'.static.IdentifyIndex(true);
		}
	}
}

function SpawnButtons() {
	bHaveNotChosen = true;

	MyScreen.Button1.Hide();
	MyScreen.Button2.Hide();

	PickIndices();

	Choice1 = MyScreen.Spawn(class'UIButton', MyScreen);
	Choice1.bAnimateOnInit = false;
	Choice1.SetResizeToText(false);
	Choice1.InitButton('Choice1', ChoiceNames[ChoiceIndices[0]], GiveItem);
	Choice1.AnchorCenter();
	Choice1.SetStyle(eUIButtonStyle_BUTTON_WHEN_MOUSE);
	Choice1.SetFontSize(28);
	Choice1.SetHeight(40);
	Choice1.SetWidth(500);
	Choice1.SetX(-260);
	Choice1.SetY(100);
	
	Choice2 = MyScreen.Spawn(class'UIButton', MyScreen);
	Choice2.bAnimateOnInit = false;
	Choice2.SetResizeToText(false);
	Choice2.InitButton('Choice2', ChoiceNames[ChoiceIndices[1]], GiveItem);
	Choice2.AnchorCenter();
	Choice2.SetStyle(eUIButtonStyle_BUTTON_WHEN_MOUSE);
	Choice2.SetFontSize(28);
	Choice2.SetHeight(40);
	Choice2.SetWidth(500);
	Choice2.SetX(-260);
	Choice2.SetY(140);
	
	Choice3 = MyScreen.Spawn(class'UIButton', MyScreen);
	Choice3.bAnimateOnInit = false;
	Choice3.SetResizeToText(false);
	Choice3.InitButton('Choice3', ChoiceNames[ChoiceIndices[2]], GiveItem);
	Choice3.AnchorCenter();
	Choice3.SetStyle(eUIButtonStyle_BUTTON_WHEN_MOUSE);
	Choice3.SetFontSize(28);
	Choice3.SetHeight(40);
	Choice3.SetWidth(500);
	Choice3.SetX(-260);
	Choice3.SetY(180);
}

function GiveItem(UIButton button) {
	local GrimyLoot_GameState_Loot ItemState;

	bHaveNotChosen = false;
	if ( button == Choice1 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(MyTechState, ChoiceIndices[0],GetLockboxRarity());
	}
	if ( button == Choice2 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(MyTechState, ChoiceIndices[1],GetLockboxRarity());
	}
	if ( button == Choice3 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(MyTechState, ChoiceIndices[2],GetLockboxRarity());
	}

	if ( MyItemCard == none ) {
		MyItemCard = GrimyLoot_UIItemCard(MyScreen.Spawn(class'GrimyLoot_UIItemCard', MyScreen).InitItemCard());
		MyItemCard.SetPosition(8, 90);
	}
	MyItemCard.PopulateItemCard(ItemState.GetMyTemplate(),ItemState.GetReference());
	MyItemCard.Show();

	CloseChoices();
	UpdateUI(MyScreen);
	MyScreen.Button1.Show();
	MyScreen.Button2.Show();
}

function CloseChoices() {
	Choice1.Remove();
	Choice2.Remove();
	Choice3.Remove();
}

static function SetRecentName(String RetName) {
	default.RecentName = RetName;
}

function UpdateUI(UIAlert screen) {
	local XGParamTag ParamTag;
	local TAlertCompletedInfo kInfo;
	local X2ItemTemplateManager ItemTemplateManager;
	local X2SchematicTemplate SchematicTemplate;

	if (MyTechState.ItemReward != none ) {
		if ( MyTechState.GetMyTemplateName() == 'Tech_IdentifyRareLockbox' ) {
			ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
			ParamTag.StrValue0 = m_strRareName @ MyTechState.ItemReward.GetItemFriendlyNameNoStats();
		}
		else if ( MyTechState.GetMyTemplateName() == 'Tech_IdentifyEpicLockbox' || MyTechState.GetMyTemplateName() == 'Tech_IdentifyEpicLockboxInstant' ) {
			ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
			ParamTag.StrValue0 = m_strEpicName @ MyTechState.ItemReward.GetItemFriendlyNameNoStats();
		}
		else if ( MyTechState.GetMyTemplateName() == 'Tech_IdentifyLegendaryLockbox' || MyTechState.GetMyTemplateName() == 'Tech_IdentifyLegendaryLockboxInstant' ) {
			ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
			ParamTag.StrValue0 = m_strLegendaryName @ MyTechState.ItemReward.GetItemFriendlyNameNoStats();
		}
		else {
			return;
		}


		kInfo.strName = MyTechState.GetDisplayName();
		kInfo.strHeaderLabel = screen.m_strResearchCompleteLabel;
				
		if ( class'GrimyLoot_Research'.default.RANDOMIZE_NICKNAMES && RecentName != "" ) {
			kInfo.strBody = ParamTag.StrValue0;
			ParamTag.StrValue0 = RecentName;
		}
		else {
			kInfo.strBody = screen.m_strResearchProjectComplete;
		}

		kInfo.strConfirm = screen.m_strAssignNewResearch;
		kInfo.strCarryOn = screen.m_strCarryOn;
		kInfo = screen.FillInTyganAlertComplete(kInfo);
		kInfo.eColor = eUIState_Warning;
		kInfo.clrAlert = MakeLinearColor(0.75, 0.75, 0.0, 1);

		if ( X2EquipmentTemplate(MyTechState.ItemReward).InventorySlot != eInvSlot_PrimaryWeapon ) {
			kInfo.strImage = MyTechState.ItemReward.strImage;
		}
		else if ( MyTechState.ItemReward.CreatorTemplateName != '' ) {
			ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
			SchematicTemplate = X2SchematicTemplate(ItemTemplateManager.FindItemTemplate(MyTechState.ItemReward.CreatorTemplateName));
			kInfo.strImage = SchematicTemplate.strImage;
		}
		else if ( MyTechState.ItemReward.DataName == 'AssaultRifle_CV' ) {
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvAssaultRifle";
		}
		else if ( MyTechState.ItemReward.DataName == 'Cannon_CV' ) {
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvCannon";
		}	
		else if ( MyTechState.ItemReward.DataName == 'Shotgun_CV' ) {
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvShotgun";
		}
		else if ( MyTechState.ItemReward.DataName == 'SniperRifle_CV' ) {
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvSniperRifle";
		}
		else if ( MyTechState.ItemReward.DataName == 'AlienHunterRifle_CV' ) {
			kInfo.strImage = "img:///UILibrary_DLC2Images.ConvBoltCaster";
		}
		else {
			kInfo.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Storage_Module";
		}
		kInfo.strBody $= "\n" $ `XEXPAND.ExpandString(MyTechState.GetMyTemplate().UnlockedDescription);
		screen.BuildCompleteAlert(kInfo);
	}
}

defaultproperties
{
	ScreenClass=class'UIAlert';
}