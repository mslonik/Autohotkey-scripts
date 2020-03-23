#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent

     MonitorRadioGroup      := 0
     WindowWizardTitle      := "O T A G L E Configuration Wizard"
     ButtonWidth            := 80
     ButtonHeight           := 80
     ButtonHorizontalGap    := 10
     ButtonVerticalGap      := 10
     
Wizard_Intro:
     Gui, Wizard_Intro: Font, bold
     Gui, Wizard_Intro: Add, Text, w500, Introduction
     Gui, Wizard_Intro: Font, 
     Gui, Wizard_Intro: Add, Text, w500, When there is no otagle.ini file or on purspose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 questions related to settings of monitor.
     Gui, Wizard_Intro: Add, Text, w500, Step 1: `t`tChoose a monitor where GUI of OTAGLE is located.
     Gui, Wizard_Intro: Add, Text, w500, Step 2: `t`tCheck monitor size, specify amount and size of buttons.
     Gui, Wizard_Intro: Add, Text, w500, Step 3: `t`tAdjust number of keys visible on the screen (rows and columns).
     Gui, Wizard_Intro: Add, Button, % "Default xm+" . 500//3 . " w80 gWizardStep1", &Next
     Gui, Wizard_Intro: Add, Button, x+30 w80 gExitWizard, &Cancel
     Gui, Wizard_Intro: Show, , % WindowWizardTitle
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return 


WizardStep1:
     Gui, Wizard_Intro:    Destroy
     Gui, Wizard_WhereGUI: Submit, NoHide
     Gui, Wizard_WhereGUI: Destroy
     
     Gui, Wizard_WhereGUI: Font, bold
     Gui, Wizard_WhereGUI: Add, Text, w500, Step 1 out of 3: `t`tChoose a monitor where GUI of OTAGLE will be located.
     Gui, Wizard_WhereGUI: Font
     Gui, Wizard_WhereGUI: Add, Text, w500, Specify one out of the available Monitor No.

     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
     SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup
     
     if (MonitorRadioGroup = 0) 
          MonitorRadioGroup := WhichIsPrimary
     
     Loop, % HowManyMonitors
          {
          if (A_Index = MonitorRadioGroup)
          ;~ if (A_Index = WhichIsPrimary)
               Gui, Wizard_WhereGUI: Add, Radio, xm+50 gWizardStep1 AltSubmit vMonitorRadioGroup Checked, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary) ? (" (primary)") : ("") 
          else
               Gui, Wizard_WhereGUI: Add, Radio, xm+50 gWizardStep1 AltSubmit, % "Monitor #" . A_Index
          }     
     Gui, Wizard_WhereGUI: Add, Button, Default xm+30 y+20 gCheckMonitorNumbering, &Check Monitor Numbering
     Gui, Wizard_WhereGUI: Add, Button, x+30 w80 gWizardStep2, &Next
     Gui, Wizard_WhereGUI: Add, Button, x+30 w80 gWizard_Intro, &Back
     Gui, Wizard_WhereGUI: Add, Button, x+30 w80 gExitWizard, &Cancel
     Gui, Wizard_WhereGUI: Show
     , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return


