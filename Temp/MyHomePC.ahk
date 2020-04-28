/*
Author:      Maciej Słojewski, mslonik, http://mslonik.pl
Purpose:       
Description: 
License:     GNU GPL v.3
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance, force 			; only one instance of this script may run at a time!
#Persistent

#Include C:\Users\macie\Documents\GitHub\Autohotkey-scripts\Otagle2\Class_ImageButton.ahk                   ; Buttons with pictures
;~ #Include C:\Users\macie\Documents\GitHub\Autohotkey-scripts\Otagle2\Layer1\RunOrActivate_KeePass.ahk
#include C:\Users\macie\Documents\GitHub\Autohotkey-scripts\Otagle2\ButtonFunctions.ahk 

;~ DetectHiddenWindows, On ; Caution!

;~ - - - - - - - - - - Global Variables - - - - - - - - - - -

;~ - - - - - - - - - - End of Global Variables - - - - - - - - - - -

;~ +^t:: ; Trigger the main function
;~ return

 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - - - - 


;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF LABELS - - - - - - - - - - - - - - - - - - - - - - - - - - - 


;~ - - - - - - - - - - - - - - - - - - - - - - - - SPECIAL HOTKEYS - - - - - - - - - - - - - - - - - - - - - - - - - - - -
FunctionName := "RunOrActivate_KeePass"
;~ MsgBox, % FunctionName
%FunctionName%()

;~ +^r::

return


GuiClose:
ExitApp



+^e:: ; Edit

return
