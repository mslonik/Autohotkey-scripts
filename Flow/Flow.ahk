/*
Author:      Maciej SÅ‚ojewski, mslonik, http://mslonik.pl
Purpose:     Mimic Elgato stream deck solution with some cheap hardware from China.
Description: Put a virtual numeric keypad on the screen.
Name:        otagle <- anagram of elgato or just "flow"
License:     GNU GPL v.3

To do - software:
     - CurrentLayer - display value at the bottom of app
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

global BaseLayer := 0
global Word_BaseLayer := 1
global Word_BBLayer := 2
global Word_TemplateStyles1 := 3
global Word_TemplateStyles2 := 4
global NumLock_Layer := 5

global LastLayer := BaseLayer

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

#Include %A_ScriptDir%\Layer0\Layer0.ahk
#Include %A_ScriptDir%\Layer1\Layer1.ahk
#Include %A_ScriptDir%\Layer2\Layer2.ahk
#Include %A_ScriptDir%\Layer3\Layer3.ahk
#Include %A_ScriptDir%\Layer4\Layer4.ahk
#Include %A_ScriptDir%\Layer5\Layer5.ahk

F_Layer0()
F_Layer1()
F_Layer2()
F_Layer3()
F_Layer4()
F_Layer5()

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
     if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          MoveToLayer(Word_TemplateStyles1)
          ActivateWord()
          }
     else if (LastLayer == Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Normalny ms", "Normalny ms")
          ActivateWord()
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          TemplateStyle("Tabela ms", "Tabela ms")
          ActivateWord()
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
          MoveToLayer(Word_BBLayer)
          }
     else if (LastLayer == Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Normalny pomiedzy ms", "Normalny pomiedzy ms")
          ActivateWord()     
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          TemplateStyle("Podpis tabeli ms", "Podpis tabeli ms")
          ActivateWord()
          }    
return

NumpadSub::
NumpadSubP:
NumpadSubB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Nag³ówek 1 ms", "Nag³ówek 1 ms")     
          ActivateWord()
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          TemplateStyle("Tabela bez krawêdzi ms", "Tabela bez krawêdzi ms")
          ActivateWord()
          }    
return

;~ 2nd row
NumpadHome::
NumpadHomeP:
NumpadHomeB:
     if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          SetTemplate("PL", "Do³¹cz domyœlny szablon dokumentu PL")    
          }     
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Nag³ówek 2 ms")     
          ActivateWord()
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          F_SoundPlay()
          TemplateStyle("Tabela tekst ms", "Tabela tekst ms")
          ActivateWord()
          }    
return

NumpadUp::
NumpadUpP:
NumpadUpB:
     if (LastLayer == Word_BaseLayer)
          {
          F_SoundPlay()
          SetTemplate("EN", "Do³¹cz domyœlny szablon dokumentu EN")     
          }
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Nag³ówek 3 ms")     
          ActivateWord()
          }          
return

NumpadPgup::
NumpadPgUpP:
NumpadPgUpB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Nag³ówek 4 ms")     
          ActivateWord()
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
          TemplateStyle("Nag³ówek 5 ms")
          ActivateWord()
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
          TemplateStyle("Nag³ówek 6 ms")
          ActivateWord()
          }          
return

NumpadRight::
NumpadRightP:
NumpadRightB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Nag³ówek 7 ms")     
          ActivateWord()
          }          
return

;~ 4th row
NumpadEnd::
NumpadEndP:
NumpadEndB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Nag³ówek 8 ms")     
          ActivateWord()
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
          TemplateStyle("Linia przerwy ms")     
          ActivateWord()
          }          
return

NumpadDel::
NumpadDelP:
NumpadDelB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          F_SoundPlay()
          TemplateStyle("Ukryty ms")     
          ActivateWord()
          }          
return

AuxiliaryInformation:
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
     Gui, % TempVarLayer ":Show", % "x"DefaultX "y"DefaultY, % ApplicationName 
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
               DefaultX := MonitorBoundingCoordinatesLeft - 4 ; to do: determine why I need -4
               DefaultY := MonitorBoundingCoordinatesTop     
               }     
          }     
}

; - - - - - - - - LABELS - - - - - - - - - - - - - - - 

SwitchOffTooltip:
	ToolTip ,
return

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Include %A_ScriptDir%\Layer0\RunOrActivateWord.ahk
#Include %A_ScriptDir%\Layer1\SetTemplate.ahk
#Include %A_ScriptDir%\Layer1\StrikeThroughText.ahk
#Include %A_ScriptDir%\Layer1\HideSelectedText.ahk
#Include %A_ScriptDir%\Layer3\TemplateStyle.ahk
#Include %A_ScriptDir%\Layer5\Numlock.ahk ; Numpad hostrings