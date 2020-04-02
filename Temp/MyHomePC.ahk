/*
Author:      Maciej Słojewski, mslonik, http://mslonik.pl
Purpose:       
Description: 
License:     GNU GPL v.3
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 			; only one instance of this script may run at a time!

;~ - - - - - - - - - - Global Variables - - - - - - - - - - -

;~ - - - - - - - - - - End of Global Variables - - - - - - - - - - -

+^t:: ; Trigger the main function
return

 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - - - - 


;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF LABELS - - - - - - - - - - - - - - - - - - - - - - - - - - - 


;~ - - - - - - - - - - - - - - - - - - - - - - - - SPECIAL HOTKEYS - - - - - - - - - - - - - - - - - - - - - - - - - - - -

+^r::

Gui, Add, Button, gA1 xm ym w80 h80 hwndButtonA1hwnd, One
Gui, Add, Button, gA2 x+m yp w80 h80, Two
;~ F1=c:\Users\macie\Documents\GitHub\Autohotkey-scripts\Otagle\Default_80x80.png
;~ Gui, Add, Button, gA1 x0 y0 w80 h80 BackgroundTrans
;~ Gui, Add, Picture, gA1 x0 y0 w80 h-1 +0x4000000 AltSubmit, %f1%
;~ Gui, Show,, My GUI

Gui, Show,, My Gui
return

A1:
;~ Gui,1:submit,nohide
	MsgBox, Clicked button One
; do something
return

A2:
	GuiControl, Hide, % ButtonA1hwnd
	MsgBox, Hidden button One
	Gui, Show,, My Gui
return

guiclose:
exitapp

return

+^e:: ; Edit

Return
