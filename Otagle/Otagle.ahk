/*
Author:      Maciej Słojewski, mslonik, http://mslonik.pl
Purpose:     Mimic Elgato stream deck solution with some cheap hardware from China.
Description: Put a virtual numeric keypad on the screen.
Name:        otagle <- anagram of elgato or just "flow"
License:     GNU GPL v.3 (https://www.gnu.org/licenses/gpl-3.0.html)

To do - software:
     - Turn on / off sound
     - Configuration file
     - Menu

To do - hardware:
     - voice speaker,
     - small engine like in a phone
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.

global ApplicationName := "O T A G L E"

global TouchScreenWidth := 600 ; onfiguration parameter
global TouchScreenHeight := 1024 ; onfiguration parameter

global WindowMarginLeft := WindowMarginTop := 10
global ColumnMargin := RowMargin := 20
global PictureWidth := PictureHeight := 130
global ButtonHeight := 30
global PictureHeightLong := PictureHeight * 2 + RowMargin + ButtonHeight
global PictureWidthLong := PictureWidth * 2 + ColumnMargin
global ButtonWidth := PictureWidth
global ButtonWidthLong := ButtonWidth * 2 + ColumnMargin

global WindowWidth := 4 * PictureWidth + 3 * ColumnMargin + 2 * WindowMarginLeft ; 600 px
global WindowHeight := 5 * PictureHeight + 5 * ButtonHeight + 4 * RowMargin + 2 * WindowMarginTop ; 900 px

global AuxiliaryTextWidth := WindowWidth - 2 * WindowMarginLeft
global AuxiliaryTextHeight := TouchScreenHeight - WindowHeight - 2 * WindowMarginTop
     
global WhichSound := 0 ; to play different sounds upon key presses

global BaseLayer := 0
global Word_BaseLayer := 1
global Word_BBLayer := 2
global Word_TemplateStyles1 := 3
global Word_TemplateStyles2 := 4
global NumLock_Layer := 5
global Macro_Layer := 6

global LastLayer := BaseLayer

#Include %A_ScriptDir%\Layer0\Layer0.ahk
#Include %A_ScriptDir%\Layer1\Layer1.ahk
#Include %A_ScriptDir%\Layer2\Layer2.ahk
#Include %A_ScriptDir%\Layer3\Layer3.ahk
#Include %A_ScriptDir%\Layer4\Layer4.ahk
#Include %A_ScriptDir%\Layer5\Layer5.ahk
#Include %A_ScriptDir%\Layer6\Layer6.ahk

F_Layer0()
F_Layer1()
F_Layer2()
F_Layer3()
F_Layer4()
F_Layer5()
F_Layer6()

F_FindTouchScreen()

F_NumLockLayer(GetKeyState("NumLock", "T"))


; - - - - - - - - - - END OF INITIALIZATION - - - - - - - - - - - - - - -

~NumLock:: ; NumLock key support
     KeyWait, NumLock
     F_SoundPlay()
     F_NumLockLayer(GetKeyState("NumLock", "T"))
return

NumLockP:
NumLockB:
     SetNumLockState % !GetKeyState("NumLock", "T") ; Toggles NumLock state to its opposite state
     F_SoundPlay()
     F_NumLockLayer(GetKeyState("NumLock", "T"))
return


;~ 1st row
NumpadDiv::
NumpadDivP:
NumpadDivB:
     if (LastLayer == BaseLayer)
          {
          F_SoundPlay()
          RunOrActivateKeePass()
          }
     else if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          MoveToLayer(Word_TemplateStyles1)
          ActivateWord()
          }
     else if (LastLayer == Word_BBLayer)
          {
          F_SoundPlay()
          ActivateWord()          
          BB_Insert("Mona")
          }
     else if (LastLayer == Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()          
          TemplateStyle("Normal", "Normal")
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Table modified", "Table modified")
          }    
     else if (LastLayer == Macro_Layer)
          {
          F_SoundPlay()
          ActivateWord()
          VBA_RunMacro("RedTypeface")
          }    
return

NumpadMult::
NumpadMultP:
NumpadMultB:
     if (LastLayer == BaseLayer)
          {
          F_SoundPlay()
          MoveToLayer(Word_BaseLayer)
          RunOrActivateWord()
          }
     else if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          ActivateWord()
          MoveToLayer(Word_BBLayer)
          }
     else if (LastLayer == Word_BBLayer)
          {
          F_SoundPlay()
          ActivateWord()
          BB_Insert("Table Example")
          }     
     else if (LastLayer == Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Normal between", "Normal between")
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          ActivateWord()     
          TemplateStyle("Table legend", "Table legend")
          }    
     else if (LastLayer == Macro_Layer)
          {
          F_SoundPlay()
          ActivateWord()     
          VBA_RunMacro("TextBorder")
          }    
return

NumpadSub::
NumpadSubP:
NumpadSubB:
     if (LastLayer == BaseLayer)
          {
          F_SoundPlay()
          RunOrActivateTotalCommander()
          }
     else if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          MoveToLayer(Macro_Layer)
          ActivateWord()
          }
     else if (LastLayer == Word_BBLayer)
          {
          F_SoundPlay()
          ActivateWord()
          BB_Insert("Dissertation")
          }     
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 1", "Heading 1")     
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Table modfied without grid", "Table modfied without grid")
          }    
     else if (LastLayer == Macro_Layer)
          {
          F_SoundPlay()
          ActivateWord()
          VBA_RunMacro("TableAutofitToTextBorder")
          }    
return

;~ 2nd row
NumpadHome::
NumpadHomeP:
NumpadHomeB:
     if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          ActivateWord()          
          SetTemplate("EN", "Attach the Example Template to this document")
          }     
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 2")     
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Text in table", "Text in table")
          }    
return

NumpadUp::
NumpadUpP:
NumpadUpB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 3")     
          }          
return

NumpadPgup::
NumpadPgUpP:
NumpadPgUpB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 4")     
          }          
return          

NumpadAdd::
NumPadAddP:
NumPadAddB:
     if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          MoveToLayer(BaseLayer)
          }
     else if (LastLayer == Word_BBLayer)
          {
          F_SoundPlay()
          MoveToLayer(Word_BaseLayer)
          ActivateWord()
          }
     else if (LastLayer == Word_TemplateStyles1)
          {
          F_SoundPlay()
          MoveToLayer(Word_BaseLayer)
          ActivateWord()
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          MoveToLayer(Word_TemplateStyles1)
          ActivateWord()
          }     
     else if (LastLayer == Macro_Layer)
          {
          F_SoundPlay()
          MoveToLayer(Word_BaseLayer)
          ActivateWord()
          }     
return

;~ 3rd row
NumpadLeft::
NumpadLeftP:
NumpadLeftB:
     if (LastLayer ==  Word_BaseLayer)
          {
          F_SoundPlay()
          StrikeThroughText()
          ActivateWord()
          }          
          else if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 5")
          }          
return

NumpadClear::
NumpadBlankP:
NumpadBlankB:
     if (LastLayer ==  Word_BaseLayer)
          {
          F_SoundPlay()
          HideSelectedText()
          ActivateWord()
          }          
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 6")
          }          
return

NumpadRight::
NumpadRightP:
NumpadRightB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 7")     
          }          
return

;~ 4th row
NumpadEnd::
NumpadEndP:
NumpadEndB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Heading 8")     
          }          
return

NumpadDown::
NumpadDownP:
NumpadDownB:
return

NumpadPgdn::
NumpadPgDnP:
NumpadPgDnB:
return

NumpadEnter::
NumpadEnterP:
NumpadEnterB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          MoveToLayer(Word_TemplateStyles2)     
          ActivateWord()
          }          
return

;~ 5th row
NumpadIns::
NumpadInsP:
NumpadInsB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Small line")     
          }          
return

NumpadDel::
NumpadDelP:
NumpadDelB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          ActivateWord()
          TemplateStyle("Hidden special")     
          }          
return

AuxiliaryInformation:
     Run, http://mslonik.pl
return

Layer0GuiClose:
Layer1GuiClose:
Layer2GuiClose:
Layer3GuiClose:
Layer4GuiClose:
Layer5GuiClose:
     ExitApp


; - - - - - - - - - - - FUNCTIONS - - - - - - - - - - -


F_NumLockLayer(V_NumLockState)
{
global LastLayer, ApplicationName, DefaultX, DefaultY    
     
if (V_NumLockState == 0) ; Show
     {
     MoveToLayer(BaseLayer)     
     }
else 
     {
     MoveToLayer(NumLock_Layer)     
     }
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

MoveToLayer(WhichLayer)
{
     global LastLayer, ApplicationName, DefaultX, DefaultY
     
     TempVarLayer := "Layer" . LastLayer
     ;~ WinGetPos, X, Y, , , %ApplicationName% ; amount of parameters matters...
     Gui, %TempVarLayer%:Hide
     LastLayer := WhichLayer
     TempVarLayer := "Layer" . LastLayer
     ;~ Gui, %TempVarLayer%:Show, x%X% y%Y%, %ApplicationName% ; it works
     ;~ Gui, % TempVarLayer ":Show", % "x"X "y"Y, % ApplicationName ; it works as well, alternative solution to above line
     ;~ Gui, % TempVarLayer ":Show", % "x"DefaultX "y"DefaultY, % ApplicationName 
     Gui, % TempVarLayer ":Show", % "x"DefaultX "y"DefaultY "Maximize", % ApplicationName 
     ;~ Gui, % TempVarLayer ":Show", Maximize, % ApplicationName 
     ;~ WinTitle = A
     ;~ SysGet, Display_, Monitor, 4
     ;~ WinGetPos,,, WinW, WinH, % WinTitle
     ;~ WinMove, % WinTitle,, % Floor( (Display_Right/2)-(WinW/2) ), % Floor( (Display_Bottom/2)-(WinH/2) )
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_SoundPlay()
{
     global WhichSound
     
     WhichSound++
     if (WhichSound == 1)
          {
          SoundPlay, %A_ScriptDir%\\Sounds\MechanicalKeyboarSingleButtonPresses4_wwwFesliyanStudiosCom.mp3 
          }
     else if (WhichSound == 2)
          {
          SoundPlay, %A_ScriptDir%\\Sounds\MechanicalKeyboarSingleButtonPresses7_wwwFesliyanStudiosCom.mp3 
          }
     else if (WhichSound == 3)
          {
          SoundPlay, %A_ScriptDir%\\Sounds\MechanicalKeyboarSingleButtonPresses9_wwwFesliyanStudiosCom.mp3 
          WhichSound := 0
          }
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_FindTouchScreen()

{
     global DefaultX, DefaultY
     
     SysGet, HowManyMonitors, MonitorCount
     Loop, %HowManyMonitors%
          {
          SysGet, MonitorBoundingCoordinates, Monitor, %A_Index%
          MonitorWidth := Abs(MonitorBoundingCoordinatesLeft - MonitorBoundingCoordinatesRight)
          MonitorHeight := Abs(MonitorBoundingCoordinatesTop - MonitorBoundingCoordinatesBottom)
          if (MonitorWidth == TouchScreenWidth && MonitorHeight == TouchScreenHeight)
               {
               ;~ DefaultX := MonitorBoundingCoordinatesLeft - 4 ; to do: determine why I need -4
               DefaultX := MonitorBoundingCoordinatesLeft 
               DefaultY := MonitorBoundingCoordinatesTop     
               }
          else
               {
               DefaultX := 0
               DefaultY := 0
               }
               
          }     
}

;- - - - - - - - - - - - - - - - - - - LABELS - - - - - - - - - - - - - - - 

SwitchOffTooltip:
	ToolTip ,
return

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Include %A_ScriptDir%\Layer0\RunOrActivateWord.ahk
#Include %A_ScriptDir%\Layer0\RunOrActivateKeePass.ahk
#Include %A_ScriptDir%\Layer0\RunOrActivateTotalCommander.ahk
#Include %A_ScriptDir%\Layer1\SetTemplate.ahk
#Include %A_ScriptDir%\Layer1\StrikeThroughText.ahk
#Include %A_ScriptDir%\Layer1\HideSelectedText.ahk
#Include %A_ScriptDir%\Layer2\BB_Insert.ahk 
#Include %A_ScriptDir%\Layer3\TemplateStyle.ahk
#Include %A_ScriptDir%\Layer5\Numlock.ahk ; Numpad hostrings
#Include %A_ScriptDir%\Layer6\VBA_RunMacro.ahk 