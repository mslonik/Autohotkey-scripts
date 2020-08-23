#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  							; Enable warnings to assist with detecting common errors. Commented out because of Class_ImageButton.ahk
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
; Layers := {} 

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


WizardStep2:   
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
     Gui, WizardStep3: Add, Text, , Click any of the buttons in the bottom window and associate up to 2 pictures and 1 function to it:`r`n * 1st picture which will be shown by default`r`n * 2nd function (*.ahk) which will be run after button is selected.
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


F_SavePositionOfButtons()
     {
     global ; Assume-global mode
     local ExternalLoopIndex, Guzior := 0
     local GuziorX := 0, GuziorY := 0, GuziorW := 0, GuziorH := 0
     local PictureFilePath := ""
     local ButtonScript := ""
     local ButtonPath :=""
     
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
               IniWrite, % ButtonPath,    % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Path"
               GuiControl, WizardStep2:, ProgressBarVar, % Round((++ProgressBarTemp / ProgressBarVarMax) * 100)
               }
          }
     }


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

L_WizardButton:
     Gui,               WizardStep3: Show, Hide
     Gui,               Wizard_PlotMatrixOfButtons: +OwnDialogs
     GuiControlGet,     ReadButtonPos, Wizard_PlotMatrixOfButtons: Pos, % A_GuiControl
     FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a picture file, Picture (*.svg; *.png)
     imgPath := SubStr(SelectedFile, StrLen(A_ScriptDir)+1)
     MsgBox,%imgPath%
     if (imgPath = "")
          {
          MsgBox,   No picture file was selected.
          Gui,      WizardStep3: Show
          }
     else
          {
               
          GuiControl, Wizard_PlotMatrixOfButtons: Hide, % A_GuiControl ; Hide the button
          Gui, Wizard_PlotMatrixOfButtons: Add, Picture, % "x" . ReadButtonPosX . " y" . ReadButtonPosY . " w" . ReadButtonPosW . " h-1", % SelectedFile ; Add the selected picture instead of button
          IniWrite, % ".." . imgPath,      % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . A_GuiControl . "_Picture" ; Save the picture into config file
          
          FileSelectFile, SelectedFile2, 3, , Select an .ahk or .exe file, File (*.ahk; *.exe)
          actionPath := SubStr(SelectedFile2, StrLen(A_ScriptDir)+2)
          MsgBox,%actionPath%
          if (actionPath = "") ; Now when picture is associated to a button, associate function as well.
               {
               MsgBox,   No action file was selected.
               Gui,      WizardStep3: Show
               }
          else
               {
               IniWrite, % actionPath,       % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . A_GuiControl . "_Action" ; Save the function into config file
               FileAppend, % "#Include *i " . actionPath . "`r`n", %A_ScriptDir%\ButtonFunctions.ahk, UTF-8
               T_Reload := 1 ; the ButtonFunctions.ahk file has been updated, so reload is required
               }
          }
           zm := A_GuiControl
           Gosub, WizardStep4 
      
return     


WizardStep4:

     Gui, WizardStep4: New, +LabelMyGui_On -DPIScale
     Gui, WizardStep4: Font, bold
     Gui, WizardStep4: Add, Text, , Step 2: `t`tSpecify amount buttons
     Gui, WizardStep4: Font
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))

     Gui, WizardStep4: Add, Text, xm, Which layer should the button move to
     Gui, WizardStep4: Add, Edit, x+m yp r1   vNlayesrs w150,1
     Gui, WizardStep4: Add, Button, xm w80  hwndSaveConfigHwnd gAdd, &Add
     Gui, WizardStep4: Add, Button, x+30 w80 gCloseS4, &Cancel
     Gui, WizardStep4: Show
 
return

Add:
Gui, WizardStep4: Submit, NoHide

if (Nlayesrs =""){
     MsgBox,   No action file was selected.
     Gui,      WizardStep3: Show   
}else{
     MsgBox, %Nlayesrs%
     IniWrite, % Nlayesrs,  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . zm . "_Path" ; Save the function into config file   
}
Gosub, CloseS4
Gui,      WizardStep3: Show   
return


CloseS4:
Gui,WizardStep4: Destroy
Gui,      WizardStep3: Show  
return

StartOtagle:
     
     Gui, WizardStep3:                  Destroy
     Gui, Wizard_PlotMatrixOfButtons:   Destroy
     ; if (T_Reload)
     ;      {
     ;      FileSetAttrib, +H, %A_ScriptDir%\ButtonFunctions.ahk  ; hide ButtonFunctions.ahk     
     ;      MsgBox, 0, % ApplicationName, % ApplicationName . " will reload now in order to apply updated settings" 
     ;      Reload
     ;      }
     ; else
     ;      {
     ;      Gosub,  Traymenu     ; Jumps to the specified label and continues execution until Return is encountered
     ;      F_ReadConfig_ini()
     ;      CurrentLayer := 1  ; initialization of application
     ;      EditFlag := 0
     ;      SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor 
     ;      try          
               ; F_DisplayLayer(CurrentLayer)
          ; catch e
          ;      {
          ;      MsgBox, An exception was thrown!`r`nIncorrect value of Monitor variable within Config.ini. Probably this monitor has not been found. Application will exit now.
          ;      Exit, 1
          ;      }
          ; Gui, ProgressBar:Destroy
          ; }
return

L_AddNextLayer:
     Gui, Wizard_PlotMatrixOfButtons:   Destroy
     Gui, WizardStep3:                  Destroy
     HowManyLayers++
     T_CalculateButton := 0
     Goto WizardStep2


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
; - -      



SaveConfigurationWizard:
     if (T_CalculateButton = 0)
          {
          MsgBox, 0, % WindowWizardTitle, Press Calculate button at first.
          return
          }
     
     IniWrite, % WhichMonitor,            % A_ScriptDir . "\Config.ini", Main,                      WhichMonitor
     IniWrite, % HowManyLayers,           % A_ScriptDir . "\Config.ini", Main,                      HowManyLayers ; Save the total amount of created layers
     IniWrite, % Title,                   % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  Title
     IniWrite, % Floor(100/WizardStep2_AmountOfKeysHorizontally),             % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonWidth
     IniWrite, % Floor(100/WizardStep2_AmountOfKeysHorizontally),            % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHeight
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



ExitWizard:
     ;~ MsgBox, 4,, Do you want to close O T A G L E?
     ;~ IfMsgBox, No
     ;~ return
ExitApp


MsgText(string)
{
    vSize := StrPut(string, "CP0")
    VarSetCapacity(vUtf8, vSize)
    vSize := StrPut(string, &vUtf8, vSize, "CP0")
    Return StrGet(&vUtf8, "UTF-8") 
}