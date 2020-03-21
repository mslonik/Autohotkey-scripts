#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent

     ; constants
     ;~ SM_CXVIRTUALSCREEN := 78
     ;~ SM_CYVIRTUALSCREEN := 79
     ;~ SM_XVIRTUALSCREEN := 76
     ;~ SM_YVIRTUALSCREEN := 77
     DisplayRadioGroup := 0
     WindowWizardTitle := "O T A G L E Display Wizard"
     ButtonWidth            := 80
     ButtonHeight           := 80
     ButtonHorizontalMargin := 20
     ButtonVerticalMargin   := 20
     
     ;~ WizardStep1_Width := 0
     ;~ WizardStep1_Height := 0
     ;~ MonitorBoundingCoordinates_ :=
     ;~ MonitorBoundingCoordinates_Left    := 0
     ;~ MonitorBoundingCoordinates_Right   := 0
     ;~ MonitorBoundingCoordinates_Top     := 0
     ;~ MonitorBoundingCoordinates_Bottom  := 0


;~ Goto, ToStep2

Gui, WizardStep0_Intro: Font, bold
Gui, WizardStep0_Intro: Add, Text, w500, Introduction
Gui, WizardStep0_Intro: Font, 
Gui, WizardStep0_Intro: Add, Text, w500, When there is no otagle.ini file or on purspose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 sets of questions related to settings of display.
Gui, WizardStep0_Intro: Add, Text, w500, Step 1: `t`tChoose a display where GUI of OTAGLE is located.
Gui, WizardStep0_Intro: Add, Text, w500, Step 2: `t`tCheck display orientation, set scaling to 1.
Gui, WizardStep0_Intro: Add, Text, w500, Step 3: `t`tAdjust number of keys visible on the screen (rows and columns).
Gui, WizardStep0_Intro: Add, Button, Default x+-350 y+20 w80 gToStep1, &Next
Gui, WizardStep0_Intro: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
Gui, WizardStep0_Intro: Show, , % WindowWizardTitle
return 


ToStep1:
     Gui, WizardStep0_Intro: Destroy
     Gui, WizardStep1_GetDisplayCoordinates: Font, bold
     Gui, WizardStep1_GetDisplayCoordinates: Add, Text, w500, Step 1 out of 3: `t`tChoose a display where GUI of OTAGLE is located.
     Gui, WizardStep1_GetDisplayCoordinates: Font
     Gui, WizardStep1_GetDisplayCoordinates: Add, Text, w500, Specify one out of the available Display No.

     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
     
     Loop, % HowManyMonitors
          {
          if (A_Index = WhichIsPrimary)
               Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, gWizardStep1_Radio AltSubmit vDisplayRadioGroup Checked, % "Display #" . A_Index
          else
               Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, gWizardStep1_Radio AltSubmit, % "Display #" . A_Index
          }     
     Gui, WizardStep1_GetDisplayCoordinates: Add, Button, Default x+25 y+20 gCheckDisplayNumbering, &CheckDisplayNumbering
     Gui, WizardStep1_GetDisplayCoordinates: Add, Button, x+30 w80 gToStep2, &Next
     Gui, WizardStep1_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     Gui, WizardStep1_GetDisplayCoordinates: Show, , % WindowWizardTitle
     WinGetPos, , , WizardStep1_Width, WizardStep1_Height, A
return

ExitDisplayConfigurationWizard:
     Gui, WizardStep0_Intro: Destroy
ExitApp

WizardStep1_Radio:
     Gui, WizardStep1_GetDisplayCoordinates: Submit, NoHide
     Gui, WizardStep1_GetDisplayCoordinates: Destroy
     SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     Gui, WizardStep1_GetDisplayCoordinates: Font, bold
     Gui, WizardStep1_GetDisplayCoordinates: Add, Text, w500, Step 1 out of 3: `t`tChoose a display where GUI of OTAGLE is located.
     Gui, WizardStep1_GetDisplayCoordinates: Font
     Gui, WizardStep1_GetDisplayCoordinates: Add, Text, w500, Specify one out of the available Display No.
     Loop, % HowManyMonitors
          {
          if (A_Index = DisplayRadioGroup)
               Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, gWizardStep1_Radio AltSubmit vDisplayRadioGroup Checked, % "Display #" . A_Index
          else
               Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, gWizardStep1_Radio AltSubmit, % "Display #" . A_Index
          }
     Gui, WizardStep1_GetDisplayCoordinates: Add, Button, Default x+25 y+20 gCheckDisplayNumbering, &CheckDisplayNumbering
     Gui, WizardStep1_GetDisplayCoordinates: Add, Button, x+30 w80 gToStep2, &Next
     Gui, WizardStep1_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     Gui, WizardStep1_GetDisplayCoordinates: Show
     , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardStep1_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardStep1_Height / 2), % WindowWizardTitle
return


