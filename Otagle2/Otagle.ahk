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
#Include %A_ScriptDir%\Class_ImageButton.ahk                  ; Buttons with pictures


; The naming convention applied in this script
; F_* ← Function 
; L_* ← Label
; T_* ← Toggle ← two state variable to remeber specific setting

; Global variables
     CurrentLayer                           := 1
     WhichMonitor                           := 0
     ApplicationName                        := "O T A G L E"
     WindowWizardTitle                      := ApplicationName . " Configuration Wizard"

     T_CalculateButton                      := 0 ; 0 ← do not calculate button position, 1 ← yes, calculate button position
     T_Reload                               := 0 ; 0 ← do not Reload the main script (Otagle.ahk), 1 ← yes, reload the main script, because content of ButtonFunctions.ahk has been updated

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
     FileRecycle, %A_ScriptDir%\ButtonFunctions.ahk ; ← remove ButtonFunctions.ahk
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
     
     Gui, WizardStep2: New, +LabelMyGui_On
     Gui, WizardStep2: Font, bold
     Gui, WizardStep2: Add, Text, , Step 2: `t`tSpecify amount and size of buttons
     Gui, WizardStep2: Font
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor

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
          . "`tNot used margin at the left side in px:`t" . (T_CalculateButton ? WizardStep2_MarginHorizontally : "")
     Gui, WizardStep2: Add, Text, xm, % "Number of keys vertically:`t" . (T_CalculateButton ? WizardStep2_AmountOfKeysVertically : "") 
          . "`tNot used margin at the bottom side in px:`t" . (T_CalculateButton ? WizardStep2_MarginVertically : "")
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
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2)
          , % WindowWizardTitle . " Layer " . CurrentLayer
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
     IniWrite, % CurrentLayer,            % A_ScriptDir . "\Config.ini", Main,                      HowManyLayers ; Save the total amount of created layers
     IniWrite, % ButtonWidth,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer,  ButtonWidth
     IniWrite, % ButtonHeight,            % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer,  ButtonHeight
     IniWrite, % ButtonHorizontalGap,     % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer,  ButtonHorizontalGap
     IniWrite, % ButtonVerticalGap,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer,  ButtonVerticalGap


     Gui, Wizard_PlotMatrixOfButtons: +LastFoundExist
     if (WinExist())
          {
          F_SavePositionOfButtons()     
          }
     else
          {
          ;~ F_CalculateButtonsAndGaps()
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
     ;~ Gui, Wizard_PlotMatrixOfButtons: Margin, % ButtonHorizontalGap, % ButtonVerticalGap
     F_AddButtonsAndGaps("Enable")
     Gui, Wizard_PlotMatrixOfButtons: Show, % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle . " Layer " . CurrentLayer

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
          ;~ MsgBox, Tu jestem!
          IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture" ; Save the picture into config file
          FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a "selected" picture file, Picture (*.png; *.jpg)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No "selected" picture file was selected.
               ;~ IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected" ; Save the second picture in config file
               Gui,      WizardStep3: Show
               }
          else
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected" ; Save the function into config file
          
          FileSelectFile, SelectedFile, 3, %A_ScriptDir%, Select an .ahk or .exe file, File (*.ahk; *.exe)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No action file was selected.
               ;~ IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action" ; Save the function into config file
               Gui,      WizardStep3: Show
               }
          else
               {
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action" ; Save the function into config file
               FileAppend, % "#Include *i " . SelectedFile . "`r`n", %A_ScriptDir%\ButtonFunctions.ahk, UTF-8
               T_Reload := 1 ; the ButtonFunctions.ahk file has been updated, so reload is required
               }
          }
     Gui,      WizardStep3: Show
return

L_ButtonPressed: 
     SplitPath, % TableOfLayers[CurrentLayer][A_GuiControl], FunctionName
     FunctionName := RTrim(FunctionName, ".ahk") 
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
          Gosub,  Traymenu     ; Jumps to the specified label and continues execution until Return is encountered
          F_ReadConfig_ini()
          CurrentLayer := 1  ; initialization of application
          SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
          try          
               F_DisplayLayer(CurrentLayer)
          catch e
               {
               MsgBox, An exception was thrown!`r`nIncorrect value of Monitor variable within Config.ini. Probably this monitor has not been found. Application will exit now.
               Exit, 1
               }
          ;~ F_WelcomeScreen()
          }
