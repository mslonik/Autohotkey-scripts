#NoEnv
#SingleInstance, Force
#Include lib/Neutron.ahk
#Include ButtonFunctions.ahk 
#Include GuiGenerator.ahk
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%

; Global variables
     CurrentLayer                           := 1
     HowManyLayers                          := 1
     WhichMonitor                           := 0
     ApplicationName                        := "O T A G L E"
     WindowWizardTitle                      := ApplicationName . " Configuration Wizard"

     T_CalculateButton                      := 0 ; 0 ← no, do not calculate button position, 1 ← yes, calculate button position
     T_Reload                               := 0 ; 0 ← no, do not Reload the main script (Otagle.ahk), 1 ← yes, reload the main script, because content of ButtonFunctions.ahk has been updated

     ButtonWidth                            := 80   ; default / starting value for button width
     ButtonHeight                           := 80   ; default / starting value for button height
     ButtonHorizontalGap                    := 10   ; default / starting value for "horizontal gap", the area of bottom margin
     ButtonVerticalGap                      := 10   ; default / starting value for "vertical gap", the area of left margin 
     
     MonitorBoundingCoordinates_Left        := 0
     MonitorBoundingCoordinates_Right       := 0
     MonitorBoundingCoordinates_Top         := 0
     MonitorBoundingCoordinates_Bottom      := 0
     ReadButtonPosX                         := 0
     ReadButtonPosY                         := 0
     ReadButtonPosW                         := 0
     ReadButtonPosH                         := 0
     MenuVar                                := 0
	HowManyMonitors                        := 0



; F_DisplayLayer(CurrentLayer)
; StartOtagle(var, var2){
neutron := new NeutronWindow()
; MsgBox, %var2%
neutron.Load("PlikiHtml/Layer1.html")
; neutron.Load(var)
neutron.Gui("+LabelNeutron")
neutron.Show("w1024 h768")
return
FileInstall, Otagle.html, Otagle.html
; }



F_DisplayLayer(CurrentLayer){
;     IniRead, HowManyLayers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers   
;      if (HowManyLayers > 1){
;           Loop, % HowManyLayers{
;                indexPage := A_Index
;                if (indexPage = pages){
;                     Layers := % "PlikiHtml/Layer" . A_Index . ".html"
;                     StartOtagle(Layers,indexPage)
;                }
;           }
;      } 
     CurrentLayer := 0
}



ClickF(neutron,event,action){
   
   SplitPath, % action, FunctionName
     FunctionName := SubStr(FunctionName, 1, StrLen(FunctionName)-4)
     %FunctionName%()
   return

  F_DisplayLayer(CurrentLayer)
}

Monitor(neutron, event)
{
L_ConfigureMonitor:
   T_CalculateButton := 0
     Gui, ConfigureMonitor: Submit, NoHide ; required to refresh Radio button
     Gui, ConfigureMonitor: Destroy        ; required to recreate the ConfigureMonitor GUI
     
     Gui, ConfigureMonitor: New, +LabelMyGui_On
     Gui, ConfigureMonitor: Font, bold
     Gui, ConfigureMonitor: Add, Text, w500, Choose a monitor where GUI will be located.
     Gui, ConfigureMonitor: Font
     Gui, ConfigureMonitor: Add, Text, w500, Specify one out of the available Monitor No.
     

     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
     
     if (WhichMonitor = 0) 
          WhichMonitor := WhichIsPrimary
     
     Loop, % HowManyMonitors
          {
          if (A_Index = WhichMonitor)
               Gui, ConfigureMonitor: Add, Radio, xm+50 gL_ConfigureMonitor AltSubmit vWhichMonitor Checked, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
          else
               Gui, ConfigureMonitor: Add, Radio, xm+50 gL_ConfigureMonitor AltSubmit, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
          }     

     Gui, ConfigureMonitor: Add, Button, Default xm+30 y+20 gCheckMonitorNumbering, &Check Monitor Numbering
	Gui, ConfigureMonitor: Add, Button, x+30 w80 gL_ConfigureMonitor_Cancel,    &Cancel


 SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor    
    DetectHiddenWindows, On
    Gui, ConfigureMonitor: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     Gui, ConfigureMonitor:-DPIScale
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt     
     DetectHiddenWindows, Off
     Gui, ConfigureMonitor: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle . " ConfigureMonitor"
return
}


CheckMonitorNumbering:

     F_ShowMonitorNumbers()
     SetTimer, DestroyGuis, -3000
return

F_ShowMonitorNumbers()

{

    global
	SysGet, HowManyMonitors, MonitorCount
	
     Loop, %HowManyMonitors%
          {
          SysGet, MonitorBoundingCoordinates_, Monitor, %A_Index%
          MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
          MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
          MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
          MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))
          Gui, %A_Index%:-SysMenu -Caption +Border
          Gui, %A_Index%:Color, Black ; WindowColor, ControlColor
          Gui, %A_Index%:Font, cWhite s26 bold, Calibri
          Gui, %A_Index%:Add, Text, x140 y140 w150 h150, % A_Index
          Gui, % A_Index . ":Show", % "x" .  MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (300 / 2) . "y" 
          . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (300 / 2) . "w300" . "h300"
          }
return
}

L_ConfigureMonitor_Cancel:
     Gui, ConfigureMonitor: Destroy
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