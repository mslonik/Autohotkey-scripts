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
global Word_TemplateStyles := 3

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
          MoveToLayer(Word_TemplateStyles)
          }
     else if (LastLayer == Word_TemplateStyles)
          {
          TemplateStyle("Normalny ms", "Normalny ms")
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
return

NumpadSub::
NumpadSubP:
NumpadSubB:
     if (LastLayer ==  Word_TemplateStyles)
          {
          TemplateStyle("Nag³ówek 1 ms", "Nag³ówek 1 ms")     
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
     else if (LastLayer ==  Word_TemplateStyles)
          {
          TemplateStyle("Nag³ówek 2 ms")     
          }
return

NumpadUp::
NumpadUpP:
NumpadUpB:
     if (LastLayer == Word_BaseLayer)
          {
          SetTemplate("EN", "Do³¹cz domyœlny szablon dokumentu EN")     
          }
     else if (LastLayer ==  Word_TemplateStyles)
          {
          TemplateStyle("Nag³ówek 3 ms")     
          }          
return



NumpadPgup::
NumpadPgUpP:
NumpadPgUpB:
MsgBox, 2th row

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
     else if (LastLayer == Word_TemplateStyles)
          {
          MoveToLayer(Word_BaseLayer)
          ;~ MsgBox, % LastLayer
          }     
return

;~ 3rd row
NumpadLeft::
NumpadLeftP:
NumpadLeftB:

NumpadClear::
NumpadBlankP:
NumpadBlankB:

NumpadRight::
NumpadRightP:
NumpadRightB:

     MsgBox, 3th row
return

;~ 4th row
NumpadEnd::
NumpadEndP:
NumpadEndB:

NumpadDown::
NumpadDownP:
NumpadDownB:

NumpadPgdn::
NumpadPgDnP:
NumpadPgDnB:

NumpadEnter::
NumpadEnterP:
NumpadEnterB:
     MsgBox, 4th row
return

;~ 5th row
NumpadIns::
NumpadInsP:
NumpadInsB:

NumpadDel::
NumpadDelP:
NumpadDelB:
     MsgBox, 5th row
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
     WinGetPos, X, Y, %ApplicationName%
     Gui, %TempVarLayer%:Hide
     LastLayer := WhichLayer
     TempVarLayer := "Layer" . LastLayer
     Gui, %TempVarLayer%:Show, X%X% Y%Y%, %ApplicationName%
}

; - - - - - - - - LABELS - - - - - - - - - - - - - - - 

SwitchOffTooltip:
	ToolTip ,
return

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#Include %A_ScriptDir%\Layer1\SetTemplate.ahk
#Include %A_ScriptDir%\Layer3\TemplateStyle.ahk