ToStep2:
     SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     Gui, WizardStep1_GetDisplayCoordinates: Destroy
     Gui, WizardStep2_GetDisplayCoordinates: Font, bold
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, w500, Step 2: `t`tDisplay Width and Height in pixels.
     Gui, WizardStep2_GetDisplayCoordinates: Font
     WizardStep2_Width := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
     WizardStep2_Height := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) 
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, y+20
          , % "Monitor: " . DisplayRadioGroup . " Width: " .  WizardStep2_Width 
          . " Height: " . WizardStep2_Height . " Suggested size of key: 80x80 px. Gap size: 20x20 px."
     WizardStep2_AmountOfKeysHorizontally := (WizardStep2_Width - 20) // (80 + 20)
     WizardStep2_MarginHorizontally := WizardStep2_Width - (WizardStep2_AmountOfKeysHorizontally * 20 + WizardStep2_AmountOfKeysHorizontally * 80 + 20)
     WizardStep2_AmountOfKeysVertically := (WizardStep2_Height - 20) // (80 + 20)
     WizardStep2_MarginVertically := WizardStep2_Height - (WizardStep2_AmountOfKeysVertically * 20 + WizardStep2_AmountOfKeysVertically * 80 + 20)
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, y+20, % "Number of keys horizontally: " . WizardStep2_AmountOfKeysHorizontally . " and margin: " . WizardStep2_MarginHorizontally
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, y+20, % "Number of keys vertically: " . WizardStep2_AmountOfKeysVertically . " and margin: " . WizardStep2_MarginVertically
     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, Default x50 y+20 w80 gToStep3, &Next
     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     Gui, WizardStep2_GetDisplayCoordinates: Show
     , % "x" . MonitorBoundingCoordinates_Left + (WizardStep2_Width / 2) - (WizardStep1_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (WizardStep2_Height / 2) - (WizardStep1_Height / 2), % WindowWizardTitle
return


ToStep3:
     SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     Gui, WizardStep2_GetDisplayCoordinates: Destroy
     Gui, WizardStep3_PlotMatrixOfButtons: Margin, % ButtonHorizontalMargin, % ButtonVerticalMargin

     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "xm"  . " ym"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_1
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_2
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_3
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_4
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_5
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_6
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_7
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_8
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_9
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_10
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_11
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 1_12

     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "xm"  . " y+m"                       . " w" . ButtonWidth . " h" . ButtonHeight, 2_1
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_2
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_3
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_4
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_5
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_6
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_7
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_8
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_9
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_10
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_11
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 2_12

     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "xm"  . " y+m"                       . " w" . ButtonWidth . " h" . ButtonHeight, 3_1
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_2
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_3
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_4
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_5
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_6
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_7
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_8
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_9
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_10
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_11
     Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, 3_12


     Gui, WizardStep3_PlotMatrixOfButtons: Show
     , % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle
return

     ;~ ButtonWidth            := 80
     ;~ ButtonHeight           := 80
     ;~ ButtonHorizontalMargin := 20
     ;~ ButtonVerticalMargin   := 20

     ;~ ButtonHorizontalMargin := 20
     ;~ ButtonVerticalMargin   := 20

; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_ShowDisplayNumbers()

{
     global HowManyMonitors, WhichIsPrimary
     global SM_CXVIRTUALSCREEN, SM_CYVIRTUALSCREEN, SM_XVIRTUALSCREEN, SM_YVIRTUALSCREEN
     global MonitorBoundingCoordinates_
     global MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Right, MonitorBoundingCoordinates_Top, MonitorBoundingCoordinates_Bottom


	 ;~ SysGet, WhichIsPrimary,        MonitorPrimary
     ;~ SysGet, VirtualScreenWidth,    % SM_CXVIRTUALSCREEN
     ;~ SysGet, VirtualScreenHeight,   % SM_CYVIRTUALSCREEN
     ;~ SysGet, VirtualScreenTop,      % SM_XVIRTUALSCREEN
     ;~ SysGet, VirtualScreenLeft,     % SM_YVIRTUALSCREEN

     Loop, %HowManyMonitors%
          {
          ;~ SysGet, vMonitorName, MonitorName, %A_Index%
		  SysGet, MonitorBoundingCoordinates_, Monitor, %A_Index%
          ;~ MonitorWidth := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
          ;~ MonitorHeight := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom)
          Gui, %A_Index%:-SysMenu -Caption +Border
          Gui, %A_Index%:Color, Black ; WindowColor, ControlColor
          Gui, %A_Index%:Font, cWhite s26 bold, Calibri
          Gui, %A_Index%:Add, Text, x150 y150 w150 h150, % A_Index ; to działa
          ;~ x2 := MonitorBoundingCoordinates_Left + (MonitorWidth / 2) - (300 / 2)
          ;~ y2 := MonitorBoundingCoordinates_Top + (MonitorHeight / 2) - (300 / 2)
          ;~ Gui, %A_Index%:Show, % "x"x2 "y"y2 "w300" "h300"
          Gui, % A_Index . ":Show", % "x" .  MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (300 / 2) . "y" 
          . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (300 / 2) . "w300" . "h300"
          }
return
}

; ------------------------------- SECTION OF LABELS --------------------------------------


DestroyGuis:
     Loop, %HowManyMonitors%
          {
          Gui, %A_Index%:Destroy
          }
     Gui, Font ; restore the font to the system's default GUI typeface, zize and color.
return

CheckDisplayNumbering:
     F_ShowDisplayNumbers()
     SetTimer, DestroyGuis, -3000     
return

ButtonNext1out3:
     Gui, WizardStep1_GetDisplayCoordinates:Submit, NoHide
     MsgBox, % DisplayRadioGroup
return