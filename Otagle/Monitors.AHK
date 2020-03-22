#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent

     DisplayRadioGroup      := 0
     WindowWizardTitle      := "O T A G L E Display Wizard"
     ButtonWidth            := 80
     ButtonHeight           := 80
     ButtonHorizontalGap    := 10
     ButtonVerticalGap      := 10
     
;~ Goto, ToStep2

Gui, WizardStep0_Intro: Font, bold
Gui, WizardStep0_Intro: Add, Text, w500, Introduction
Gui, WizardStep0_Intro: Font, 
Gui, WizardStep0_Intro: Add, Text, w500, When there is no otagle.ini file or on purspose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 sets of questions related to settings of display.
Gui, WizardStep0_Intro: Add, Text, w500, Step 1: `t`tChoose a display where GUI of OTAGLE is located.
Gui, WizardStep0_Intro: Add, Text, w500, Step 2: `t`tCheck display orientation, set scaling to 1.
Gui, WizardStep0_Intro: Add, Text, w500, Step 3: `t`tAdjust number of keys visible on the screen (rows and columns).
Gui, WizardStep0_Intro: Add, Button, Default xm+50 w80 gToStep1, &Next
Gui, WizardStep0_Intro: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
Gui, WizardStep0_Intro: Show, , % WindowWizardTitle
WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return 


ToStep1:
     Gui, WizardStep0_Intro: Destroy
     Gui, WizardWindow_GetDisplayCoordinates: Submit, NoHide
     Gui, WizardWindow_GetDisplayCoordinates: Destroy
     MsgBox, % DisplayRadioGroup
     
     Gui, WizardWindow_GetDisplayCoordinates: Font, bold
     Gui, WizardWindow_GetDisplayCoordinates: Add, Text, w500, Step 1 out of 3: `t`tChoose a display where GUI of OTAGLE is located.
     Gui, WizardWindow_GetDisplayCoordinates: Font
     Gui, WizardWindow_GetDisplayCoordinates: Add, Text, w500, Specify one out of the available Display No.

     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
     SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     
     if (DisplayRadioGroup = 0) 
          DisplayRadioGroup := WhichIsPrimary
     
     Loop, % HowManyMonitors
          {
          ;~ if (A_Index = WhichIsPrimary)
          if (A_Index = DisplayRadioGroup)
               ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Radio, gWizardWindow_Radio AltSubmit vDisplayRadioGroup Checked, % "Monitor #" . A_Index
               Gui, WizardWindow_GetDisplayCoordinates: Add, Radio, gToStep1 AltSubmit vDisplayRadioGroup Checked, % "Monitor #" . A_Index
          else
               ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Radio, gWizardWindow_Radio AltSubmit, % "Monitor #" . A_Index
               Gui, WizardWindow_GetDisplayCoordinates: Add, Radio, gToStep1 AltSubmit, % "Monitor #" . A_Index
          }     
     Gui, WizardWindow_GetDisplayCoordinates: Add, Button, Default x+25 y+20 gCheckDisplayNumbering, &CheckDisplayNumbering
     Gui, WizardWindow_GetDisplayCoordinates: Add, Button, x+30 w80 gToStep2, &Next
     Gui, WizardWindow_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Show, , % WindowWizardTitle
     Gui, WizardWindow_GetDisplayCoordinates: Show
     , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return

ExitDisplayConfigurationWizard:
     Gui, WizardStep0_Intro: Destroy
ExitApp

;~ WizardWindow_Radio:
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Submit, NoHide
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Destroy

     ;~ SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Font, bold
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Text, w500, Step 1 out of 3: `t`tChoose a display where GUI of OTAGLE is located.
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Font
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Text, w500, Specify one out of the available Display No.
     ;~ Loop, % HowManyMonitors
          ;~ {
          ;~ if (A_Index = DisplayRadioGroup)
               ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Radio, gWizardWindow_Radio AltSubmit vDisplayRadioGroup Checked, % "Monitor #" . A_Index
          ;~ else
               ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Radio, gWizardWindow_Radio AltSubmit, % "Monitor #" . A_Index
          ;~ }
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Button, Default x+25 y+20 gCheckDisplayNumbering, &CheckDisplayNumbering
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Button, x+30 w80 gToStep2, &Next
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     
     ;~ Gui, WizardWindow_GetDisplayCoordinates: Show
     ;~ , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
       ;~ . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
     ;~ WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
;~ return


