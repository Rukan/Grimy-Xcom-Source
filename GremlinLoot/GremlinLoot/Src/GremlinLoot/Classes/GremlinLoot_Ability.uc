class GremlinLoot_Ability extends X2Ability_SpecialistAbilitySet config(GremlinLoot);

var config int AP_COST;

static function array<X2DataTemplate> CreateTemplates() {
	local array<X2DataTemplate>					Templates;

	Templates.AddItem(GremlinLootProtocol());

	return Templates;
}

static function X2AbilityTemplate GremlinLootProtocol()
{
	local X2AbilityTemplate                 Template;		
	local X2AbilityCost_ActionPoints        ActionPointCost;	
	local X2Condition_UnitProperty          UnitPropertyCondition;	
	local GremlinLoot_Condition              LootableCondition;
	local X2Condition_Visibility			VisibilityCondition;
	local X2AbilityTrigger_PlayerInput      InputTrigger;
	local X2AbilityTarget_Single            SingleTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GremlinLootProtocol');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_loot"; 
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.LOOT_PRIORITY;
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.AP_COST;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeImpaired = true;
	UnitPropertyCondition.ImpairedIgnoresStuns = true;
	UnitPropertyCondition.ExcludePanicked = true;
	Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);

	LootableCondition = new class'GremlinLoot_Condition';
	LootableCondition.LootableRange = 999;
	LootableCondition.bRestrictRange = true;
	Template.AbilityTargetConditions.AddItem(LootableCondition);

	VisibilityCondition = new class'X2Condition_Visibility';
	VisibilityCondition.bRequireLOS = true;
	Template.AbilityTargetConditions.AddItem(VisibilityCondition);

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.bAllowInteractiveObjects = true;
	Template.AbilityTargetStyle = SingleTarget;	

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	//Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';

	Template.BuildNewGameStateFn = AttachGremlinLootToTarget_BuildGameState;
	Template.BuildVisualizationFn = GremlinLootSingleTarget_BuildVisualization;
	Template.Hostility = eHostility_Neutral;

	//Template.CinescriptCameraType = "Loot";
	Template.PostActivationEvents.AddItem('ItemRecalled');
	Template.CinescriptCameraType = "Specialist_CombatProtocol";

	return Template;
}

function XComGameState AttachGremlinLootToTarget_BuildGameState( XComGameStateContext Context )
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState NewGameState;
	local XComGameState_Item GremlinItemState;
	local XComGameState_Unit GremlinUnitState;//, TargetUnitState;
	local XComGameState_BaseObject TargetState;
	local XComGameState_LootDrop TargetLootState;

	AbilityContext = XComGameStateContext_Ability(Context);
	NewGameState = TypicalAbility_BuildGameState(Context);
	
	TargetState = `XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID);
	if( TargetState != none )
	{
		TargetState = NewGameState.CreateStateObject(TargetState.Class, TargetState.ObjectID);
		NewGameState.AddStateObject(TargetState);

		// award all loot on the hacked object to the hacker
		Lootable(TargetState).MakeAvailableLoot(NewGameState);
		class'Helpers'.static.AcquireAllLoot(Lootable(TargetState), AbilityContext.InputContext.SourceObject, NewGameState);
	}
	TargetLootState = XComGameState_LootDrop(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	if (TargetLootState == none)
	{
		TargetLootState = XComGameState_LootDrop(NewGameState.CreateStateObject(class'XComGameState_Unit', AbilityContext.InputContext.PrimaryTarget.ObjectID));
		NewGameState.AddStateObject(TargetLootState);
	}
	GremlinItemState = XComGameState_Item(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.ItemObject.ObjectID));
	if (GremlinItemState == none)
	{
		GremlinItemState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', AbilityContext.InputContext.ItemObject.ObjectID));
		NewGameState.AddStateObject(GremlinItemState);
	}
	GremlinUnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(GremlinItemState.CosmeticUnitRef.ObjectID));
	if (GremlinUnitState == none)
	{
		GremlinUnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', GremlinItemState.CosmeticUnitRef.ObjectID));
		NewGameState.AddStateObject(GremlinUnitState);
	}

	`assert(TargetLootState != none && GremlinItemState != none && GremlinUnitState != none);

	GremlinItemState.AttachedUnitRef = TargetLootState.GetReference();

	GremlinUnitState.SetVisibilityLocation(TargetLootState.TileLocation);

	return NewGameState;
}

