#Requires AutoHotkey v1.1.33+ 	; Displays an error and quits if a version requirement is not met.    
#SingleInstance force 			; Only one instance of this script may run at a time!
#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  						; Enable warnings to assist with detecting common errors.
#LTrim						; Omits spaces and tabs at the beginning of each line. This is primarily used to allow the continuation section to be indented. Also, this option may be turned on for multiple continuation sections by specifying #LTrim on a line by itself. #LTrim is positional: it affects all continuation sections physically beneath it.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
FileEncoding, UTF-16			; Sets the default encoding for FileRead, FileReadLine, Loop Read, FileAppend, and FileOpen(). Unicode UTF-16, little endian byte order (BMP of ISO 10646). Useful for .ini files which by default are coded as UTF-16. https://docs.microsoft.com/pl-pl/windows/win32/intl/code-page-identifiers?redirectedfrom=MSDN

ih := InputHook("L0 V", "{Esc}")
; ih := InputHook("L1", "{Esc}")
; ih := InputHook(, "{Esc}")
; do rozważenia I2

; ErrorLevel := ih.Wait()
ih.OnChar 	:= Func("OneCharPressed")
ih.OnEnd		:= Func("EndCharPressed")
ih.Start()

; end of initialization block
^F2:: ih.VisibleText := false
^F3:: ih.VisibleText := true

; beginning of function block
OneCharPressed(InputHook, Char)
{
	OutputDebug, % Char . "`n"
	InputHook.Start()
}

EndCharPressed(InputHook)
{
	OutputDebug, % "EndKey:" . A_Space . InputHook.EndKey
	ExitApp, 0	;normal exit
}