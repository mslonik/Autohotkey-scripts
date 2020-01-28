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

Gui, GetDisplayCoordinates:Font, bold
Gui, GetDisplayCoordinates:Add, Text, , Step 1 out of 3:
Gui, GetDisplayCoordinates:Font
Gui, GetDisplayCoordinates:Add, Text, , Specify Display No.

Loop, % HowManyMonitors
     {
     if (A_Index = 1 && A_Index = WhichIsPrimary)
          {
          Gui, GetDisplayCoordinates:Add, Radio, AltSubmit vDisplayRadioGroup Checked, % "Display #" . A_Index
          }
     else if (A_Index = 1)
          {
          Gui, GetDisplayCoordinates:Add, Radio, AltSubmit vDisplayRadioGroup, % "Display #" . A_Index
          }
     else if (A_Index = WhichIsPrimary)
          {
          Gui, GetDisplayCoordinates:Add, Radio, AltSubmit Checked, % "Display #" . A_Index
          }
     else
          {
          Gui, GetDisplayCoordinates:Add, Radio, AltSubmit, % "Display #" . A_Index
          }
     }     
Gui, GetDisplayCoordinates:Add, Button, gCheckDisplayNumbering, CheckDisplayNumbering
Gui, GetDisplayCoordinates:Add, Button, gButtonNext1out3, Next
Gui, GetDisplayCoordinates:Show, w300, O T A G L E Configurator

return

; ---------------------------------------------------------------------

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

; ---------------------------------------------------------------------

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
     Gui, GetDisplayCoordinates:Submit, NoHide
     MsgBox, % DisplayRadioGroup
return