simulated function GremlinLootSingleTarget_BuildVisualization(XComGameState VisualizeGameState, out array<VisualizationTrack> OutVisualizationTracks)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local X2AbilityTemplate             AbilityTemplate; 
	local StateObjectReference          InteractingUnitRef;
	local StateObjectReference          GremlinOwnerUnitRef;
	local XComGameState_Item			GremlinItem;
	local XComGameState_Unit			AttachedUnitState;
	local XComGameState_Unit			GremlinUnitState; 
	local array<PathPoint> Path;

	local VisualizationTrack        EmptyTrack;
	local VisualizationTrack        BuildTrack;
	local X2Action_WaitForAbilityEffect DelayAction;
	local X2Action_AbilityPerkStart		PerkStartAction;

	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local PathingInputData              PathData;
	local X2Action_SendInterTrackMessage SendMessageAction;

	local XComGameState_LootDrop		TargetLootState;
	local Lootable                      LootTarget;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);

	TargetLootState = XComGameState_LootDrop( VisualizeGameState.GetGameStateForObjectID( Context.InputContext.PrimaryTarget.ObjectID ) );

	GremlinItem = XComGameState_Item( History.GetGameStateForObjectID( Context.InputContext.ItemObject.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 ) );
	GremlinUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.CosmeticUnitRef.ObjectID ) );
	AttachedUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.AttachedUnitRef.ObjectID ) );

	if( GremlinUnitState == none )
	{
		`RedScreen("Attempting GremlinSingleTarget_BuildVisualization with a GremlinUnitState of none");
		return;
	}
	
	//Configure the visualization track for the gremlin
	//****************************************************************************************

	InteractingUnitRef = GremlinUnitState.GetReference( );

	BuildTrack = EmptyTrack;
	History.GetCurrentAndPreviousGameStatesForObjectID(GremlinUnitState.ObjectID, BuildTrack.StateObject_OldState, BuildTrack.StateObject_NewState, , VisualizeGameState.HistoryIndex);
	BuildTrack.TrackActor = GremlinUnitState.GetVisualizer();

	class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTrack(BuildTrack, Context);

	if (AttachedUnitState.TileLocation != TargetLootState.TileLocation)
	{
		class'X2PathSolver'.static.BuildPath( GremlinUnitState, AttachedUnitState.TileLocation, TargetLootState.TileLocation, PathData.MovementTiles );
		class'X2PathSolver'.static.GetPathPointsFromPath( GremlinUnitState, PathData.MovementTiles, Path );
		class'XComPath'.static.PerformStringPulling(XGUnitNativeBase(BuildTrack.TrackActor), Path);

		PathData.MovingUnitRef = GremlinUnitState.GetReference();
		PathData.MovementData = Path;
		Context.InputContext.MovementPaths.AddItem(PathData);
		class'X2VisualizerHelpers'.static.ParsePath( Context, BuildTrack, OutVisualizationTracks );
	}

	PerkStartAction = X2Action_AbilityPerkStart(class'X2Action_AbilityPerkStart'.static.AddToVisualizationTrack(BuildTrack, Context));
	PerkStartAction.NotifyTargetTracks = true;

	SendMessageAction = X2Action_SendInterTrackMessage(class'X2Action_SendInterTrackMessage'.static.AddToVisualizationTrack(BuildTrack, Context));
	SendMessageAction.SendTrackMessageToRef = Context.InputContext.PrimaryTarget;

	OutVisualizationTracks.AddItem( BuildTrack );
	//Configure the visualization track for the shooter
	//****************************************************************************************

	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.SourceObject;
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID( InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 );
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID( InteractingUnitRef.ObjectID );
	BuildTrack.TrackActor = History.GetVisualizer( InteractingUnitRef.ObjectID );
	
	LootTarget = Lootable(History.GetGameStateForObjectID(Context.InputContext.PrimaryTarget.ObjectID));
	class'X2Action_IntrusionProtocolSoldier'.static.AddToVisualizationTrack(BuildTrack, Context);

	OutVisualizationTracks.AddItem( BuildTrack );
	
	// second visualization track for picking up the loot
	InteractingUnitRef = Context.InputContext.SourceObject;
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID( InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 );
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID( InteractingUnitRef.ObjectID );
	BuildTrack.TrackActor = History.GetVisualizer( InteractingUnitRef.ObjectID );

	DelayAction = X2Action_WaitForAbilityEffect( class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTrack( BuildTrack, Context ) );
	DelayAction.ChangeTimeoutLength( default.GREMLIN_ARRIVAL_TIMEOUT );       //  give the gremlin plenty of time to show up

	class'X2Action_Loot'.static.AddToVisualizationTrackIfLooted(LootTarget, Context, BuildTrack);	
	OutVisualizationTracks.AddItem( BuildTrack );
	//****************************************************************************************


	//Configure the visualization track for the owner of the Gremlin
	//****************************************************************************************
	if (AbilityTemplate.ActivationSpeech != '')
	{
		GremlinOwnerUnitRef = GremlinItem.OwnerStateObject;

		BuildTrack = EmptyTrack;
		BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(GremlinOwnerUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(GremlinOwnerUnitRef.ObjectID);
		BuildTrack.TrackActor = History.GetVisualizer(GremlinOwnerUnitRef.ObjectID);

		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTrack(BuildTrack, Context));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.ActivationSpeech, eColor_Good);

		OutVisualizationTracks.AddItem(BuildTrack);
	}
	//****************************************************************************************
}