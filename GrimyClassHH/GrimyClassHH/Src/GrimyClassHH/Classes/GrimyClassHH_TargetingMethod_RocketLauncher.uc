class GrimyClassHH_TargetingMethod_RocketLauncher extends X2TargetingMethod_Grenade;

static function bool UseGrenadePath() { return false; }

function Update(float DeltaTime)
{
	local XComWorldData World;
	local VoxelRaytraceCheckResult Raytrace;
	local array<Actor> CurrentlyMarkedTargets;
	local vector NewTargetLocation;
	local array<TTile> Tiles;
	local TTile SnapTile;

	NewTargetLocation = GetSplashRadiusCenter();
	World = `XWORLD;
	SnapTile = World.GetTileCoordinatesFromPosition( NewTargetLocation );

	if ( !class'X2TacticalVisibilityHelpers'.static.CanUnitSeeLocation(FiringUnit.ObjectID, SnapTile) ) {
		if( World.VoxelRaytrace_Locations(FiringUnit.Location, NewTargetLocation, Raytrace) ) {
			NewTargetLocation = RayTrace.TraceBlocked;
		}
	}

	if(NewTargetLocation != CachedTargetLocation)
	{		
		GetTargetedActors(NewTargetLocation, CurrentlyMarkedTargets, Tiles);
		CheckForFriendlyUnit(CurrentlyMarkedTargets);	
		MarkTargetedActors(CurrentlyMarkedTargets, (!AbilityIsOffensive) ? FiringUnit.GetTeam() : eTeam_None );
		DrawSplashRadius();
		DrawAOETiles(Tiles);
	}

	super.Update(DeltaTime);
}

/*class GrimyClassHH_TargetingMethod_RocketLauncher extends X2TargetingMethod_RocketLauncher;

function Update(float DeltaTime)
{
	local XComWorldData World;
	local VoxelRaytraceCheckResult Raytrace;
	local array<Actor> CurrentlyMarkedTargets;
	local int Direction, CanSeeFromDefault;
	local UnitPeekSide PeekSide;
	local int OutRequiresLean;
	local TTile PeekTile, UnitTile;
	local CachedCoverAndPeekData PeekData;
	local array<TTile> Tiles;
	NewTargetLocation = Cursor.GetCursorFeetLocation();

	if( NewTargetLocation != CachedTargetLocation )
	{
		World = `XWORLD;
		if( World.VoxelRaytrace_Locations(FiringUnit.Location, NewTargetLocation, Raytrace) )
		{
			NewTargetLocation = RayTrace.TraceBlocked;
			
			FiringUnit.GetDirectionInfoForPosition(NewTargetLocation, Direction, PeekSide, CanSeeFromDefault, OutRequiresLean, true);

			if (PeekSide != eNoPeek)
			{
				UnitTile = World.GetTileCoordinatesFromPosition(FiringUnit.Location);
				PeekData = World.GetCachedCoverAndPeekData(UnitTile);
				if (PeekSide == ePeekLeft)
					PeekTile = PeekData.CoverDirectionInfo[Direction].LeftPeek.PeekTile;
				else
					PeekTile = PeekData.CoverDirectionInfo[Direction].RightPeek.PeekTile;

				if (World.VoxelRaytrace_Tiles(UnitTile, PeekTile, Raytrace))
					NewTargetLocation = RayTrace.TraceBlocked;
			}
		}	

		GetTargetedActors(NewTargetLocation, CurrentlyMarkedTargets, Tiles);
		CheckForFriendlyUnit(CurrentlyMarkedTargets);	
		MarkTargetedActors(CurrentlyMarkedTargets, (!AbilityIsOffensive) ? FiringUnit.GetTeam() : eTeam_None );
		DrawSplashRadius();
		DrawAOETiles(Tiles);
	}

	super.UpdateTargetLocation(DeltaTime);
}*/

defaultproperties
{
	SnapToTile = false;
}