/*
Author:      Maciej Słojewski, mslonik, http://mslonik.pl
Purpose:     Facilitate normal operation for company desktop.
Description: Hotkeys and hotstrings for my everyday professional activities and office cockpit.
License:     GNU GPL v.3
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent

     CurrentLayer                           := 1
     ;~ MonitorRadioGroup                      := 3 ; 0
     MonitorRadioGroup                      := 0
     WindowWizardTitle                      := "O T A G L E Configuration Wizard"
     ;~ ButtonWidth                            := 300 ; 80
     ButtonWidth                            := 80
     ;~ ButtonHeight                           := 300 ; 80
     ButtonHeight                           := 80
     ButtonHorizontalGap                    := 10
     ButtonVerticalGap                      := 10
     CalculateVariable                      := 0
     MonitorBoundingCoordinates_Left        := 0
     MonitorBoundingCoordinates_Right       := 0
     MonitorBoundingCoordinates_Top         := 0
     MonitorBoundingCoordinates_Bottom      := 0
     ;~ PictureSelected                        := 0
     ;~ ScriptSelected                         := 0
     ReadButtonPosX                         := 0
     ReadButtonPosY                         := 0
     ReadButtonPosW                         := 0
     ReadButtonPosH                         := 0

; Temp:
;~ WizardStep2_AmountOfKeysHorizontally := 6
;~ WizardStep2_AmountOfKeysVertically   := 3

DetectHiddenWindows, On ; Caution!
;~ - - - - - - - - - - - - - - - - - - - - ProcessInputArgs() - - - - - - - - - - - - - - - - - - - -

if (A_Args.Length() = 0)
    {
    IfExist, *.ini
        {
        MsgBox, 16, %A_ScriptName%, At least one *.ini file found in directory `n`n%A_WorkingDir%`n`n but current script (%A_ScriptName%) was run without any arguments.`n`nOne argument`
              , the name of .ini file`, is obligatory. Therefore script will now exit.
        ExitApp, 0
        }
    IfNotExist, *.ini
        MsgBox, 4, %A_ScriptName%, No input arguments found and no *.ini files found in directory`n %A_ScriptDir%`n`nExpected at least a single *.ini file
               .`n`nDo you want to run %WindowWizardTitle% which will help you to create Config.ini ? `n`n
    IfMsgBox, No
        ExitApp, 0
    IfMsgBox, Yes
        Goto  Wizard_Intro
    }
else if (A_Args.Length() = 1)
     {
     F_ReadConfig_ini()
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     ;~ MsgBox, 4, ,Switch between layers
     ;~ IfMsgBox, No
          Gui, % "Layer" . CurrentLayer . ": Show", % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % "O T A G L E: Layer " . CurrentLayer
     ;~ IfMsgBox, Yes
          ;~ Gui, Layer2: Show, % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", O T A G L E: Layer 2
     ;~ MsgBox, Narysowane!
     return
     }
else if (A_Args.Length() > 1)
    {
    MsgBox, 48, Diacritic.ahk, % "Too many input arguments: " . A_Args.Length() . ". Expected just one, *.ini." 
    ExitApp, 0
    }


Wizard_Intro:
     Gui, Wizard_Intro: Font, bold
     Gui, Wizard_Intro: Add, Text, w500, Introduction
     Gui, Wizard_Intro: Font, 
     Gui, Wizard_Intro: Add, Text, w500, When there is no otagle.ini file or on purspose User decided to change crucial application settings, this wizard appears. User is asked to answer 3 questions related to settings of monitor.
     Gui, Wizard_Intro: Add, Text, w500, Step 1: `t`tChoose a monitor where GUI of OTAGLE will be located.
     Gui, Wizard_Intro: Add, Text, w500, Step 2: `t`tCheck monitor size, specify amount and size of buttons.
     Gui, Wizard_Intro: Add, Text, w500, Step 3: `t`tPlot on the screen matrix of buttons.
     Gui, Wizard_Intro: Add, Button, % "Default xm+" . 500//3 . " w80 gWizardStep1", &Next
     Gui, Wizard_Intro: Add, Button, x+30 w80 gExitWizard, &Cancel
     Gui, Wizard_Intro: Show, , % WindowWizardTitle . " Layer " . CurrentLayer
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return 


WizardStep1:
     CalculateVariable := 0
     Gui, Wizard_Intro:    Destroy
     Gui, Wizard_AmountAndSizeOfButtons: Destroy
     Gui, Wizard_WhereGUI: Submit, NoHide
     Gui, Wizard_WhereGUI: Destroy
     
     Gui, Wizard_WhereGUI: Font, bold
     Gui, Wizard_WhereGUI: Add, Text, w500, Step 1 out of 3: `t`tChoose a monitor where GUI of OTAGLE will be located.
     Gui, Wizard_WhereGUI: Font
     Gui, Wizard_WhereGUI: Add, Text, w500, Specify one out of the available Monitor No.

     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
     
     if (MonitorRadioGroup = 0) 
          MonitorRadioGroup := WhichIsPrimary
     
     Loop, % HowManyMonitors
          {
          if (A_Index = MonitorRadioGroup)
               Gui, Wizard_WhereGUI: Add, Radio, xm+50 gWizardStep1 AltSubmit vMonitorRadioGroup Checked, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
          else
               Gui, Wizard_WhereGUI: Add, Radio, xm+50 gWizardStep1 AltSubmit, % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
          }     
     Gui, Wizard_WhereGUI: Add, Button, Default xm+30 y+20 gCheckMonitorNumbering, &Check Monitor Numbering
     Gui, Wizard_WhereGUI: Add, Button, x+30 w80 gWizardStep2, &Next
     Gui, Wizard_WhereGUI: Add, Button, x+30 w80 gWizard_Intro, &Back
     Gui, Wizard_WhereGUI: Add, Button, x+30 w80 gExitWizard, &Cancel
     SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup
     Gui, Wizard_WhereGUI: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . "y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle . " Layer " . CurrentLayer
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, A
return


WizardStep2:
     Gui, Wizard_WhereGUI: Destroy
     Gui, Wizard_AmountAndSizeOfButtons: Font, bold
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, , Step 2: `t`tCheck monitor size, specify amount and size of buttons.
     Gui, Wizard_AmountAndSizeOfButtons: Font
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup

     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, y+20
          , % "Monitor #: " . MonitorRadioGroup . "`tMonitor width: " . Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) 
          . "`tMonitor height: " . Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) . " Suggested size of key: 80x80 px and gap size: 20x20 px."
          
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, Specify key size width: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 w50
     Gui, Wizard_AmountAndSizeOfButtons: Add, UpDown, vButtonWidth Range1-300, % ButtonWidth
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, x+m yp, Specify key size height: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 w50
     Gui, Wizard_AmountAndSizeOfButtons: Add, UpDown, vButtonHeight Range1-300, % ButtonHeight
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, Specify horizontal gap between buttons: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 w50
     Gui, Wizard_AmountAndSizeOfButtons: Add, UpDown, vButtonHorizontalGap Range0-300, % ButtonHorizontalGap
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, x+m yp, Specify vertical gap between buttons: `
     Gui, Wizard_AmountAndSizeOfButtons: Add, Edit, x+m yp r1 w50
     Gui, Wizard_AmountAndSizeOfButtons: Add, UpDown, vButtonVerticalGap Range0-300, % ButtonVerticalGap
     
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, xm Default w80 gBCalculate, C&alculate 
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, % "Number of keys horizontally in px: " . (CalculateVariable ? WizardStep2_AmountOfKeysHorizontally : "") 
          . " and not used margin at the left side in px: " . (CalculateVariable ? WizardStep2_MarginHorizontally : "")
     Gui, Wizard_AmountAndSizeOfButtons: Add, Text, xm, % "Number of keys vertically in px: " . (CalculateVariable ? WizardStep2_AmountOfKeysVertically : "") 
          . " and not used margin at the bottom side in px: " . (CalculateVariable ? WizardStep2_MarginVertically : "")

     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, x50 y+20 w80 gPlotButtons hwndTestButtonHwnd, &Test
     
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, x+30 w80 gWizardStep1, &Back
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, x+30 w80 gExitWizard, &Cancel
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, xm w80 gSaveConfigurationWizard hwndSaveConfigHwnd, &Save config
     if (CalculateVariable = 0)
          {
          GuiControl, Wizard_AmountAndSizeOfButtons: Disable, % TestButtonHwnd
          GuiControl, Wizard_AmountAndSizeOfButtons: Disable, % SaveConfigHwnd
          }
     Gui, Wizard_AmountAndSizeOfButtons: Add, Progress, x+m w350 h25 cGreen vProgressBarVar BackgroundC9C9C9, 0
     SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup
     Gui, Wizard_AmountAndSizeOfButtons: Show
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     Gui, Wizard_AmountAndSizeOfButtons: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2)
          , % WindowWizardTitle . " Layer " . CurrentLayer
return

BCalculate:
     CalculateVariable := 1
     Gui, Wizard_AmountAndSizeOfButtons: Submit
     CalculateButtonsAndGaps()
     Gui, Wizard_AmountAndSizeOfButtons: Destroy
     GuiControl, Wizard_AmountAndSizeOfButtons: Enable, % TestButtonHwnd
     GuiControl, Wizard_AmountAndSizeOfButtons: Enable, % SaveConfigHwnd
     Goto, WizardStep2
return

PlotButtons:
     Gui, Wizard_AmountAndSizeOfButtons:    Submit, NoHide
     Gui, Wizard_AmountAndSizeOfButtons:    Destroy
     Gui, Wizard_PlotMatrixOfButtons:       Destroy
     
     CalculateButtonsAndGaps()
     Gui, Wizard_PlotMatrixOfButtons: Margin, % ButtonHorizontalGap, % ButtonVerticalGap
     F_AddButtonsAndGaps("Disable")
     Gui, Wizard_PlotMatrixOfButtons: Show, % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle . " Layer " . CurrentLayer 
     MsgBox, 4096,  % WindowWizardTitle, Press OK button to continue to go back: test new configuration again or save it.
     Gui, Wizard_PlotMatrixOfButtons: Submit ; Hide
     GoTo, WizardStep2
return

SaveConfigurationWizard:
     if (CalculateVariable = 0)
          {
          MsgBox, 0, % WindowWizardTitle, Press Calculate button at first.
          return
          }

     IniWrite, % MonitorRadioGroup,       % A_ScriptDir . "\Config.ini", Main, WhichMonitor
     IniWrite, % ButtonWidth,             % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, ButtonWidth
     IniWrite, % ButtonHeight,            % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, ButtonHeight
     IniWrite, % ButtonHorizontalGap,     % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, ButtonHorizontalGap
     IniWrite, % ButtonVerticalGap,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, ButtonVerticalGap


     Gui, Wizard_PlotMatrixOfButtons: +LastFoundExist
     if (WinExist())
          {
          F_SavePositionOfButtons()     
          }
     else
          {
          ;~ CalculateButtonsAndGaps()
          F_AddButtonsAndGaps("Disable")
          F_SavePositionOfButtons()
          }

     MsgBox, 0, % WindowWizardTitle, % "Configuration saved to the file :`n" . A_ScriptDir . "\Config.ini"

     GuiControl, Disable, % SaveConfigHwnd
     Gui, Wizard_AmountAndSizeOfButtons: Add, Button, x+m w80 gWizardStep3, C&ontinue
return


WizardStep3:
     ;~ Ta linijka 
     Gui, Wizard_AmountAndSizeOfButtons: Destroy
     
     Gui, Wizard_PlotMatrixOfButtons: +LastFoundExist
     if (WinExist())
          Gui, Wizard_PlotMatrixOfButtons: Destroy
     Gui, Wizard_PlotMatrixOfButtons: Margin, % ButtonHorizontalGap, % ButtonVerticalGap
     F_AddButtonsAndGaps("Enable")
     Gui, Wizard_PlotMatrixOfButtons: Show, % "x" . MonitorBoundingCoordinates_Left . " y" . MonitorBoundingCoordinates_Top . " Maximize", % WindowWizardTitle . " Layer " . CurrentLayer
          
     Gui, Wizard_ConfigureFunctions: Font, bold
     Gui, Wizard_ConfigureFunctions: Add, Text, , Step 3: `t`tAssociate functions with buttons.
     Gui, Wizard_ConfigureFunctions: Font
     Gui, Wizard_ConfigureFunctions: Add, Text, , Click any of the buttons in the bottom window and associate a picture and function to it.
     Gui, Wizard_ConfigureFunctions: Add, Button, xm+30 w80 gStartOtagle, &Finish wizard
     Gui, Wizard_ConfigureFunctions: Add, Button, x+30 w80 gNextLayer, &Next layer

     Gui, Wizard_ConfigureFunctions: Show ; small trick to correctly calculate position of window on a screen
          , % "hide" . " x" . MonitorBoundingCoordinates_Left 
          . " y" . MonitorBoundingCoordinates_Top
          , HiddenAttempt
     WinGetPos, , , WizardWindow_Width, WizardWindow_Height, HiddenAttempt
     
     ; Ta linijka
     ;~ SysGet, MonitorBoundingCoordinates_, Monitor, % MonitorRadioGroup ; ← do usunięcia
     
     Gui, Wizard_ConfigureFunctions: Show
          , % "x" . MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (WizardWindow_Width / 2) 
          . " y" . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (WizardWindow_Height / 2), % WindowWizardTitle
          , % WindowWizardTitle  . " Layer " . CurrentLayer
return

ButtonPressed:
     Gui,               Wizard_ConfigureFunctions: Show, Hide
     Gui,               Wizard_PlotMatrixOfButtons: +OwnDialogs
     GuiControlGet,     ReadButtonPos, Wizard_PlotMatrixOfButtons: Pos, % A_GuiControl
     FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a picture file, Picture (*.png; *.jpg)
     if (SelectedFile = "")
          {
          MsgBox,   No picture file was selected.
          Gui,      Wizard_ConfigureFunctions: Show
          }
     else
          {
          GuiControl, Wizard_PlotMatrixOfButtons: Hide, % A_GuiControl ; Hide the button
          Gui, Wizard_PlotMatrixOfButtons: Add, Picture, % "x" . ReadButtonPosX . " y" . ReadButtonPosY . " w" . ReadButtonPosW . " h-1", % SelectedFile ; Add the selected picture instead of button
          ;~ MsgBox, Tu jestem!
          IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Picture" ; Save the picture into config file
          FileSelectFile, SelectedFile, 3, %A_ScriptDir%, Select an .ahk script file, AHK script (*.ahk)
          if (SelectedFile = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No picture file was selected.
               Gui,      Wizard_ConfigureFunctions: Show
               }
          else
               {
               IniWrite, % SelectedFile,       % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . A_GuiControl . "_Action" ; Save the picture into config file
               }
          }
     Gui,      Wizard_ConfigureFunctions: Show
return

PicturePressed:
     MsgBox, % "Picture was activated!`n" . A_GuiControl
     ;~ MsgBox, % A_GuiControl
     ;~ SplitPath, % A_GuiControl, FunctionName
     ;~ MsgBox, % FunctionName
return

StartOtagle:
     IniWrite, % CurrentLayer,       % A_ScriptDir . "\Config.ini", Main, HowManyLayers ; Save the total amount of created layers
     CurrentLayer := 1  ; initialization of application
     ExitApp ; ← temporarily
return

NextLayer:
     Gui, Wizard_PlotMatrixOfButtons:   Destroy
     Gui, Wizard_ConfigureFunctions:    Destroy
     CurrentLayer++
     CalculateVariable := 0
     Goto Wizard_Intro
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

GuiClose:
ExitWizard:
     ExitApp


; ------------------------------ SECTION OF FUNCTIONS ---------------------------------------

F_ReadConfig_ini()
     {
     global
     local HowManyLayers
     local ExternalLoopLayersIndex, ExternalLoopVerticallyIndex
     local ButtonX, ButtonY, ButtonW, ButtonH, ButtonP
     
     IniRead, WhichMonitor,               % A_ScriptDir . "\Config.ini", Main, WhichMonitor
     IniRead, HowManyLayers,              % A_ScriptDir . "\Config.ini", Main, HowManyLayers
     
     Loop, % HowManyLayers
          {
          ExternalLoopLayersIndex := A_Index
          IniRead, ButtonWidth,                          % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, ButtonWidth
          IniRead, ButtonHeight,                         % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, ButtonHeight
          IniRead, ButtonHorizontalGap,                  % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, ButtonHorizontalGap
          IniRead, ButtonVerticalGap,                    % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, ButtonVerticalGap
          IniRead, AmountOfKeysHorizontally,             % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, Amount of buttons horizontally
          IniRead, AmountOfKeysVertically,               % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, Amount of buttons vertically
          LayerObj := {}
          Loop, % AmountOfKeysVertically
               {
               ExternalLoopVerticallyIndex := A_Index
               Loop, % AmountOfKeysHorizontally
                    {
                    IniRead, ButtonX, % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, % "Button_" . ExternalLoopVerticallyIndex . "_" . A_Index . "_X"
                    IniRead, ButtonY, % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, % "Button_" . ExternalLoopVerticallyIndex . "_" . A_Index . "_Y"
                    IniRead, ButtonW, % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, % "Button_" . ExternalLoopVerticallyIndex . "_" . A_Index . "_W"
                    IniRead, ButtonH, % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, % "Button_" . ExternalLoopVerticallyIndex . "_" . A_Index . "_H"
                    IniRead, ButtonP, % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, % "Button_" . ExternalLoopVerticallyIndex . "_" . A_Index . "_Picture"
                    IniRead, ButtonA, % A_ScriptDir . "\Config.ini", % "Layer" . ExternalLoopLayersIndex, % "Button_" . ExternalLoopVerticallyIndex . "_" . A_Index . "_Action"
                    Gui, % "Layer" . ExternalLoopLayersIndex . ": Add"
                    , Button, % "x" . ButtonX . " y" . ButtonY . " w" . ButtonW . " h" . ButtonH . " hwnd" . ExternalLoopLayersIndex . "_" . A_Index . "hwnd" . " gButtonPressed"
                    , % ExternalLoopLayersIndex . "_" . A_Index
                    if (ButtonP = "")
                         GuiControl, % "Layer" . ExternalLoopLayersIndex . ": Disable", % %ExternalLoopLayersIndex%_%A_Index%hwnd ; Disable unused button
                    else
                         {   
                         GuiControl, % "Layer" . ExternalLoopLayersIndex . ": Hide", % %ExternalLoopLayersIndex%_%A_Index%hwnd ; Hide the button
                         Gui, % "Layer" . ExternalLoopLayersIndex . ": Add", Picture, % "x" . ButtonX . " y" . ButtonY . " w" . ButtonW . " h-1" . " vPicture" . ExternalLoopVerticallyIndex . "_" . A_Index . " gPicturePressed"
                         , % ButtonP ; Add the selected picture instead of button
                         Key := ExternalLoopVerticallyIndex . "_" . A_Index
                         MsgBox, % "ExternalLoopVerticallyIndex: " . ExternalLoopVerticallyIndex . "`n A_Index: " . A_Index . "`nKey: " . Key
                         LayerObj[Key] := ButtonA
                         MsgBox, % "Key: " . Key . "`nValue: " . LayerObj[Key]
                         }
                    
                    if (ButtonA)
                         {
                         SplitPath, % ButtonA, FunctionName     
                         ;~ Temp := "Picture" . ExternalLoopVerticallyIndex . "_" . A_Index ; to działa
                         ;~ "Picture" . ExternalLoopVerticallyIndex . "_" . A_Index := FunctionName ; to nie działa
                         ;~ MsgBox, % Picture . ExternalLoopVerticallyIndex . "_" . A_Index
                         ;~ MsgBox, % Temp . "`n" . FunctionName
                         ;~ %Temp% := %FunctionName%
                         ;~ MsgBox, % Temp
                         }
                    }
               }
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
               GuiControl, Wizard_AmountAndSizeOfButtons:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorY,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Y"
               GuiControl, Wizard_AmountAndSizeOfButtons:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorW,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_W"
               GuiControl, Wizard_AmountAndSizeOfButtons:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % GuziorH,         % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_H"
               GuiControl, Wizard_AmountAndSizeOfButtons:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % PictureFilePath, % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Picture"
               GuiControl, Wizard_AmountAndSizeOfButtons:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               IniWrite, % ButtonScript,    % A_ScriptDir . "\Config.ini", % "Layer" . CurrentLayer, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Action"
               GuiControl, Wizard_AmountAndSizeOfButtons:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               }
          }
     }
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
F_AddButtonsAndGaps(IfEnable)
     {
     global ; Assume-global mode
     ;~ global WizardStep2_AmountOfKeysHorizontally, WizardStep2_AmountOfKeysVertically
     ;~ global ButtonHeight, ButtonWidth
     
     Loop, % WizardStep2_AmountOfKeysVertically
          {
          ExternalLoopIndex := A_Index
          Loop, % WizardStep2_AmountOfKeysHorizontally
               {
               if (A_Index = 1)
                    {
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "xm"  . " y+m" . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd"  . " gButtonPressed", % ExternalLoopIndex . "_" . A_Index
                    if (IfEnable = "Disable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Disable, % %ExternalLoopIndex%_%A_Index%hwnd
                    else if (IfEnable = "Enable")
                         GuiControl, Wizard_PlotMatrixOfButtons: Enable, % %ExternalLoopIndex%_%A_Index%hwnd
                    }
               else ; (A_Index > 1)
                    Gui, Wizard_PlotMatrixOfButtons: Add, Button, % "x+m" . " yp"  . " w" . ButtonWidth . " h" . ButtonHeight . " hwnd" . ExternalLoopIndex . "_" . A_Index . "hwnd" . " gButtonPressed", % ExternalLoopIndex . "_" . A_Index
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

CalculateButtonsAndGaps()     
     {
     global WizardStep2_AmountOfKeysHorizontally, WizardStep2_MarginHorizontally, WizardStep2_AmountOfKeysVertically, WizardStep2_MarginVertically
     global MonitorBoundingCoordinates_, MonitorBoundingCoordinates_Bottom, MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Right, MonitorBoundingCoordinates_Top
     global MonitorRadioGroup, ButtonWidth, ButtonHeight, ButtonHorizontalGap, ButtonVerticalGap
     
     WizardStep2_AmountOfKeysHorizontally := (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) -  ButtonHorizontalGap) // ( ButtonWidth + ButtonHorizontalGap)
     WizardStep2_MarginHorizontally := Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) - (WizardStep2_AmountOfKeysHorizontally * ButtonHorizontalGap + WizardStep2_AmountOfKeysHorizontally * ButtonWidth + ButtonHorizontalGap)
     WizardStep2_AmountOfKeysVertically := (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - ButtonVerticalGap) // (ButtonHeight + ButtonVerticalGap)
     WizardStep2_MarginVertically := Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - (WizardStep2_AmountOfKeysVertically * ButtonVerticalGap + WizardStep2_AmountOfKeysVertically * ButtonHeight + ButtonVerticalGap)
     }