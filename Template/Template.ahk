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
    Reload
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Edit
return

+^e::Edit