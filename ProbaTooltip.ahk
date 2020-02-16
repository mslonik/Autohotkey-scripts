#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#Persistent

;~ tooltip, Jakis napis, 150, 150
;~ return

tooltip, Jakis napis
	SetTimer, SwitchOffTooltip, -5000
return

SwitchOffTooltip:
	ToolTip ,
return

;~ #Persistent
;~ ToolTip, Timed ToolTip`nThis will be displayed for 5 seconds.
;~ SetTimer, RemoveToolTip, -5000
;~ return

;~ RemoveToolTip:
;~ ToolTip
;~ return