return

DestroyWelcomeScreen:
     Gui, WelcomeScreen: Destroy
return

L_AddNextLayer:
     Gui, Wizard_PlotMatrixOfButtons:   Destroy
     Gui, WizardStep3:                  Destroy
     CurrentLayer++
     T_CalculateButton := 0
     Goto WizardStep2
;~ return


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
     ;~ MsgBox, % "CurrentLayer: " CurrentLayer " Tu jestem!"
ExitWizard:
/*
     if (CurrentLayer > 1)
          {
          Gui, WizardStep2: Destroy
          CurrentLayer--
          return
          }
     else     
*/     
          ExitApp

#IfWinActive O T A G L E 
F10::
     ;~ MsgBox, Tu jestem!
     ;~ Menu, OtagleMenu, Show
     
     Gui, % GuiLayer%CurrentLayer%Hwnd . ": Menu", OtagleMenu
return
#IfWinActive


Traymenu:
     Menu, Tray,                Icon, % A_ScriptDir . "\OtagleIcon.ico"    ; this line applies icon of O T A G L E designed by Sylwia Ławrów
     Menu, Tray,                Add, %ApplicationName%.ahk ABOUT, L_About
     Menu, Tray,                Add ; tray menu separator
     Menu, SubmenuConfigure,    Add, Monitor,                              L_ConfigureMonitor
     Menu, SubmenuConfigure,    Add, Existing layer buttons / functions,   L_ConfigureButtonsFunctions
     Menu, SubmenuConfigure,    Add, Add layer,                            L_ConfigureAddLayer
     Menu, SubmenuConfigure,    Add, Erase layer,                          L_ConfigureEraseLayer
     Menu, SubmenuConfigure,    Add, Run Wizard,                           L_ConfigureWizard
     Menu, Tray,                Add, Configure,                                        :SubmenuConfigure
     Menu, Tray,                Default, %ApplicationName%.ahk ABOUT ; Default: Changes the menu's default item to be the specified menu item and makes its font bold.
     Menu, Tray,                Add ; tray menu separator
     Menu, Tray,                NoStandard
     Menu, Tray,                Standard ;#[1]
     Menu, Tray,                Tip, %ApplicationName% ; Changes the tray icon's tooltip.
     
     Menu, OtagleMenu,          Add, About, L_About
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
     T_Reload := 1 ; the Config.ini file has been updated, so reload is required
     Goto StartOtagle

L_ConfigureWizard:
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

     Gui, ConfigureMonitor: Add, Button, xm+30 y+20 w120 gL_ConfigureMonitor_Save,      &Save and reload
     Gui, ConfigureMonitor: Add, Button, x+30 w80 gL_ConfigureMonitor_Cancel,    &Cancel
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     DetectHiddenWindows, On
     Gui, ConfigureMonitor: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
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
          FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a "selected" picture file, Picture (*.png; *.jpg)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No "selected" picture file was selected.
               Gui,      ConfigureButtonsFunctions: Show
               }
          else
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_PictureIfSelected" ; Save the function into config file
          
          FileSelectFile, SelectedFile, 3, %A_ScriptDir%, Select an .ahk or .exe file, File (*.ahk; *.exe)
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
     CurrentLayer++
     Goto WizardStep2
return