WizardStep2:
     Gui, Wizard_WhereGUI: Submit, NoHide
     ;~ SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup
     Gui, Wizard_WhereGUI: Destroy
     
     CalculateButtonsAndGaps()
     Gui, Wizard_AmountAndSizeOfButtons: Font, bold
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, , Step 2: `t`tCheck monitor size, specify amount and size of buttons.
     Gui, Wizard_AmountAndSizeOfButtons: Font
     ;~ WizardStep2_Width := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
     ;~ WizardStep2_Height := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) 
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, y+20
          , % "Monitor: " . MonitorRadioGroup . " Width: " .  WizardStep2_Width 
          . " Height: " . WizardStep2_Height . " Suggested size of key: 80x80 px and gap size: 20x20 px."
          
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, % "Number of keys horizontally: " . WizardStep2_AmountOfKeysHorizontally . " and not used margin at the left side: " . WizardStep2_MarginHorizontally
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, % "Number of keys vertically: " . WizardStep2_AmountOfKeysVertically . " and not used margin at the bottom side: " . WizardStep2_MarginVertically
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, Specify key size width: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 vKeySizeWidth w50, % ButtonWidth
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, x+m yp, Specify key size height: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 vKeySizeHeight w50, % ButtonHeight
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, Specify horizontal gap between buttons: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 vGapSizeWidth w50, % ButtonHorizontalGap
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, x+m yp, Specify vertical gap between buttons: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 vGapSizeHeight w50, % ButtonVerticalGap

     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, Default x50 y+20 w80 gToStep3, &Test
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, x+30 w80 gExitWizard, &Cancel
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, x+30 w80 gSaveConfigurationWizard, &Save Config
     Gui, Wizard_AmountAndSizeOfButtons: Show
     , % "x" . MonitorBoundingCoordinates_Left + (WizardStep2_Width / 2) - (WizardWindow_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (WizardStep2_Height / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
return


ToStep3:
     SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup
     Gui, Wizard_AmountAndSizeOfButtons: Submit, NoHide
     ;~ MsgBox, % "KeySizeWidth: " . KeySizeWidth . " KeySizeHeight: " . KeySizeHeight . " KeySizeWidth: " . GapSizeWidth . " KeySizeHeight: " . GapSizeHeight
     ButtonWidth := KeySizeWidth, ButtonHeight := KeySizeHeight, ButtonHorizontalGap := GapSizeWidth, ButtonVerticalGap := GapSizeHeight
     Gui, Wizard_AmountAndSizeOfButtons: Destroy
     
     Gui, WizardStep3_PlotMatrixOfButtons: Margin, % ButtonHorizontalGap, % ButtonVerticalGap

     Loop, % WizardStep2_AmountOfKeysVertically
          {
          ExternalLoopIndex := A_Index
          Loop, % WizardStep2_AmountOfKeysHorizontally
               {
               if (A_Index = 1)
                    Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "xm"  . " y+m"                       . " w" . ButtonWidth . " h" . ButtonHeight, % ExternalLoopIndex . "_" . A_Index
               else ; (A_Index > 1)
                    Gui, WizardStep3_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"                        . " w" . ButtonWidth . " h" . ButtonHeight, % ExternalLoopIndex . "_" . A_Index
               }
          }

     Gui, WizardStep3_PlotMatrixOfButtons: Show
     , % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle
     MsgBox, Press any key to continue
     Gui, WizardStep3_PlotMatrixOfButtons: Destroy
     GoTo, WizardStep2
return

     ;~ ButtonWidth            := 80
     ;~ ButtonHeight           := 80
     ;~ ButtonHorizontalGap := 20
     ;~ ButtonVerticalGap   := 20
SaveConfigurationWizard:

return

CheckMonitorNumbering:
     F_ShowMonitorNumbers()
     SetTimer, DestroyGuis, -3000     
return

DestroyGuis:
     Loop, %HowManyMonitors%
          {
          Gui, %A_Index%:Destroy
          }
     Gui, Font ; restore the font to the system's default GUI typeface, zize and color.
return


ExitWizard:
ExitApp


; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_ShowMonitorNumbers()

{
     global HowManyMonitors, WhichIsPrimary
     global SM_CXVIRTUALSCREEN, SM_CYVIRTUALSCREEN, SM_XVIRTUALSCREEN, SM_YVIRTUALSCREEN
     global MonitorBoundingCoordinates_
     global MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Right, MonitorBoundingCoordinates_Top, MonitorBoundingCoordinates_Bottom


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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

CalculateButtonsAndGaps()     
     {
     global WizardStep2_Width, WizardStep2_Height, WizardStep2_AmountOfKeysHorizontally, WizardStep2_MarginHorizontally, WizardStep2_AmountOfKeysVertically, WizardStep2_MarginVertically
     global MonitorBoundingCoordinates_, MonitorBoundingCoordinates_Bottom, MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Right, MonitorBoundingCoordinates_Top
     global MonitorRadioGroup, ButtonWidth, ButtonHeight, ButtonHorizontalGap, ButtonVerticalGap
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup
     WizardStep2_Width := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
     WizardStep2_Height := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) 
     WizardStep2_AmountOfKeysHorizontally := (WizardStep2_Width -  ButtonHorizontalGap) // ( ButtonWidth + ButtonHorizontalGap)
     WizardStep2_MarginHorizontally := WizardStep2_Width - (WizardStep2_AmountOfKeysHorizontally * ButtonHorizontalGap + WizardStep2_AmountOfKeysHorizontally * ButtonWidth + ButtonHorizontalGap)
     WizardStep2_AmountOfKeysVertically := (WizardStep2_Height - ButtonVerticalGap) // (ButtonHeight + ButtonVerticalGap)
     WizardStep2_MarginVertically := WizardStep2_Height - (WizardStep2_AmountOfKeysVertically * ButtonVerticalGap + WizardStep2_AmountOfKeysVertically * ButtonHeight + ButtonVerticalGap)
     }