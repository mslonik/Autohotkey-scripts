; Script Function:
;	Put a virtual numeric keypad on the screen

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.

global ApplicationName := "Flow"

global LastLayer
global TempVarLayerLayer
global BaseLayer := 0
global Word_BaseLayer := 1
global Word_BBLayer := 2
global Word_TemplateStyles1 := 3
global Word_TemplateStyles2 := 4

global X
global Y
;~ global Width
;~ global Height

;~ global SM_CXSIZEFRAME := 32 ; Thickness of the sizing border around the perimeter of a window that can be resized, in pixels. The width of the horizontal border
;~ global SM_CYSIZEFRAME := 33 ; Thickness of the sizing border around the perimeter of a window that can be resized, in pixels. the height of the vertical border.
;~ global SM_CYCAPTION := 4    ;  Height of a caption area, in pixels.
;~ global xborder
;~ global yborder
;~ global titlebar

#Include %A_ScriptDir%\Layer0\Layer0.ahk
#Include %A_ScriptDir%\Layer1\Layer1.ahk
#Include %A_ScriptDir%\Layer2\Layer2.ahk
#Include %A_ScriptDir%\Layer3\Layer3.ahk
#Include %A_ScriptDir%\Layer4\Layer4.ahk

LastLayer := 0
Gui, Layer0:Show, , %ApplicationName%

;~ SysGet, xborder, %SM_CXSIZEFRAME%
;~ SysGet, yborder, %SM_CYSIZEFRAME%
;~ SysGet, titlebar, %SM_CYCAPTION%

; - - - - - - - - - - END OF INITIALIZATION - - - - - - - - - - - - - - -

~NumLock:: ; NumLock key support
     KeyWait, NumLock
     F_NumLockLayer(GetKeyState("NumLock", "T"))
return

NumLockP:
NumLockB:
     SetNumLockState % !GetKeyState("CapsLock", "T") ; Toggles NumLock state to its opposite state
     F_NumLockLayer(GetKeyState("NumLock", "T"))
return


;~ 1st row
NumpadDiv::
NumpadDivP:
NumpadDivB:
     if (LastLayer == Word_BaseLayer)
          {
          MoveToLayer(Word_TemplateStyles1)
          }
     else if (LastLayer == Word_TemplateStyles1)
          {
          TemplateStyle("Normalny ms", "Normalny ms")
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          TemplateStyle("Tabela ms", "Tabela ms")
          }    
return

NumpadMult::
NumpadMultP:
NumpadMultB:
     if (LastLayer == BaseLayer)
          {
          MoveToLayer(Word_BaseLayer)
          }
     else if (LastLayer == Word_BaseLayer)
          {
          MoveToLayer(Word_BBLayer)
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          TemplateStyle("Podpis tabeli ms", "Podpis tabeli ms")
          }    
return

NumpadSub::
NumpadSubP:
NumpadSubB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 1 ms", "Nag³ówek 1 ms")     
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          TemplateStyle("Tabela bez krawêdzi ms", "Tabela bez krawêdzi ms")
          }    
return

;~ 2nd row
NumpadHome::
NumpadHomeP:
NumpadHomeB:
     if (LastLayer == Word_BaseLayer)
          {
          SetTemplate("PL", "Do³¹cz domyœlny szablon dokumentu PL")     
          }     
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 2 ms")     
          }
     else if (LastLayer == Word_TemplateStyles2)
          {
          TemplateStyle("Tabela tekst ms", "Tabela tekst ms")
          }    
return

NumpadUp::
NumpadUpP:
NumpadUpB:
     if (LastLayer == Word_BaseLayer)
          {
          SetTemplate("EN", "Do³¹cz domyœlny szablon dokumentu EN")     
          }
     else if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 3 ms")     
          }          
return

NumpadPgup::
NumpadPgUpP:
NumpadPgUpB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 4 ms")     
          }          
return          

NumpadAdd::
NumPadAddP:
NumPadAddB:
     if (LastLayer == Word_BaseLayer)
          {
          MoveToLayer(BaseLayer)
          ;~ MsgBox, % LastLayer
          }
     else if (LastLayer == Word_BBLayer)
          {
          MoveToLayer(Word_BaseLayer)
          ;~ MsgBox, % LastLayer     
          }
     else if (LastLayer == Word_TemplateStyles1)
          {
          MoveToLayer(Word_BaseLayer)
          ;~ MsgBox, % LastLayer
          }     
     else if (LastLayer == Word_TemplateStyles2)
          {
          MoveToLayer(Word_TemplateStyles1)
          ;~ MsgBox, % LastLayer
          }     
return

;~ 3rd row
NumpadLeft::
NumpadLeftP:
NumpadLeftB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 5 ms")     
          }          
return

NumpadClear::
NumpadBlankP:
NumpadBlankB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 6 ms")     
          }          
return

NumpadRight::
NumpadRightP:
NumpadRightB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 7 ms")     
          }          
return

;~ 4th row
NumpadEnd::
NumpadEndP:
NumpadEndB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Nag³ówek 8 ms")     
          }          
return

NumpadDown::
NumpadDownP:
NumpadDownB:

NumpadPgdn::
NumpadPgDnP:
NumpadPgDnB:

NumpadEnter::
NumpadEnterP:
NumpadEnterB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          MoveToLayer(Word_TemplateStyles2)     
          }          
return

;~ 5th row
NumpadIns::
NumpadInsP:
NumpadInsB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Linia przerwy ms")     
          }          
return

NumpadDel::
NumpadDelP:
NumpadDelB:
     if (LastLayer ==  Word_TemplateStyles1)
          {
          TemplateStyle("Ukryty ms")     
          }          
return

AuxiliaryInformation:
return

Layer0GuiClose:
Layer1GuiClose:
     ExitApp


; - - - - - - - - - - - FUNCTIONS - - - - - - - - - - -


F_NumLockLayer(V_NumLockState)
{
global     
     
if (V_NumLockState == 0) ; Show
     {
     TempVarLayer := "Layer" . LastLayer
     Gui, %TempVarLayer%:Show     
     }
else ; Hide
     {
     TempVarLayer := "Layer" . LastLayer
     Gui, %TempVarLayer%:Hide
     }
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

MoveToLayer(WhichLayer)
{
     global
     
     TempVarLayer := "Layer" . LastLayer
     WinGetPos, X, Y, , , %ApplicationName% ; amount of parameters matters...
     Gui, %TempVarLayer%:Hide
     LastLayer := WhichLayer
     TempVarLayer := "Layer" . LastLayer
     ;~ Gui, %TempVarLayer%:Show, x%X% y%Y%, %ApplicationName% ; it works
     Gui, % TempVarLayer ":Show", % "x"X "y"Y, % ApplicationName ; it works as well, alternative solution to above line
}

; - - - - - - - - LABELS - - - - - - - - - - - - - - - 

SwitchOffTooltip:
	ToolTip ,
return

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Include %A_ScriptDir%\Layer1\SetTemplate.ahk
#Include %A_ScriptDir%\Layer3\TemplateStyle.ahk