ToStep2:
     Gui, WizardWindow_GetDisplayCoordinates: Submit, NoHide
     ;~ SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     Gui, WizardWindow_GetDisplayCoordinates: Destroy
     
     CalculateButtonsAndGaps()
     Gui, WizardStep2_GetDisplayCoordinates: Font, bold
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, , Step 2: `t`tDisplay Width and Height in pixels.
     Gui, WizardStep2_GetDisplayCoordinates: Font
     ;~ WizardStep2_Width := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
     ;~ WizardStep2_Height := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) 
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, y+20
          , % "Monitor: " . DisplayRadioGroup . " Width: " .  WizardStep2_Width 
          . " Height: " . WizardStep2_Height . " Suggested size of key: 80x80 px and gap size: 20x20 px."
          
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, xm, % "Number of keys horizontally: " . WizardStep2_AmountOfKeysHorizontally . " and not used margin at the left side: " . WizardStep2_MarginHorizontally
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, xm, % "Number of keys vertically: " . WizardStep2_AmountOfKeysVertically . " and not used margin at the bottom side: " . WizardStep2_MarginVertically
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, xm, Specify key size width: `
     Gui, WizardStep2_GetDisplayCoordinates: Add, Edit, x+m yp r1 vKeySizeWidth w50, % ButtonWidth
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, x+m yp, Specify key size height: `
     Gui, WizardStep2_GetDisplayCoordinates: Add, Edit, x+m yp r1 vKeySizeHeight w50, % ButtonHeight
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, xm, Specify horizontal gap between buttons: `
     Gui, WizardStep2_GetDisplayCoordinates: Add, Edit, x+m yp r1 vGapSizeWidth w50, % ButtonHorizontalGap
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, x+m yp, Specify vertical gap between buttons: `
     Gui, WizardStep2_GetDisplayCoordinates: Add, Edit, x+m yp r1 vGapSizeHeight w50, % ButtonVerticalGap

     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, Default x50 y+20 w80 gToStep3, &Test
     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, x+30 w80 gSaveDisplayConfigurationWizard, &Save Config
     Gui, WizardStep2_GetDisplayCoordinates: Show
     , % "x" . MonitorBoundingCoordinates_Left + (WizardStep2_Width / 2) - (WizardWindow_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (WizardStep2_Height / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
return


ToStep3:
     SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     Gui, WizardStep2_GetDisplayCoordinates: Submit, NoHide
     ;~ MsgBox, % "KeySizeWidth: " . KeySizeWidth . " KeySizeHeight: " . KeySizeHeight . " KeySizeWidth: " . GapSizeWidth . " KeySizeHeight: " . GapSizeHeight
     ButtonWidth := KeySizeWidth, ButtonHeight := KeySizeHeight, ButtonHorizontalGap := GapSizeWidth, ButtonVerticalGap := GapSizeHeight
     Gui, WizardStep2_GetDisplayCoordinates: Destroy
     
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
     GoTo, ToStep2
return

     ;~ ButtonWidth            := 80
     ;~ ButtonHeight           := 80
     ;~ ButtonHorizontalGap := 20
     ;~ ButtonVerticalGap   := 20

; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_ShowDisplayNumbers()

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
     global DisplayRadioGroup, ButtonWidth, ButtonHeight, ButtonHorizontalGap, ButtonVerticalGap
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % DisplayRadioGroup
     WizardStep2_Width := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
     WizardStep2_Height := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) 
     WizardStep2_AmountOfKeysHorizontally := (WizardStep2_Width -  ButtonHorizontalGap) // ( ButtonWidth + ButtonHorizontalGap)
     WizardStep2_MarginHorizontally := WizardStep2_Width - (WizardStep2_AmountOfKeysHorizontally * ButtonHorizontalGap + WizardStep2_AmountOfKeysHorizontally * ButtonWidth + ButtonHorizontalGap)
     WizardStep2_AmountOfKeysVertically := (WizardStep2_Height - ButtonVerticalGap) // (ButtonHeight + ButtonVerticalGap)
     WizardStep2_MarginVertically := WizardStep2_Height - (WizardStep2_AmountOfKeysVertically * ButtonVerticalGap + WizardStep2_AmountOfKeysVertically * ButtonHeight + ButtonVerticalGap)
     }


; ------------------------------- SECTION OF LABELS --------------------------------------

SaveDisplayConfigurationWizard:

return


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
     Gui, WizardWindow_GetDisplayCoordinates:Submit, NoHide
     MsgBox, % DisplayRadioGroup
return