L_About:
     Gui, MyAbout: New, +LabelMyGui_On
     Gui, MyAbout: Font, Bold
     Gui, MyAbout: Add, Text, , %ApplicationName% v.2.0 by mslonik (🐘)
     Gui, MyAbout: Font
     Gui, MyAbout: Add, Text, xm, Make your computer PersonaL a g a i n...
     Gui, MyAbout: Add, Text, xm, Open source release of Stream Deck concept. Works at its best with touch screens.
     ;~ Gui, MyAbout: Font, CBlue Underline 
     ;~ Gui, MyAbout: Add, Text, x+1, https://en.wikipedia.org/wiki/Diacritic
     ;~ Gui, MyAbout: Font
     Gui, MyAbout: Add, Text, xm+20, * one can run Wizard from SysTray menu to adjust settings.
     Gui, MyAbout: Add, Picture, xm+50 y+20 w300 h-1, % A_ScriptDir . "\OtagleBigLogo.png" ; Add the O T A G L E picture designed by Sylwia Ławrów
     
     Gui, MyAbout: Add, Button, Default Hidden w100 gAboutOkBut Center vOkButtonVar hwndOkButtonHwnd, &OK
    
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     DetectHiddenWindows, On
     Gui, MyAbout: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
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
          Gui, % GuiLayer%CurrentLayer%Hwnd . ": Menu" ; detach the menu bar
return

; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_DisplayLayer(WhichLayer)
     {
     global     
          
     Gui, % "Layer" . WhichLayer . ": Show", % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % ApplicationName . ": Layer " . WhichLayer
     ;~ if (CurrentLayer > MaxLayer)
          ;~ MaxLayer := CurrentLayer  ; this line is used to have just one O T A G L E window displayed

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
     Gui, Wizard_Intro: Add, Text, w500, When there is no Config.ini file or on purspose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 questions related to settings of application.
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
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     Gui, WelcomeScreen: New, +LabelMyGui_On +AlwaysOnTop -Caption
     Gui, WelcomeScreen: Add, Picture, w500 h-1, % A_ScriptDir . "\OtagleBigLogo.png" ; Add the O T A G L E picture designed by Sylwia Ławrów 
     DetectHiddenWindows, On
     Gui, WelcomeScreen: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
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
          IniRead, ButtonWidth,                          % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonWidth
          IniRead, ButtonHeight,                         % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonHeight
          IniRead, ButtonHorizontalGap,                  % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonHorizontalGap
          IniRead, ButtonVerticalGap,                    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, ButtonVerticalGap
          IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Amount of buttons horizontally
          IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, Amount of buttons vertically
          TableOfLayers[LayerIndex] := []
          Gui, % "Layer" . LayerIndex . ": New", % "+hwndGuiLayer" . LayerIndex . "Hwnd" . " +LabelMyGui_On"
          ;~ Gui, % "Layer" . LayerIndex . ": Font", s18, Arial Black
          Loop, % AmountOfKeysVertically
               {
               VerticalIndex := A_Index
               Loop, % AmountOfKeysHorizontally
                    {
                    IniRead, ButtonX,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_X"
                    IniRead, ButtonY,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Y"
                    IniRead, ButtonW,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_W"
                    IniRead, ButtonH,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_H"
                    IniRead, PictureDef,    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Picture"
                    IniRead, PictureSel,    % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_PictureIfSelected"
                    IniRead, ButtonA,       % A_ScriptDir . "\Config.ini", % "Layer" . LayerIndex, % "Button_" . VerticalIndex . "_" . A_Index . "_Action"
                    
                    if (VerticalIndex = 1) and (A_Index = 1) ; the first button is set as default
                         Gui, % "Layer" . LayerIndex . ": Add", Button
                         , % "x" . ButtonX . " y" . ButtonY . " w" . ButtonW . " h" . ButtonH 
                         . " hwnd" . LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd" . " gL_ButtonPressed" . " v" . VerticalIndex . "_" . A_Index . " +Default"
                    else                                     ; the other buttons are set but not as default
                         Gui, % "Layer" . LayerIndex . ": Add", Button
                         , % "x" . ButtonX . " y" . ButtonY . " w" . ButtonW . " h" . ButtonH 
                         . " hwnd" . LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd" . " gL_ButtonPressed" . " v" . VerticalIndex . "_" . A_Index     
                    if (PictureDef = "") ; if there is no picture assigned to particular button ← the button should be disabled
                         GuiControl, % "Layer" . LayerIndex . ": Disable", % %LayerIndex%_%VerticalIndex%_%A_Index%hwnd ; Disable unused button
                    else ; if there is a picture, prepare its graphics
                         {   
                         WhichButton := LayerIndex . "_" . VerticalIndex . "_" . A_Index . "hwnd"
                         Opt1 := {1: 0, 2: PictureDef, 4: "Black"}
                         Opt2 := {2: PictureSel, 4: "Yellow"}
                         Opt5 := {2: PictureSel, 4: "Yellow"}
                         If !ImageButton.Create(%WhichButton%, Opt1, Opt2, , , Opt5)
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
     ;~ global WizardStep2_AmountOfKeysVertically, WizardStep2_AmountOfKeysHorizontally
     local GuziorX := 0, GuziorY := 0, GuziorW := 0, GuziorH := 0
     local PictureFilePath := ""
     local ButtonScript := ""
     
     IniWrite, % WizardStep2_AmountOfKeysHorizontally,  % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons horizontally
     IniWrite, % WizardStep2_AmountOfKeysVertically,    % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, Amount of buttons vertically
     
     ProgressBarVarMax := WizardStep2_AmountOfKeysVertically * WizardStep2_AmountOfKeysHorizontally * 6 ; 6 ← 6x IniWrite in internal loop
     ProgressBarTemp := 0
     
     Loop, % WizardStep2_AmountOfKeysVertically
          {
          ExternalLoopIndex := A_Index
          Loop, % WizardStep2_AmountOfKeysHorizontally
               {
               ;~ MsgBox, Tu jestem
               GuiControlGet, Guzior, Pos, % %ExternalLoopIndex%_%A_Index%hwnd
               IniWrite, % GuziorX,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_X"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorY,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Y"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorW,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_W"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorH,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_H"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % PictureFilePath, % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Picture"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % ButtonScript,    % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Action"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               }
          }
     }
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
F_AddButtonsAndGaps(IfEnable)
     {
     global ; Assume-global mode
     ;~ global WizardStep2_AmountOfKeysHorizontally, WizardStep2_AmountOfKeysVertically
     ;~ global ButtonHeight, ButtonWidth
     
     Gui, Wizard_PlotMatrixOfButtons: New, +LabelMyGui_On
     Gui, Wizard_PlotMatrixOfButtons: Margin, % ButtonHorizontalGap, % ButtonVerticalGap
     
     Loop, % WizardStep2_AmountOfKeysVertically
          {
          ExternalLoopIndex := A_Index
          Loop, % WizardStep2_AmountOfKeysHorizontally
               {
               if (A_Index = 1)
                    {
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "xm"  . " y+m" . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd"  . " gL_WizardButton", % ExternalLoopIndex . "_" . A_Index
                    if (IfEnable = "Disable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Disable, % %ExternalLoopIndex%_%A_Index%hwnd
                    else if (IfEnable = "Enable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Enable, % %ExternalLoopIndex%_%A_Index%hwnd
                    }
               else ; (A_Index > 1)
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"  . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd" . " gL_WizardButton", % ExternalLoopIndex . "_" . A_Index
                    if (IfEnable = "Disable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Disable, % %ExternalLoopIndex%_%A_Index%hwnd
                    else if (IfEnable = "Enable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Enable, % %ExternalLoopIndex%_%A_Index%hwnd
               }
          }
     }
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_ShowMonitorNumbers()

{
     global

     Loop, %HowManyMonitors%
          {
                  SysGet, MonitorBoundingCoordinates_, Monitor, %A_Index%
          Gui, %A_Index%:-SysMenu -Caption +Border
          Gui, %A_Index%:Color, Black ; WindowColor, ControlColor
          Gui, %A_Index%:Font, cWhite s26 bold, Calibri
          Gui, %A_Index%:Add, Text, x150 y150 w150 h150, % A_Index ; to działa
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
     WizardStep2_MarginHorizontally := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) - (WizardStep2_AmountOfKeysHorizontally * ButtonHorizontalGap + WizardStep2_AmountOfKeysHorizontally * ButtonWidth + ButtonHorizontalGap)
     WizardStep2_AmountOfKeysVertically := (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - ButtonVerticalGap) // (ButtonHeight + ButtonVerticalGap)
     WizardStep2_MarginVertically := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - (WizardStep2_AmountOfKeysVertically * ButtonVerticalGap + WizardStep2_AmountOfKeysVertically * ButtonHeight + ButtonVerticalGap)
     }