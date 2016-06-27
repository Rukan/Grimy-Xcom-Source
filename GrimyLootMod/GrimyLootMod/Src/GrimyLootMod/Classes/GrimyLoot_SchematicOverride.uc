class GrimyLoot_SchematicOverride extends X2Item_DefaultSchematics;

// Used by schematics and techs to upgrade all of the instances of an item based on a creator template
static function UpgradeItems(XComGameState NewGameState, XComGameState_Item ItemState)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate BaseItemTemplate, UpgradeItemTemplate;
	local X2WeaponUpgradeTemplate WeaponUpgradeTemplate;
	local XComGameState_Item InventoryItemState, BaseItemState, UpgradedItemState;
	local GrimyLoot_GameState_Loot GrimyLootState;
	local array<X2ItemTemplate> CreatedItems, ItemsToUpgrade;
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local array<XComGameState_Item> InventoryItems;
	local array<XComGameState_Unit> Soldiers;
	local EInventorySlot InventorySlot;
	local XComNarrativeMoment EquipNarrativeMoment;
	local XComGameState_Unit HighestRankSoldier;
	local int idx, iSoldier, iItems;

	History = `XCOMHISTORY;
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if (XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	CreatedItems = ItemTemplateManager.GetAllItemsCreatedByTemplate(ItemState.GetMyTemplateName());

	for (idx = 0; idx < CreatedItems.Length; idx++)
	{
		UpgradeItemTemplate = CreatedItems[idx];

		ItemsToUpgrade.Length = 0; // Reset ItemsToUpgrade for this upgrade item iteration
		GetItemsToUpgrade(UpgradeItemTemplate, ItemsToUpgrade);

		// If the new item is infinite, just add it directly to the inventory
		if (UpgradeItemTemplate.bInfiniteItem)
		{
			// But only add the infinite item if it isn't already in the inventory
			if (!XComHQ.HasItem(UpgradeItemTemplate))
			{
				UpgradedItemState = UpgradeItemTemplate.CreateInstanceFromTemplate(NewGameState);
				NewGameState.AddStateObject(UpgradedItemState);
				XComHQ.AddItemToHQInventory(UpgradedItemState);
			}
		}
		else
		{
			// Otherwise cycle through each of the base item templates
			foreach ItemsToUpgrade(BaseItemTemplate)
			{
				// Check if the base item is in the XComHQ inventory
				BaseItemState = XComHQ.GetItemByName(BaseItemTemplate.DataName);

				// If it is not, we have nothing to replace, so move on
				if (BaseItemState != none && BaseItemState.GetMyWeaponUpgradeTemplates().Length > 0 )
				{
					if ( GrimyLoot_GameState_Loot(BaseItemState).TradingPostValue > 0 )
					{
						// Otherwise match the base items quantity
						GrimyLootState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
						GrimyLootState.OnCreation(UpgradeItemTemplate);
						NewGameState.AddStateObject(GrimyLootState);
						GrimyLootState.Quantity = BaseItemState.Quantity;
						GrimyLootState.WeaponAppearance = BaseItemState.WeaponAppearance;
						//GrimyLootState.Nickname = BaseItemState.Nickname;
						GrimyLootState.Nickname = Repl(BaseItemState.Nickname,BaseItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),GrimyLootState.GetMyTemplate().GetItemFriendlyNameNoStats(),false);

						// Transfer over all weapon upgrades to the new item
						WeaponUpgrades = BaseItemState.GetMyWeaponUpgradeTemplates();
						foreach WeaponUpgrades(WeaponUpgradeTemplate)
						{
							GrimyLootState.ApplyWeaponUpgradeTemplate(WeaponUpgradeTemplate);
						}
						
						// Add Grimy Loot Info
						GrimyLootState.NumUpgrades = GrimyLoot_GameState_Loot(BaseItemState).NumUpgrades;
						GrimyLootState.TradingPostValue = GrimyLoot_GameState_Loot(BaseItemState).TradingPostValue;

						// Then add the upgrade item and remove all of the base items from the inventory
						XComHQ.PutItemInInventory(NewGameState, GrimyLootState);
						XComHQ.RemoveItemFromInventory(NewGameState, BaseItemState.GetReference(), BaseItemState.Quantity);
						NewGameState.RemoveStateObject(BaseItemState.GetReference().ObjectID);
					}
					else
					{
						// Otherwise match the base items quantity
						UpgradedItemState = UpgradeItemTemplate.CreateInstanceFromTemplate(NewGameState);
						NewGameState.AddStateObject(UpgradedItemState);
						UpgradedItemState.Quantity = BaseItemState.Quantity;
						UpgradedItemState.WeaponAppearance = BaseItemState.WeaponAppearance;
						//UpgradedItemState.Nickname = BaseItemState.Nickname;
						UpgradedItemState.Nickname = Repl(BaseItemState.Nickname,BaseItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),UpgradedItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),false);

						// Transfer over all weapon upgrades to the new item
						WeaponUpgrades = BaseItemState.GetMyWeaponUpgradeTemplates();
						foreach WeaponUpgrades(WeaponUpgradeTemplate)
						{
							UpgradedItemState.ApplyWeaponUpgradeTemplate(WeaponUpgradeTemplate);
						}

						// Then add the upgrade item and remove all of the base items from the inventory
						XComHQ.PutItemInInventory(NewGameState, UpgradedItemState);
						XComHQ.RemoveItemFromInventory(NewGameState, BaseItemState.GetReference(), BaseItemState.Quantity);
						NewGameState.RemoveStateObject(BaseItemState.GetReference().ObjectID);
					}
				}
			}
		}

		// Check the inventory for any unequipped items with weapon upgrades attached, make sure they get updated
		for (iItems = 0; iItems < XComHQ.Inventory.Length; iItems++)
		{
			InventoryItemState = XComGameState_Item(History.GetGameStateForObjectID(XComHQ.Inventory[iItems].ObjectID));
			foreach ItemsToUpgrade(BaseItemTemplate)
			{
				if (InventoryItemState.GetMyTemplateName() == BaseItemTemplate.DataName && InventoryItemState.GetMyWeaponUpgradeTemplates().Length > 0 )
				{
					if ( GrimyLoot_GameState_Loot(InventoryItemState).TradingPostValue > 0 )
					{
						// Otherwise match the base items quantity
						GrimyLootState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
						GrimyLootState.OnCreation(UpgradeItemTemplate);
						NewGameState.AddStateObject(GrimyLootState);
						GrimyLootState.Quantity = InventoryItemState.Quantity;
						GrimyLootState.WeaponAppearance = InventoryItemState.WeaponAppearance;
						//GrimyLootState.Nickname = InventoryItemState.Nickname;
						GrimyLootState.Nickname = Repl(InventoryItemState.Nickname,InventoryItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),GrimyLootState.GetMyTemplate().GetItemFriendlyNameNoStats(),false);

						// Transfer over all weapon upgrades to the new item
						WeaponUpgrades = InventoryItemState.GetMyWeaponUpgradeTemplates();
						foreach WeaponUpgrades(WeaponUpgradeTemplate)
						{
							GrimyLootState.ApplyWeaponUpgradeTemplate(WeaponUpgradeTemplate);
						}
						
						// Add Grimy Loot Info
						GrimyLootState.NumUpgrades = GrimyLoot_GameState_Loot(InventoryItemState).NumUpgrades;
						GrimyLootState.TradingPostValue = GrimyLoot_GameState_Loot(InventoryItemState).TradingPostValue;

						// Then add the upgrade item and remove all of the base items from the inventory
						NewGameState.RemoveStateObject(InventoryItemState.GetReference().ObjectID);
						XComHQ.Inventory.RemoveItem(InventoryItemState.GetReference());
						XComHQ.PutItemInInventory(NewGameState, GrimyLootState);
					}
					else
					{
						UpgradedItemState = UpgradeItemTemplate.CreateInstanceFromTemplate(NewGameState);
						NewGameState.AddStateObject(UpgradedItemState);
						UpgradedItemState.WeaponAppearance = InventoryItemState.WeaponAppearance;
						//UpgradedItemState.Nickname = InventoryItemState.Nickname;
						UpgradedItemState.Nickname = Repl(InventoryItemState.Nickname,InventoryItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),UpgradedItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),false);


						// Transfer over all weapon upgrades to the new item
						WeaponUpgrades = InventoryItemState.GetMyWeaponUpgradeTemplates();
						foreach WeaponUpgrades(WeaponUpgradeTemplate)
						{
							UpgradedItemState.ApplyWeaponUpgradeTemplate(WeaponUpgradeTemplate);
						}

						// Delete the old item, and add the new item to the inventory
						NewGameState.RemoveStateObject(InventoryItemState.GetReference().ObjectID);
						XComHQ.Inventory.RemoveItem(InventoryItemState.GetReference());
						XComHQ.PutItemInInventory(NewGameState, UpgradedItemState);
					}
				}
			}
		}

		// Then check every soldier's inventory and replace the old item with a new one
		Soldiers = XComHQ.GetSoldiers();
		for (iSoldier = 0; iSoldier < Soldiers.Length; iSoldier++)
		{
			InventoryItems = Soldiers[iSoldier].GetAllInventoryItems(NewGameState, false);

			foreach InventoryItems(InventoryItemState)
			{
				foreach ItemsToUpgrade(BaseItemTemplate)
				{
					if (InventoryItemState.GetMyTemplateName() == BaseItemTemplate.DataName)
					{
						if ( GrimyLoot_GameState_Loot(InventoryItemState).TradingPostValue > 0 )
						{
							// Otherwise match the base items quantity
							GrimyLootState = GrimyLoot_GameState_Loot(NewGameState.CreateStateObject(class'GrimyLoot_GameState_Loot'));
							GrimyLootState.OnCreation(UpgradeItemTemplate);
							NewGameState.AddStateObject(GrimyLootState);
							GrimyLootState.Quantity = InventoryItemState.Quantity;
							GrimyLootState.WeaponAppearance = InventoryItemState.WeaponAppearance;
							GrimyLootState.Nickname = Repl(InventoryItemState.Nickname,InventoryItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),GrimyLootState.GetMyTemplate().GetItemFriendlyNameNoStats(),false);
							GrimyLootState.NumUpgrades = GrimyLoot_GameState_Loot(InventoryItemState).NumUpgrades;
							GrimyLootState.TradingPostValue = GrimyLoot_GameState_Loot(InventoryItemState).TradingPostValue;
							InventorySlot = InventoryItemState.InventorySlot; // save the slot location for the new item

							// Transfer over all weapon upgrades to the new item
							Soldiers[iSoldier].RemoveItemFromInventory(InventoryItemState, NewGameState);
							WeaponUpgrades = InventoryItemState.GetMyWeaponUpgradeTemplates();
							foreach WeaponUpgrades(WeaponUpgradeTemplate)
							{
								GrimyLootState.ApplyWeaponUpgradeTemplate(WeaponUpgradeTemplate);
							}

							// Then add the upgrade item and remove all of the base items from the inventory
							NewGameState.RemoveStateObject(InventoryItemState.GetReference().ObjectID);
							Soldiers[iSoldier].AddItemToInventory(GrimyLootState, InventorySlot, NewGameState);

							// Store the highest ranking soldier to get the upgraded item
							if (HighestRankSoldier == none || Soldiers[iSoldier].GetRank() > HighestRankSoldier.GetRank())
							{
								HighestRankSoldier = Soldiers[iSoldier];
							}
						}
						else
						{
							UpgradedItemState = UpgradeItemTemplate.CreateInstanceFromTemplate(NewGameState);
							NewGameState.AddStateObject(UpgradedItemState);
							UpgradedItemState.WeaponAppearance = InventoryItemState.WeaponAppearance;
							UpgradedItemState.Nickname = Repl(InventoryItemState.Nickname,InventoryItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),UpgradedItemState.GetMyTemplate().GetItemFriendlyNameNoStats(),false);
							InventorySlot = InventoryItemState.InventorySlot; // save the slot location for the new item

							// Remove the old item from the soldier and transfer over all weapon upgrades to the new item
							Soldiers[iSoldier].RemoveItemFromInventory(InventoryItemState, NewGameState);
							WeaponUpgrades = InventoryItemState.GetMyWeaponUpgradeTemplates();
							foreach WeaponUpgrades(WeaponUpgradeTemplate)
							{
								UpgradedItemState.ApplyWeaponUpgradeTemplate(WeaponUpgradeTemplate);
							}

							// Delete the old item
							NewGameState.RemoveStateObject(InventoryItemState.GetReference().ObjectID);

							// Then add the new item to the soldier in the same slot
							Soldiers[iSoldier].AddItemToInventory(UpgradedItemState, InventorySlot, NewGameState);

							// Store the highest ranking soldier to get the upgraded item
							if (HighestRankSoldier == none || Soldiers[iSoldier].GetRank() > HighestRankSoldier.GetRank())
							{
								HighestRankSoldier = Soldiers[iSoldier];
							}
						}
					}
				}
			}
		}

		// Play a narrative if there is one and there is a valid soldier
		if (HighestRankSoldier != none && X2EquipmentTemplate(UpgradeItemTemplate).EquipNarrative != "")
		{
			EquipNarrativeMoment = XComNarrativeMoment(`CONTENT.RequestGameArchetype(X2EquipmentTemplate(UpgradeItemTemplate).EquipNarrative));
			if (EquipNarrativeMoment != None && XComHQ.CanPlayArmorIntroNarrativeMoment(EquipNarrativeMoment))
			{
				XComHQ.UpdatePlayedArmorIntroNarrativeMoments(EquipNarrativeMoment);
				`HQPRES.UIArmorIntroCinematic(EquipNarrativeMoment.nmRemoteEvent, 'CIN_ArmorIntro_Done', HighestRankSoldier.GetReference());
			}
		}
	}
}

// Recursively calculates the list of items to upgrade based on the final upgraded item template
private static function GetItemsToUpgrade(X2ItemTemplate UpgradeItemTemplate, out array<X2ItemTemplate> ItemsToUpgrade)
{
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate BaseItemTemplate, AdditionalBaseItemTemplate;
	local array<X2ItemTemplate> BaseItems;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	// Search for any base items which specify this item as their upgrade. This accounts for the old version of schematics, mainly for Day 0 DLC
	BaseItems = ItemTemplateManager.GetAllBaseItemTemplatesFromUpgrade(UpgradeItemTemplate.DataName);
	foreach BaseItems(AdditionalBaseItemTemplate)
	{
		if (ItemsToUpgrade.Find(AdditionalBaseItemTemplate) == INDEX_NONE)
		{
			ItemsToUpgrade.AddItem(AdditionalBaseItemTemplate);
		}
	}
	
	// If the base item was also the result of an upgrade, we need to save that base item as well to ensure the entire chain is upgraded
	BaseItemTemplate = ItemTemplateManager.FindItemTemplate(UpgradeItemTemplate.BaseItem);
	if (BaseItemTemplate != none)
	{
		ItemsToUpgrade.AddItem(BaseItemTemplate);
		GetItemsToUpgrade(BaseItemTemplate, ItemsToUpgrade);
	}
}