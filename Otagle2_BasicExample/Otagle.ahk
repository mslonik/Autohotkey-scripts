/*
Author:      Maciej Słojewski, mslonik, http://mslonik.pl
Purpose:     Facilitate normal operation for company desktop.
Description: Hotkeys and hotstrings for my everyday professional activities and office cockpit.
License:     GNU GPL v.3
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  							; Enable warnings to assist with detecting common errors. Commented out because of Class_ImageButton.ahk
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent
#Include *i %A_ScriptDir%\ButtonFunctions.ahk ; ← Functions to be included
#Include %A_ScriptDir%\Core\Class_ImageButton.ahk                  ; Buttons with pictures https://github.com/AHK-just-me/Class_ImageButton


; The naming convention applied in this script
; F_* ← Function 
; L_* ← Label
; T_* ← Toggle two state variable to remeber specific setting

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

;~ DetectHiddenWindows, On ; Caution! Extremely dangerous. May stop working existing parts of a script. Use only if you know what you're doing.

if !FileExist(A_ScriptDir . "\Config.ini")
     {
     MsgBox, 4, %ApplicationName%: %A_ScriptName%, No Config.ini file has been found in the script directory:`r`n`r`n%A_ScriptDir%`r`n`r`nExpected the Config.ini file
                   .`r`n`r`nDo you want to run %WindowWizardTitle% which will help you to create Config.ini? `r`n`r`n
    IfMsgBox, No
        ExitApp, 0
    IfMsgBox, Yes
        Goto  Wizard_Intro
     }
else
     Goto StartOtagle

Wizard_Intro:
     FileRecycle, %A_ScriptDir%\ButtonFunctions.ahk ; remove ButtonFunctions.ahk
     FileRecycle, %A_ScriptDir%\Config.ini          ; remove old Config.ini. Perhaps warning should be added
     F_WizardIntro()
return 


WizardStep1:
     T_CalculateButton := 0
     Gui, Wizard_Intro:    Destroy
     Gui, WizardStep2: Destroy
     Gui, WizardStep1: Submit, NoHide
     Gui, WizardStep1: Destroy
     
     Gui, WizardStep1: New, +LabelMyGui_On
     Gui, WizardStep1: Font, bold
     Gui, WizardStep1: Add, Text, w500, Step 1 out of 3: `t`tChoose a monitor where GUI will be located.
     Gui, WizardStep1: Font
     Gui, WizardStep1: Add, Text, w500, Specify one out of the available Monitor No.

     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
     
     if (WhichMonitor = 0) 
          WhichMonitor := WhichIsPrimary
     
     Loop, % HowManyMonitors
          {
          if (A_Index = WhichMonitor)
               Gui, WizardStep1: Add, Radio, xm+50 gWizardStep1 AltSubmit vWhichMonitor Checked, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
          else
               Gui, WizardStep1: Add, Radio, xm+50 gWizardStep1 AltSubmit, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
          }     

     Gui, WizardStep1: Add, Button, Default xm+30 y+20 gCheckMonitorNumbering,  &Check Monitor Numbering
     Gui, WizardStep1: Add, Button, x+30 w80 gWizardStep2,                      &Next
     Gui, WizardStep1: Add, Button, x+30 w80 gWizard_Intro,                     &Back
     Gui, WizardStep1: Add, Button, x+30 w80 gExitWizard,                       &Cancel
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     Gui, WizardStep1: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle . " Layer " . CurrentLayer
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return


WizardStep2:
     Gui, WizardStep1: Destroy
     
     Gui, WizardStep2: New, +LabelMyGui_On -DPIScale
     Gui, WizardStep2: Font, bold
     Gui, WizardStep2: Add, Text, , Step 2: `t`tSpecify amount and size of buttons
     Gui, WizardStep2: Font
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))
     Gui, WizardStep2: Add, Text, y+20
          , % "Monitor #: " . WhichMonitor . "`tMonitor width: " . Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
          . "`tMonitor height: " . Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) . " Suggested size of key: 80x80 px and gap size: 20x20 px."
          
     Gui, WizardStep2: Add, Text, xm, Specify key size width: `
     Gui, WizardStep2: Add, Edit, x+m yp r1 w50
     Gui, WizardStep2: Add, UpDown, vButtonWidth Range1-300, % ButtonWidth
     Gui, WizardStep2: Add, Text, x+m yp, Specify key size height: `
     Gui, WizardStep2: Add, Edit, x+m yp r1 w50
     Gui, WizardStep2: Add, UpDown, vButtonHeight Range1-300, % ButtonHeight
     Gui, WizardStep2: Add, Text, xm, Specify horizontal gap between buttons: `
     Gui, WizardStep2: Add, Edit, x+m yp r1 w50
     Gui, WizardStep2: Add, UpDown, vButtonHorizontalGap Range0-300, % ButtonHorizontalGap
     Gui, WizardStep2: Add, Text, x+m yp, Specify vertical gap between buttons: `
     Gui, WizardStep2: Add, Edit, x+m yp r1 w50
     Gui, WizardStep2: Add, UpDown, vButtonVerticalGap Range0-300, % ButtonVerticalGap
     Gui, WizardStep2: Add, Button, xm Default w80 gBCalculate, C&alculate 
     Gui, WizardStep2: Add, Text, xm, % "Number of keys horizontally:`t" . (T_CalculateButton ? WizardStep2_AmountOfKeysHorizontally : "") 
          . "`tNot used margin at the left side in px:`t" . (T_CalculateButton ? WizardStep2_MarginHorizontally : "") . "`t"
     Gui, WizardStep2: Add, Text, yp x+m, Write the title of the layer:
     Gui, WizardStep2: Add, Text, xm, % "Number of keys vertically:`t" . (T_CalculateButton ? WizardStep2_AmountOfKeysVertically : "") 
          . "`tNot used margin at the bottom side in px:`t" . (T_CalculateButton ? WizardStep2_MarginVertically : "") . "`t"
     Gui, WizardStep2: Add, Edit, yp x+m w120 vTitle, %Title%
     Gui, WizardStep2: Add, Button, x50 y+20 w80 gPlotButtons hwndTestButtonHwnd,       &Test
     Gui, WizardStep2: Add, Button, x+30 w80 gWizardStep1,                              &Back
     Gui, WizardStep2: Add, Button, x+30 w80 gExitWizard,                               &Cancel
     Gui, WizardStep2: Add, Button, xm w80 gSaveConfigurationWizard hwndSaveConfigHwnd, &Save config
     if (T_CalculateButton = 0)
          {
          GuiControl, WizardStep2: Disable, % TestButtonHwnd
          GuiControl, WizardStep2: Disable, % SaveConfigHwnd
          }
     Gui, WizardStep2: Add, Progress, x+m w350 h25 cGreen vProgressBarVar BackgroundC9C9C9, 0
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor

     DetectHiddenWindows, On
     Gui, WizardStep2: Show
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     Gui, WizardStep2: Show

          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)/ 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2)
          , % WindowWizardTitle . " Layer " . CurrentLayer
     MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))
return

BCalculate:
     T_CalculateButton := 1
     Gui, WizardStep2: Submit
     F_CalculateButtonsAndGaps()
     Gui, WizardStep2: Destroy
     GuiControl, WizardStep2: Enable, % TestButtonHwnd
     GuiControl, WizardStep2: Enable, % SaveConfigHwnd
     Goto, WizardStep2
return

PlotButtons:
     Gui, WizardStep2:    Submit, NoHide
     Gui, WizardStep2:    Destroy
     Gui, Wizard_PlotMatrixOfButtons:       Destroy
     
     F_CalculateButtonsAndGaps()
     
     F_AddButtonsAndGaps("Disable")
     Gui, Wizard_PlotMatrixOfButtons: Show, % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle . " Layer " . CurrentLayer 
     PoseH := ""
     MsgBox, 4096,  % WindowWizardTitle, Press OK button to continue to go back: test new configuration again or save it.
     Gui, Wizard_PlotMatrixOfButtons: Submit 
     GoTo, WizardStep2
return

SaveConfigurationWizard:
     if (T_CalculateButton = 0)
          {
          MsgBox, 0, % WindowWizardTitle, Press Calculate button at first.
          return
          }

     IniWrite, % WhichMonitor,            % A_ScriptDir . "\Config.ini", Main,                      WhichMonitor
     IniWrite, % HowManyLayers,           % A_ScriptDir . "\Config.ini", Main,                      HowManyLayers ; Save the total amount of created layers
     IniWrite, % Title,                   % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  Title
     IniWrite, % ButtonWidth,             % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonWidth
     IniWrite, % ButtonHeight,            % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHeight
     IniWrite, % ButtonHorizontalGap,     % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHorizontalGap
     IniWrite, % ButtonVerticalGap,       % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonVerticalGap


     Gui, Wizard_PlotMatrixOfButtons: +LastFoundExist
     if (WinExist())
          {
          F_SavePositionOfButtons()     
          }
     else
          {
          F_AddButtonsAndGaps("Disable")
          F_SavePositionOfButtons()
          }

     MsgBox, 0, % WindowWizardTitle, % "Configuration saved to the file:`r`n" . A_ScriptDir . "\Config.ini"
     GuiControl, Disable, % SaveConfigHwnd
     Gui, WizardStep2: Add, Button, x+m w80 gWizardStep3, C&ontinue
return


WizardStep3:
     Gui, WizardStep2: Destroy
     
     Gui, Wizard_PlotMatrixOfButtons: +LastFoundExist
     if (WinExist())
          Gui, Wizard_PlotMatrixOfButtons: Destroy
     F_AddButtonsAndGaps("Enable")
     Gui, Wizard_PlotMatrixOfButtons: Show, % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle . " Layer " . HowManyLayers

     Gui, WizardStep3: New, +LabelMyGui_On
     Gui, WizardStep3: Font, bold
     Gui, WizardStep3: Add, Text, , Step 3: `t`tAssociate pictures and functions with buttons.
     Gui, WizardStep3: Font
     Gui, WizardStep3: Add, Text, , Click any of the buttons in the bottom window and associate up to 2 pictures and 1 function to it:`r`n * 1st picture which will be shown by default`r`n * 2nd picture which will be shown if button is selected`r`n* function (*.ahk) which will be run after button is selected.
     Gui, WizardStep3: Add, Button, xm+30 w80 gStartOtagle,     &Finish wizard
     Gui, WizardStep3: Add, Button, x+30 w80 gL_AddNextLayer,        &Add next layer

     DetectHiddenWindows, On
     Gui, WizardStep3: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     Gui, WizardStep3:-DPIScale
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     
     Gui, WizardStep3: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
          , % WindowWizardTitle  . " Layer " . CurrentLayer
return

L_WizardButton:
     Gui,               WizardStep3: Show, Hide
     Gui,               Wizard_PlotMatrixOfButtons: +OwnDialogs
     GuiControlGet,     ReadButtonPos, Wizard_PlotMatrixOfButtons: Pos, % A_GuiControl
     FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a picture file, Picture (*.png; *.jpg)
     if (SelectedFile = "")
          {
          MsgBox,   No picture file was selected.
          Gui,      WizardStep3: Show
          }
     else
          {
          GuiControl, Wizard_PlotMatrixOfButtons: Hide, % A_GuiControl ; Hide the button
          Gui, Wizard_PlotMatrixOfButtons: Add, Picture, % "x" . ReadButtonPosX . " y" . ReadButtonPosY . " w" . ReadButtonPosW . " h-1", % SelectedFile ; Add the selected picture instead of button
          IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . A_GuiControl . "_Picture" ; Save the picture into config file
          FileSelectFile,    SelectedFile, 3, , Select a "selected" picture file, Picture (*.png; *.jpg)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No "selected" picture file was selected.
               Gui,      WizardStep3: Show
               }
          else
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . A_GuiControl . "_PictureIfSelected" ; Save the function into config file
          
          FileSelectFile, SelectedFile, 3, , Select an .ahk or .exe file, File (*.ahk; *.exe)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No action file was selected.
               Gui,      WizardStep3: Show
               }
          else
               {
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . A_GuiControl . "_Action" ; Save the function into config file
               FileAppend, % "#Include *i " . SelectedFile . "`r`n", %A_ScriptDir%\ButtonFunctions.ahk, UTF-8
               T_Reload := 1 ; the ButtonFunctions.ahk file has been updated, so reload is required
               }
          }
     Gui,      WizardStep3: Show
return

L_ButtonPressed: 
     SplitPath, % TableOfLayers[CurrentLayer][A_GuiControl], FunctionName
     FunctionName := SubStr(FunctionName, 1, StrLen(FunctionName)-4)
     %FunctionName%()
return

StartOtagle:
     Gui, WizardStep3:                  Destroy
     Gui, Wizard_PlotMatrixOfButtons:   Destroy
     if (T_Reload)
          {
          FileSetAttrib, +H, %A_ScriptDir%\ButtonFunctions.ahk  ; hide ButtonFunctions.ahk     
          MsgBox, 0, % ApplicationName, % ApplicationName . " will reload now in order to apply updated settings" 
          Reload
          }
     else
          {
          F_WelcomeScreen()
          Gosub,  Traymenu     ; Jumps to the specified label and continues execution until Return is encountered
          F_ReadConfig_ini()
          CurrentLayer := 1  ; initialization of application
          EditFlag := 0
          SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor 
          try          
               F_DisplayLayer(CurrentLayer)
          catch e
               {
               MsgBox, An exception was thrown!`r`nIncorrect value of Monitor variable within Config.ini. Probably this monitor has not been found. Application will exit now.
               Exit, 1
               }
          Gui, ProgressBar:Destroy
          }
return

DestroyWelcomeScreen:
     Gui, WelcomeScreen: Destroy
return

L_AddNextLayer:
     Gui, Wizard_PlotMatrixOfButtons:   Destroy
     Gui, WizardStep3:                  Destroy
     HowManyLayers++
     T_CalculateButton := 0
     Goto WizardStep2

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

MyGui_OnClose:
ExitWizard:
     ;~ MsgBox, 4,, Do you want to close O T A G L E?
     ;~ IfMsgBox, No
          ;~ return
     ExitApp

#IfWinActive O T A G L E 
F10::
     if (Mod(MenuVar, 2) == 0)
          Gui, % GuiLayer%CurrentLayer%Hwnd . ": Menu", OtagleMenu
     else
          Gui, % GuiLayer%CurrentLayer%Hwnd . ": Menu",
     MenuVar := MenuVar + 1
return
#IfWinActive O T A G L E 

#If (!(EditFlag)) and (WinActive("O T A G L E")) ; dodaj opcje, zeby tylko w O T A G L E
^x::
     EditFlag := 0
     Gui, CopyLayers:Destroy
     goto, L_SwapButtons
return

^c::
     EditFlag := 0
     Gui, SwapLayers:Destroy
     goto, L_CopyButton
return

^z::
     EditFlag := 0
     Gui, SwapLayers:Destroy
     Gui, CopyLayers:Destroy
     goto, L_DeleteButton
return
#If

#If ((EditFlag == 0) or (EditFlag ==1)) and (WinActive("O T A G L E"))
esc::
     Gui, SwapLayers:Destroy
     Gui, CopyLayers:Destroy
     goto, StartOtagle
return
#If

Traymenu:
     Menu, Tray,                Icon, % A_ScriptDir . "\Core\OtagleIcon.ico"    ; this line applies icon of O T A G L E designed by Sylwia Ławrów
     Menu, Tray,                Add, %ApplicationName%.ahk ABOUT, L_About
     Menu, Tray,                Add ; tray menu separator
     Menu, SubmenuConfigure,    Add, &Monitor,                              L_ConfigureMonitor
     Menu, SubmenuConfigure,    Add, &Existing layer buttons / functions,   L_ConfigureButtonsFunctions
     Menu, SubmenuConfigure,    Add, &Add layer,                            L_ConfigureAddLayer
     Menu, SubmenuConfigure,    Add, &Erase layer,                          L_ConfigureEraseLayer
     Menu, SubmenuEdit,         Add, &Copy button,                          L_CopyButton
     Menu, SubmenuEdit,         Add, &Swap buttons,                         L_SwapButtons
     Menu, SubmenuEdit,         Add, &Delete button,                        L_DeleteButton
     Menu, Tray,                Add, &Configure,                            :SubmenuConfigure
     Menu, Tray,                Add, &Edit buttons,                         :SubmenuEdit
     Menu, Tray,                Add, &Run Wizard,                           L_ConfigureWizard
     Menu, Tray,                Default, %ApplicationName%.ahk ABOUT ; Default: Changes the menu's default item to be the specified menu item and makes its font bold.
     Menu, Tray,                Add ; tray menu separator
     Menu, Tray,                NoStandard
     Menu, Tray,                Standard ;#[1]
     Menu, Tray,                Tip, %ApplicationName% ; Changes the tray icon's tooltip.
     
     Menu, OtagleMenu,    Add, &Configure,                            :SubmenuConfigure
     Menu, OtagleMenu,    Add, &Edit buttons,                         :SubmenuEdit
     Menu, OtagleMenu,    Add, &Run Wizard,                           L_ConfigureWizard
     Menu, OtagleMenu,    Add, &About,                                L_About
return

L_ConfigureEraseLayer:
     Gui, EraseLayer: New, +LabelMyGui_On
     Gui, EraseLayer: Font, bold
     Gui, EraseLayer: Add, Text, , Erase layer
     Gui, EraseLayer: Font
     Gui, EraseLayer: Add, Text, , Select which layer should be erased:
     Gui, EraseLayer: Add, Edit, x+m yp r1 w50
     Gui, EraseLayer: Add, UpDown, % "vLayerToBeErased Range1-" . HowManyLayers, % CurrentLayer
     Gui, EraseLayer: Add, Button, xm+30 w80 gL_EraseLayer,     &Erase layer

     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     DetectHiddenWindows, On
     Gui, EraseLayer: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     Gui, EraseLayer:-DPIScale
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     
     Gui, EraseLayer: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
          , % WindowWizardTitle  . " Layer " . CurrentLayer

return

L_EraseLayer:
     Gui, EraseLayer: Submit, NoHide
     Gui, EraseLayer: Destroy
     IniDelete, % A_ScriptDir . "\Config.ini", % "Layer" . LayerToBeErased
     HowManyLayers--
     IniWrite, % HowManyLayers,           % A_ScriptDir . "\Config.ini", Main,                      HowManyLayers
     T_Reload := 1 ; the Config.ini file has been updated, so reload is required
     Goto StartOtagle

L_ConfigureWizard:
     MsgBox, 52, Warning, Selecting this option will delete the current configuration file and create a new one. Do you want to proceed?
     IfMsgBox, No
          return
     Gui, % "Layer" . CurrentLayer . ": +LastFoundExist"
     if (WinExist())
          Gui, % "Layer" . CurrentLayer . ": Destroy"
     Goto Wizard_Intro
return

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
     Gui, ConfigureMonitor: Add, Button, x+30  w120 gL_ConfigureMonitor_Save,      &Save and reload
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

L_ConfigureMonitor_Save:
     Gui, WizardStep1: Destroy
     IniWrite, % WhichMonitor,            % A_ScriptDir . "\Config.ini", Main, WhichMonitor
     Gui, ConfigureMonitor: Destroy
     Goto StartOtagle
;~ return

L_ConfigureMonitor_Cancel:
     Gui, ConfigureMonitor: Destroy
return

L_ConfigureButtonsFunctions: 
     IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
     IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     TableOfLayers[CurrentLayer] := []
     Loop, % AmountOfKeysVertically
          {
          VerticalIndex := A_Index
          Loop, % AmountOfKeysHorizontally
               {
               GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Enable",  % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               GuiControl,,                                            % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd, % VerticalIndex . "_" . A_Index
               GuiControl, +gL_AddPicturesFunction,                    % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               }
          }

     Gui, ConfigureButtonsFunctions: New, +LabelMyGui_On
     Gui, ConfigureButtonsFunctions: Font, bold
     Gui, ConfigureButtonsFunctions: Add, Text, ,`t`tAssociate pictures and functions with buttons.
     Gui, ConfigureButtonsFunctions: Font
     Gui, ConfigureButtonsFunctions: Add, Text, , Click any of the buttons in the bottom window and associate up to 2 pictures and 1 function to it:`r`n * 1st picture which will be shown by default`r`n * 2nd picture which will be shown if button is selected`r`n* function (*.ahk) which will be run after button is selected.
     Gui, ConfigureButtonsFunctions: Add, Button, xm+30 w80 gL_RedrawLastWindow,     &Finish

     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     DetectHiddenWindows, On
     Gui, ConfigureButtonsFunctions: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     Gui, ConfigureButtonsFunctions:-DPIScale
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     
     Gui, ConfigureButtonsFunctions: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
          , % WindowWizardTitle  . " Layer " . CurrentLayer
return

L_AddPicturesFunction:
     Gui,               ConfigureButtonsFunctions: Show, Hide
     GuiControlGet,     ReadButtonPos, % GuiLayer%CurrentLayer%Hwnd . ": Pos", % A_GuiControl

     FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a picture file, Picture (*.png; *.jpg) 
     if (SelectedFile = "")
          {
          MsgBox,   No picture file was selected.
          Gui,      WizardStep3: Show
          }
     else
          {
          GuiControl, Hide, % A_GuiControl ; Hide the button
          Gui, % GuiLayer%CurrentLayer%Hwnd . ": Add", Picture, % "x" . ReadButtonPosX . " y" . ReadButtonPosY . " w" . ReadButtonPosW . " h-1", % SelectedFile ; Add the selected picture instead of button
          IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture" ; Save the picture into config file
          FileSelectFile,    SelectedFile, 3, , Select a "selected" picture file, Picture (*.png; *.jpg)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No "selected" picture file was selected.
               Gui,      ConfigureButtonsFunctions: Show
               }
          else
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected" ; Save the function into config file
          
          FileSelectFile, SelectedFile, 3, , Select an .ahk file, File (*.ahk)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No action file was selected.
               Gui,      ConfigureButtonsFunctions: Show
               }
          else
               {
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action" ; Save the function into config file
               FileAppend, % "#Include *i " . SelectedFile . "`r`n", %A_ScriptDir%\ButtonFunctions.ahk, UTF-8
               T_Reload := 1 ; the ButtonFunctions.ahk file has been updated, so reload is required
               }
          }
     Gui,      ConfigureButtonsFunctions: Show

return

L_RedrawLastWindow:
     Gui, ConfigureButtonsFunctions: Destroy
     Goto StartOtagle
return

L_ConfigureAddLayer:
     HowManyLayers++
     Goto WizardStep2
return

L_About:
     Gui, MyAbout: New, +LabelMyGui_On -Caption +Border
     Gui, MyAbout: Font, Bold
     Gui, MyAbout: Add, Text, , %ApplicationName% v.2.0 by mslonik (🐘)
     Gui, MyAbout: Font
     Gui, MyAbout: Add, Text, xm
     , Make your computer Personal a g a i n...`r`nOpen source release of Stream Deck concept. Works at its best with touch screens.`r`n`r`nFor project description visit the following webpages:
          Gui, MyAbout: Font, CBlue Underline 
     Gui, MyAbout: Add, Text, xm, http://mslonik.pl/biuro/1095-o-t-a-g-l-e-q-a`r`nhttps://www.autohotkey.com/boards/viewtopic.php?t=69690&p=300713`r`nhttps://github.com/mslonik/Autohotkey-scripts/tree/master/Otagle2
     Gui, MyAbout: Font
     Gui, MyAbout: Add, Picture, xm+50 y+20 w300 h-1, % A_ScriptDir . "\OtagleBigLogo.png" ; Add the O T A G L E picture designed by Sylwia Ławrów
     
     Gui, MyAbout: Add, Button, Default Hidden w100 gAboutOkBut Center vOkButtonVar hwndOkButtonHwnd, &OK
    
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     DetectHiddenWindows, On
     Gui, MyAbout: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top 
          , HiddenAttempt
     Gui, MyAbout:-DPIScale
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     
     Gui, MyAbout: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
          , % WindowWizardTitle  . " Layer " . CurrentLayer

     GuiControlGet, MyGuiControlGetVariable, MyAbout: Pos, %OkButtonHwnd%
     NewButtonXPosition := (WizardWindow_Width / 2) - (MyGuiControlGetVariableW / 2)
     GuiControl, MyAbout: Move, %OkButtonHwnd%, % "x" NewButtonXPosition
     GuiControl, MyAbout: Show, %OkButtonHwnd%    
return    

AboutOkBut:
     Gui, MyAbout: Destroy
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Menu", OtagleMenu
return

L_SwapButtons:

     IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
     IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Color", FFA500
     IniRead, HowManyLayers,             % A_ScriptDir . "\Config.ini", Main, HowManyLayers
     Gui, SwapLayers:New, +AlwaysOnTop -MaximizeBox -MinimizeBox
     Gui, SwapLayers:Add, Edit
     Gui, SwapLayers:Add, UpDown, vMyUpDown Range1-%HowManyLayers%, %CurrentLayer%
     Gui, SwapLayers:Add, Button, Default gL_SwapGoTo, Go To Layer
     Gui, SwapLayers:Show,, Layers
     WinActivate, O T A G L E
     Loop, % AmountOfKeysVertically
          {
          VerticalIndex := A_Index
          Loop, % AmountOfKeysHorizontally
               {
               GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Enable",  % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               GuiControl,,                                            % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd, % VerticalIndex . "_" . A_Index
               GuiControl, +gL_SelectButtonToSwap,                    % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               }
          }
     
return

L_SelectButtonToSwap:
     
     EditFlag := 1
     IniRead, FirstButtonPicture,                   % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture", 0
     IniRead, FirstButtonAction,                    % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action", 0 
     IniRead, FirstButtonPictureIfSelected,         % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected", 0
     FirstGui := A_GuiControl
     FirstLayer := CurrentLayer
     GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Hide", % %CurrentLayer%_%A_GuiControl%hwnd
     GuiControlGet,     ReadButtonPos, % GuiLayer%CurrentLayer%Hwnd . ": Pos", % A_GuiControl
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Add", Button, x%ReadButtonPosX% y%ReadButtonPosY% w%ReadButtonPosW% h%ReadButtonPosH% Disabled,
     
     if FirstButtonPictureIfSelected = 0
     {
          FirstButtonPicture := ""
          FirstButtonAction := ""
          FirstButtonPictureIfSelected := ""
     }
L_Swapping2Step:
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Color", 00FFFF
     if (CurrentLayer != FirstLayer)
     {
          IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
          IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     }
     Loop, % AmountOfKeysVertically
          {
          VerticalIndex := A_Index
          Loop, % AmountOfKeysHorizontally
               {
                    if (CurrentLayer != FirstLayer)
                    {
                         GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Enable",  % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
                         GuiControl,,                                            % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd, % VerticalIndex . "_" . A_Index
                    }
               GuiControl, +gL_SelectSwappedButton,                    % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               }
          }
return

L_SelectSwappedButton:
     IniRead, SecondButtonPicture,              % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture", 0
     IniRead, SecondButtonAction,               % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action", 0
     IniRead, SecondButtonPictureIfSelected,    % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected", 0
     if SecondButtonPictureIfSelected = 0
     {
          SecondButtonPicture := ""
          SecondButtonAction := ""
          SecondButtonPictureIfSelected := ""
     }
     IniWrite, % FirstButtonPicture,            % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture"
     IniWrite, % FirstButtonAction,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action"
     IniWrite, % FirstButtonPictureIfSelected,  % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected" 
     IniWrite, % SecondButtonPicture,           % A_ScriptDir . "\Config.ini", % "Layer" . FirstLayer, % "Button_" . FirstGui . "_Picture"
     IniWrite, % SecondButtonAction,            % A_ScriptDir . "\Config.ini", % "Layer" . FirstLayer, % "Button_" . FirstGui . "_Action"
     IniWrite, % SecondButtonPictureIfSelected, % A_ScriptDir . "\Config.ini", % "Layer" . FirstLayer, % "Button_" . FirstGui . "_PictureIfSelected"
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Destroy"
     Gui, SwapLayers:Destroy
     Goto StartOtagle
return

L_SwapGoTo:
     Gui, SwapLayers:Submit, NoHide
     Gui, SwapLayers:+OwnDialogs
     CurrentLayer := MyUpDown
     F_DisplayLayer(CurrentLayer)
     goto, L_Swapping2Step
return

L_CopyButton:

     IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
     IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Color", Green
     Gui, CopyLayers:New, +AlwaysOnTop -MaximizeBox -MinimizeBox
     Gui, CopyLayers:Add, Edit
     Gui, CopyLayers:Add, UpDown, vMyUpDown Range1-%HowManyLayers%, %CurrentLayer%
     Gui, CopyLayers:Add, Button, Default gL_CopyGoTo, Go To Layer
     Gui, CopyLayers:Show,, Layers
     WinActivate, O T A G L E
     Loop, % AmountOfKeysVertically
          {
          VerticalIndex := A_Index
          Loop, % AmountOfKeysHorizontally
               {
               GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Enable",  % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               GuiControl,,                                            % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd, % VerticalIndex . "_" . A_Index
               GuiControl, +gL_SelectButtonToCopy,                    % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               }
          }
return
     
L_SelectButtonToCopy:

     EditFlag := 1
     IniRead, FirstButtonPicture,                   % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture", 0
     IniRead, FirstButtonAction,                    % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action", 0 
     IniRead, FirstButtonPictureIfSelected,         % A_ScriptDir . "\Config.ini",  % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected", 0
     FirstGui := A_GuiControl
     FirstLayer := CurrentLayer
     GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Hide", % %CurrentLayer%_%A_GuiControl%hwnd
     GuiControlGet,     ReadButtonPos, % GuiLayer%CurrentLayer%Hwnd . ": Pos", % A_GuiControl
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Add", Button, x%ReadButtonPosX% y%ReadButtonPosY% w%ReadButtonPosW% h%ReadButtonPosH% Disabled,
     if FirstButtonPictureIfSelected = 0
     {
          FirstButtonPicture := ""
          FirstButtonAction := ""
          FirstButtonPictureIfSelected := ""
     }
     
L_Copying2Step:
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Color", 00FFFF
     if (CurrentLayer != FirstLayer)
     {
          IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
          IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     }
     Loop, % AmountOfKeysVertically
          {
          VerticalIndex := A_Index
          Loop, % AmountOfKeysHorizontally
               {
                    if (CurrentLayer != FirstLayer)
                    {
                         GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Enable",  % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
                         GuiControl,,                                            % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd, % VerticalIndex . "_" . A_Index
                    }
                    GuiControl, +gL_SelectReplacedButton,                    % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               }
          }
return
     
L_SelectReplacedButton:
     IniWrite, % FirstButtonPicture,            % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture"
     IniWrite, % FirstButtonAction,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action"
     IniWrite, % FirstButtonPictureIfSelected,  % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected"
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Destroy"
     Gui, CopyLayers:Destroy
     Goto StartOtagle
return

L_CopyGoTo:
     Gui, CopyLayers:Submit, NoHide
     Gui, CopyLayers:+OwnDialogs
     CurrentLayer := MyUpDown
     F_DisplayLayer(CurrentLayer)
     goto, L_Copying2Step
return

L_DeleteButton:

     IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
     IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Color", Red
     Loop, % AmountOfKeysVertically
          {
          VerticalIndex := A_Index
          Loop, % AmountOfKeysHorizontally
               {
               GuiControl, % GuiLayer%CurrentLayer%Hwnd . ": Enable",  % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               GuiControl,,                                            % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd, % VerticalIndex . "_" . A_Index
               GuiControl, +gL_SelectButtonToDelete,                    % %CurrentLayer%_%VerticalIndex%_%A_Index%hwnd
               }
          }
return

L_SelectButtonToDelete:
     RemovedText := ""
     IniWrite, % RemovedText,                             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture"
     IniWrite, % RemovedText,                             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action"
     IniWrite, % RemovedText,                             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected"
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Destroy"
     Goto StartOtagle
return

; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_DisplayLayer(WhichLayer)
     {
     global 

     MenuVar := 0
     Gui, % "Layer" . WhichLayer . ": -Resize  -DPIScale -MinimizeBox "
     Gui, % "Layer" . WhichLayer . ": Show", % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % ApplicationName . ": Layer " . WhichLayer . " - " . Title%WhichLayer%
     if (HowManyLayers > 1)
          {
          Loop, % HowManyLayers
               {
               if (A_Index <> WhichLayer)
                    {
                    Gui, % GuiLayer%A_Index%Hwnd . ": Hide"
                    }
               }
          }     
     }
     
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_WizardIntro()
     {
     global
     
     Gui, Wizard_Intro: New, +LabelMyGui_On
     Gui, Wizard_Intro: Font, bold
     Gui, Wizard_Intro: Add, Text, w500, Introduction
     Gui, Wizard_Intro: Font, 
     Gui, Wizard_Intro: Add, Text, w500, When there is no Config.ini file or on purpose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 questions related to settings of application.
     Gui, Wizard_Intro: Add, Text, w500, Step 1: `t`tChoose a monitor where GUI of %ApplicationName% will be located.
     Gui, Wizard_Intro: Add, Text, w500, Step 2: `t`tCheck monitor size, specify amount and size of buttons.
     Gui, Wizard_Intro: Add, Text, w500, Step 3: `t`tPlot on the screen matrix of buttons.
     Gui, Wizard_Intro: Add, Button, % "Default xm+" . 500//3 . " w80 gWizardStep1",    &Next
     Gui, Wizard_Intro: Add, Button, x+30 w80 gExitWizard,                              &Cancel
     Gui, Wizard_Intro: Show, , % WindowWizardTitle . " Layer " . CurrentLayer
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
     }

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_WelcomeScreen()
     {
     global
       
     IniRead, WhichMonitor,               % A_ScriptDir . "\Config.ini", Main, WhichMonitor
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     Gui, ProgressBar:New
     Gui, ProgressBar:Add, Progress, w300 h20 HwndhPB2 -0x1, 50
     Gui, ProgressBar:Add, Text, x80 , OTAGLE is loading. Please wait...
     WinSet, Style, +0x8, % "ahk_id " hPB2
     SendMessage, 0x40A, 1, 50,, % "ahk_id " hPB2
     Gui, ProgressBar:Show, hide AutoSize, HiddenAttempt
     DetectHiddenWindows, On
     Gui, ProgressBar:-DPIScale
     WinGetPos, , , ProgressWindow_Width, ProgressWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     Gui, ProgressBar:Show, % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (ProgressWindow_Width / 2)
          . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (ProgressWindow_Height / 2), O T A G L E
     Gui, WelcomeScreen: New, +LabelMyGui_On +AlwaysOnTop -Caption
     Gui, WelcomeScreen: Add, Picture, w500 h-1, % A_ScriptDir . "\Core\OtagleBigLogo.png" ; Add the O T A G L E picture designed by Sylwia Ławrów 
     DetectHiddenWindows, On
     Gui, WelcomeScreen: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     Gui, WelcomeScreen:-DPIScale
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     DetectHiddenWindows, Off
     Gui, WelcomeScreen: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2)
          . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % ApplicationName . " Welcome!"
     SetTimer, DestroyWelcomeScreen, -3000
     }

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_ReadConfig_ini()
     {
     global
     local LayerIndex, VerticalIndex
     local ButtonX, ButtonY, ButtonW, ButtonH, PictureDef, PictureSel
     
     IniRead, WhichMonitor,               % A_ScriptDir . "\Config.ini", Main, WhichMonitor
     IniRead, HowManyLayers,              % A_ScriptDir . "\Config.ini", Main, HowManyLayers
     TableOfLayers := [{}]
     
     Loop, % HowManyLayers
          {
          LayerIndex := A_Index
          IniRead, Title%LayerIndex%,                    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Title
          IniRead, ButtonWidth,                          % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonWidth
          IniRead, ButtonHeight,                         % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonHeight
          IniRead, ButtonHorizontalGap,                  % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonHorizontalGap
          IniRead, ButtonVerticalGap,                    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonVerticalGap
          IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Amount of buttons horizontally
          IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Amount of buttons vertically
          TableOfLayers[LayerIndex] := []
          Title%LayerIndex% := % MsgText(Title%LayerIndex%)
          Gui, % "Layer" . LayerIndex . ": New", % "+hwndGuiLayer" . LayerIndex . "Hwnd" . " +LabelMyGui_On"
          Loop, % AmountOfKeysVertically
               {
               VerticalIndex := A_Index
               Loop, % AmountOfKeysHorizontally
                    {
                    IniRead, ButtonX,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_X"
                    IniRead, ButtonY,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Y"
                    ButtonW := ButtonWidth
                    ButtonH := ButtonHeight
                    ;~ IniRead, ButtonY,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Y"
                    ;~ IniRead, ButtonW,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_W"
                    IniRead, PictureDef,    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Picture"
                    IniRead, PictureSel,    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_PictureIfSelected"
                    IniRead, ButtonA,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Action"
                    
                    Gui, % "Layer" . LayerIndex . ": Add", Button
                         , % "x" . ButtonX . " y" . ButtonY . " w" . ButtonW . " h" . ButtonH 
                         . " hwnd" . LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd" . " gL_ButtonPressed" . " v" . VerticalIndex . "_" . A_Index     
                    if (PictureDef = "") ; if there is no picture assigned to particular button, then the button should be disabled
                         GuiControl, % "Layer" . LayerIndex . ": Disable", % %LayerIndex%_%VerticalIndex%_%A_Index%hwnd ; Disable unused button
                    else ; if there is a picture, prepare its graphics
                         {   
                         WhichButton := LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd"
                         Opt1 := {1: 0, 2: PictureDef, 4: "Black"}
                         Opt2 := {2: PictureSel, 4: "Yellow"}
                         ;~ Opt5 := {2: PictureSel, 4: "Yellow"}
                         If !ImageButton.Create(%WhichButton%, Opt1, Opt2 )
                              MsgBox, 0, % "ImageButton Error" . LayerIndex . "_" . VerticalIndex . "_" . A_Index, % ImageButton.LastError
                         TableOfLayers[LayerIndex][VerticalIndex . "_" . A_Index] := PictureDef     ; add key of object: index of button / picture
                         TableOfLayers[LayerIndex][VerticalIndex . "_" . A_Index] := ButtonA        ; add value of object: path to executable
                         }
                    }
               }
          ;~ vOutput := ""
          ;~ for vKey, vValue in TableOfLayers[LayerIndex]
               ;~ vOutput .= vKey " " vValue "`r`n"
          ;~ MsgBox, % vOutput
          }
     }
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_SavePositionOfButtons()
     {
     global ; Assume-global mode
     local ExternalLoopIndex, Guzior := 0
     local GuziorX := 0, GuziorY := 0, GuziorW := 0, GuziorH := 0
     local PictureFilePath := ""
     local ButtonScript := ""
     
     IniWrite, % WizardStep2_AmountOfKeysHorizontally,  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, Amount of buttons horizontally
     IniWrite, % WizardStep2_AmountOfKeysVertically,    % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, Amount of buttons vertically
     
     ProgressBarVarMax := WizardStep2_AmountOfKeysVertically * WizardStep2_AmountOfKeysHorizontally * 6 ; 6 ← 6x IniWrite in internal loop
     ProgressBarTemp := 0
     
     Loop, % WizardStep2_AmountOfKeysVertically
          {
          ExternalLoopIndex := A_Index
          Loop, % WizardStep2_AmountOfKeysHorizontally
               {
               GuiControlGet, Guzior, Pos, % %ExternalLoopIndex%_%A_Index%hwnd
               ; IniWrite, % GuziorX,         % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_X"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorY,         % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Y"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               ; IniWrite, % GuziorW,         % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_W"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorH,         % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_H"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % PictureFilePath, % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Picture"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % ButtonScript,    % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Action"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               }
          }
     }
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
F_AddButtonsAndGaps(IfEnable)
     {
     global ; Assume-global mode
     
     Gui, Wizard_PlotMatrixOfButtons: New, +LabelMyGui_On
     
     local FirstRow := 0
     
     Loop, % WizardStep2_AmountOfKeysVertically
          {
          ExternalLoopIndex := A_Index
          Loop, % WizardStep2_AmountOfKeysHorizontally
               {
               if (A_Index = 1 and FirstRow == 0)
                    {
               
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "x" . WizardStep2_MarginHorizontally/2 . " y" . ButtonVerticalGap . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd"  . " gL_WizardButton", % ExternalLoopIndex . "_" . A_Index
                    if (IfEnable = "Disable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Disable, % %ExternalLoopIndex%_%A_Index%hwnd
                    else if (IfEnable = "Enable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Enable, % %ExternalLoopIndex%_%A_Index%hwnd
                    }
               else if (A_Index = 1 and FirstRow == 1)
                    {
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "x" . WizardStep2_MarginHorizontally/2 . " yp+" . (ButtonHeight + ButtonVerticalGap) . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd"  . " gL_WizardButton", % ExternalLoopIndex . "_" . A_Index
                    if (IfEnable = "Disable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Disable, % %ExternalLoopIndex%_%A_Index%hwnd
                    else if (IfEnable = "Enable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Enable, % %ExternalLoopIndex%_%A_Index%hwnd
                    }
               else ; (A_Index > 1)
               {
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "xp+" . ButtonWidth + ButtonHorizontalGap . " yp"  . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd" . " gL_WizardButton", % ExternalLoopIndex . "_" . A_Index
                    if (IfEnable = "Disable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Disable, % %ExternalLoopIndex%_%A_Index%hwnd
                    else if (IfEnable = "Enable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Enable, % %ExternalLoopIndex%_%A_Index%hwnd
               }
               }
            FirstRow := 1
          }
     }
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_ShowMonitorNumbers()

{
     global

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
          Gui, %A_Index%:Add, Text, x150 y150 w150 h150, % A_Index
          Gui, % A_Index . ":Show", % "x" .  MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (300 / 2) . "y" 
          . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (300 / 2) . "w300" . "h300"
          }
return
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_CalculateButtonsAndGaps()     
     {
     global WizardStep2_AmountOfKeysHorizontally, WizardStep2_MarginHorizontally, WizardStep2_AmountOfKeysVertically, WizardStep2_MarginVertically
     global MonitorBoundingCoordinates_, MonitorBoundingCoordinates_Bottom, MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Right, MonitorBoundingCoordinates_Top
     global WhichMonitor, ButtonWidth, ButtonHeight, ButtonHorizontalGap, ButtonVerticalGap
     
     WizardStep2_AmountOfKeysHorizontally := (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) -  ButtonHorizontalGap) // ( ButtonWidth + ButtonHorizontalGap)
     WizardStep2_MarginHorizontally := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) - ((WizardStep2_AmountOfKeysHorizontally-1) * ButtonHorizontalGap + WizardStep2_AmountOfKeysHorizontally * ButtonWidth )
     WizardStep2_AmountOfKeysVertically := (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - ButtonVerticalGap) // (ButtonHeight + ButtonVerticalGap)
     WizardStep2_MarginVertically := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - ((WizardStep2_AmountOfKeysVertically-1) * ButtonVerticalGap + WizardStep2_AmountOfKeysVertically * ButtonHeight )
     }

