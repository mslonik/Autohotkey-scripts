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
     ;~ MsgBox, % "Width: " . WizardStep1_Width . " Height: " . WizardStep1_Height
return

ExitDisplayConfigurationWizard:
     Gui, WizardStep0_Intro: Destroy
ExitApp

WizardStep1_Radio:
     Gui, WizardStep1_GetDisplayCoordinates: Submit, NoHide
     ;~ MsgBox, % "vDisplayRadioGroup: " . DisplayRadioGroup
     Gui, WizardStep1_GetDisplayCoordinates: Destroy
     SysGet, MonitorBoundingCoordinates_, Monitor, %DisplayRadioGroup%
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
     SysGet, MonitorBoundingCoordinates_, Monitor, %DisplayRadioGroup%
     ;~ MsgBox, % DisplayRadioGroup
     Gui, WizardStep1_GetDisplayCoordinates: Destroy
     Gui, WizardStep2_GetDisplayCoordinates: Font, bold
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, w500, Step 2: `t`tDisplay Width and Height in pixels.
     Gui, WizardStep2_GetDisplayCoordinates: Font
     Gui, WizardStep2_GetDisplayCoordinates: Add, Text, y+20
     , % "Monitor: " . DisplayRadioGroup . " Width: " . Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) 
     . " Height: " . Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom)
     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, Default x50 y+20 w80 gToStep3, &Next
     Gui, WizardStep2_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
     Gui, WizardStep2_GetDisplayCoordinates: Show
     , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardStep1_Width / 2) 
       . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardStep1_Height / 2), % WindowWizardTitle
return


ToStep3:

return

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