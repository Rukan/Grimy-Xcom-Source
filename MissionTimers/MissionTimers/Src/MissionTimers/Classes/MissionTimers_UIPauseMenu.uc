class MissionTimers_UIPauseMenu extends UIPauseMenu;

event Tick( float deltaTime )
{
	local XComGameState_TimerData	Timer;

	super.Tick( deltaTime );

	Timer = XComGameState_TimerData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_TimerData', true));

	if ( Timer != none ) {
		Timer.bStopTime = true;
		Timer.AddPauseTime(DeltaTime);
	}
}

simulated public function OnChildClicked(UIList ContainerList, int ItemIndex)
{		
	local MissionTimers_UIScreen		TimerScreen;
	Movie.Pres.PlayUISound(eSUISound_MenuSelect);

	SetSelected(ContainerList, ItemIndex);

	switch( m_iCurrentSelection )
	{
		case m_optReturnToGame:
			OnUCancel();
			break; 
		case m_optSave: //Save Game
			if (`TUTORIAL == none)
			{
				if (Movie.Pres.PlayerCanSave() && !`ONLINEEVENTMGR.SaveInProgress())
				{
					if (m_bIsIronman)
						IronmanSaveAndExitDialogue();
					else
					{
						Movie.Pres.UISaveScreen();
					}
				}
				else
				{
					UnableToSaveDialogue(`ONLINEEVENTMGR.SaveInProgress());
				}
			}
			break;

		case m_optLoad: //Load Game 
			TimerScreen = MissionTimers_UIScreen(`PRES.ScreenStack.GetScreen(class'MissionTimers_UIScreen'));
			TimerScreen.OnRemoved();
			`PRES.ScreenStack.PopFirstInstanceOfClass(class'MissionTimers_UIScreen');
			TimerScreen.CloseScreen();

			if( m_bIsIronman )
				`AUTOSAVEMGR.DoAutosave();

			Movie.Pres.UILoadScreen();
			break;

		case m_optChangeDifficulty:
			Movie.Pres.UIDifficulty( true );
			break;

		case m_optViewSecondWave:
			Movie.Pres.UISecondWave( true );
			break;

		case m_optRestart: // Restart Mission (only valid in tactical)
			TimerScreen = MissionTimers_UIScreen(`PRES.ScreenStack.GetScreen(class'MissionTimers_UIScreen'));
			TimerScreen.OnRemoved();
			`PRES.ScreenStack.PopFirstInstanceOfClass(class'MissionTimers_UIScreen');
			TimerScreen.CloseScreen();
			if (`BATTLE != none && WorldInfo.NetMode == NM_Standalone && !m_bIsIronman)
				RestartMissionDialogue();				
			break;

		case m_optControllerMap: //Controller Map
			Movie.Pres.UIControllerMap();
			break;

		case m_optOptions: // Input Options
			//`log(self @"OnUnrealCommand does not have game data designed and implemented for option #3.");
			//Movie.Pres.GetAnchoredMessenger().Message("Edit Settings option is not available.", 0.55f, 0.8f, BOTTOM_CENTER, 4.0f);
			Movie.Pres.UIPCOptions();
			return;

			break;
			
		case m_optExitGame: //Exit Game
			TimerScreen = MissionTimers_UIScreen(`PRES.ScreenStack.GetScreen(class'MissionTimers_UIScreen'));
			TimerScreen.OnRemoved();
			`PRES.ScreenStack.PopFirstInstanceOfClass(class'MissionTimers_UIScreen');
			TimerScreen.CloseScreen();
			if( m_bIsIronman )
				`AUTOSAVEMGR.DoAutosave();

			ExitGameDialogue();
			break;

		case m_optQuitGame: //Quit Game
			TimerScreen = MissionTimers_UIScreen(`PRES.ScreenStack.GetScreen(class'MissionTimers_UIScreen'));
			TimerScreen.OnRemoved();
			`PRES.ScreenStack.PopFirstInstanceOfClass(class'MissionTimers_UIScreen');
			TimerScreen.CloseScreen();
			if( m_bIsIronman )
				`AUTOSAVEMGR.DoAutosave();
				
			QuitGameDialogue();
			break;
			
		case m_optAcceptInvite: // Show Invitations UI
			Movie.Pres.UIInvitationsMenu();
			break;

		default:
			`warn("Pause menu cannot accept an unexpected index of:" @ m_iCurrentSelection);
			break;
	}	
}