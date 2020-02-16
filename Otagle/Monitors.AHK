#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent

     ; constants
     SM_CXVIRTUALSCREEN := 78
     SM_CYVIRTUALSCREEN := 79
     SM_XVIRTUALSCREEN := 76
     SM_YVIRTUALSCREEN := 77

SysGet, HowManyMonitors,       MonitorCount
SysGet, WhichIsPrimary,        MonitorPrimary

Gui, WizardStep0_Intro: Font, bold
Gui, WizardStep0_Intro: Add, Text, w500, Introduction
Gui, WizardStep0_Intro: Font, 
Gui, WizardStep0_Intro: Add, Text, w500, When there is no otagle.ini file or on purspose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 sets of questions related to settings of display.
Gui, WizardStep0_Intro: Add, Text, w500, Step 1: `t`tChoose a display where GUI of OTAGLE is located.
Gui, WizardStep0_Intro: Add, Text, w500, Step 2: `t`tCheck display orientation, set scaling to 1.
Gui, WizardStep0_Intro: Add, Text, w500, Step 3: `t`tAdjust number of keys visible on the screen (rows and columns).
Gui, WizardStep0_Intro: Add, Button, Default x+-350 y+20 w80 gToStep1, &Next
Gui, WizardStep0_Intro: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
Gui, WizardStep0_Intro: Show, , O T A G L E Display Wizard
return 


ToStep1:
Gui, WizardStep0_Intro: Destroy
Gui, WizardStep1_GetDisplayCoordinates: Font, bold
Gui, WizardStep1_GetDisplayCoordinates: Add, Text, w500, Step 1 out of 3: `t`tChoose a display where GUI of OTAGLE is located.
Gui, WizardStep1_GetDisplayCoordinates: Font
Gui, WizardStep1_GetDisplayCoordinates: Add, Text, w500, Specify one out of the available Display No.

Loop, % HowManyMonitors
     {
     if (A_Index = 1 && A_Index = WhichIsPrimary)
          {
          Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, y+30 AltSubmit vDisplayRadioGroup Checked, % "Display #" . A_Index
          }
     else if (A_Index = 1)
          {
          Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, y+30 AltSubmit vDisplayRadioGroup, % "Display #" . A_Index
          }
     else if (A_Index = WhichIsPrimary)
          {
          Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, AltSubmit Checked, % "Display #" . A_Index
          }
     else
          {
          Gui, WizardStep1_GetDisplayCoordinates: Add, Radio, AltSubmit, % "Display #" . A_Index
          }
     }     
Gui, WizardStep1_GetDisplayCoordinates: Add, Button, Default x+25 y+20 gCheckDisplayNumbering, &CheckDisplayNumbering
Gui, WizardStep1_GetDisplayCoordinates: Add, Button, x+30 w80 gToStep2, &Next
Gui, WizardStep1_GetDisplayCoordinates: Add, Button, x+30 w80 gExitDisplayConfigurationWizard, &Cancel
Gui, WizardStep1_GetDisplayCoordinates: Show, , O T A G L E Display Wizard
return

ToStep2:
Gui, WizardStep1_GetDisplayCoordinates: Destroy
Gui, WizardStep2_GetDisplayCoordinates: Font, bold
Gui, WizardStep2_GetDisplayCoordinates: Add, Text, w500, Step 2: `t`tCheck display orientation, set scaling to 1.
Gui, WizardStep2_GetDisplayCoordinates: Font
SysGet, ,, % DisplayRadioGroup
return

ExitDisplayConfigurationWizard:
Gui, WizardStep0_Intro: Destroy
ExitApp

; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_ShowDisplayNumbers()

{
     global HowManyMonitors, WhichIsPrimary
     global SM_CXVIRTUALSCREEN, SM_CYVIRTUALSCREEN, SM_XVIRTUALSCREEN, SM_YVIRTUALSCREEN


	 ;~ SysGet, WhichIsPrimary,        MonitorPrimary
     SysGet, VirtualScreenWidth,    % SM_CXVIRTUALSCREEN
     SysGet, VirtualScreenHeight,   % SM_CYVIRTUALSCREEN
     SysGet, VirtualScreenTop,      % SM_XVIRTUALSCREEN
     SysGet, VirtualScreenLeft,     % SM_YVIRTUALSCREEN

     Loop, %HowManyMonitors%
          {
          SysGet, vMonitorName, MonitorName, %A_Index%
		  SysGet, MonitorBoundingCoordinates_, Monitor, %A_Index%
          ;~ MonitorWidth := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
          ;~ MonitorHeight := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom)
          Gui, %A_Index%:-SysMenu -Caption +Border
          Gui, %A_Index%:Color, Black ; WindowColor, ControlColor
          Gui, %A_Index%:Font, cWhite s26 bold, Calibri
          Gui, %A_Index%:Add, Text, x150 y150 w150 h150, % A_Index ; to dzia³a
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