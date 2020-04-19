RunOrActivate_Word()
{
	global
	DetectHiddenWindows, 	On
	SetTitleMatchMode, 		RegEx
	
     ;~ MonitorBoundingCoordinates_Left        := 0
     ;~ MonitorBoundingCoordinates_Right       := 0
     ;~ MonitorBoundingCoordinates_Top         := 0
     ;~ MonitorBoundingCoordinates_Bottom      := 0
	 ;~ HowManyMonitors						:= 0
	 
	 WordOutputVarPID						:= 0

;~ A_Args[1] := 2
;~ MsgBox, % "A_Args[1]: " . A_Args[1]
;~ TempValue := A_Args[1]

	
	SysGet,	HowManyMonitors, MonitorCount
	Loop, % HowManyMonitors
		{
		if (A_Index <> A_Args[1])
		;~ if (A_Index <> TempValue)
			{
			SysGet, 	MonitorBoundingCoordinates_, Monitor, % A_Index
			break
			}
		}
	;~ MsgBox, 	% "WordOutputVarPID: " . WordOutputVarPID . "`n`rWhichMonitor: " . A_Args[1]

	
	Process, Exist, WINWORD.EXE
	if (ErrorLevel = 0)
		{
		;~ Run, WINWORD.EXE, , Min, WordOutputVarPID
		;~ MsgBox, % "A_TitleMatchMode: " . A_TitleMatchMode . " A_TitleMatchModeSpeed: " . A_TitleMatchModeSpeed 
		;~ Run, WINWORD.EXE, , Min, WordOutputVarPID ; to działa
		;~ Run, WINWORD.EXE ; to działa
		Run, WINWORD.EXE, , Hide 
		
		;~ MsgBox, % "WordOutputVarPID: " . WordOutputVarPID
		;~ WinWait, ahk_pid %WordOutputVarPID% ; to działa
		WinWait, ahk_class OpusApp, , 3 ; to działa
		;~ WinWait, Word* ; to działa
		if (ErrorLevel)
			{
			MsgBox, WinWait timed out, WINWORD.EXE wasn't found
			ExitApp, 1
			}
		
		;~ WinGet, WhatWeKnowAboutWindows, List, ahk_class OpusApp ; to działa
		
;~ Winget, WordWindows, List, ahk_class OpusApp ahk_exe WINWORD.EXE
;~ Loop, % WordWindows  ; Loop once for each window.
;~ {
    ;~ ;WinGetPos, X, Y,,, % "ahk_id " WordWindows%A_Index%  ; Get existing window position.
    ;~ WinMove, % "ahk_id " WordWindows%A_Index%,,,, 800, 800  ; Move the window. Use the existing X and Y.
	;~ WinMaximize, % "ahk_id " WordWindows%A_Index%
;~ }
		
		
		;~ WinGet, WhatWeKnowAboutWindows, List, Word* ; to działa
		
		;~ WinGetTitle, WordWindowTitle, ahk_class OpusApp
		;~ MsgBox, % "WordWindowTitle: " . WordWindowTitle
		
		/*
		Loop, % WhatWeKnowAboutWindows
			{
			ThisId := WhatWeKnowAboutWindows%A_Index%
			WinActivate, ahk_id %ThisId%
			WinGetClass, this_class, ahk_id %ThisId%
			WinGetTitle, this_title, ahk_id %ThisId%
			OutputVar .= "`r`n" . A_Index . ". ahk_id: " . ThisId . ", this_class: " . this_class . ", this_title: " . this_title
			}
		MsgBox, % "OutputVar: " . WhatWeKnowAboutWindows . OutputVar
		*/
		;~ SetFormat, IntegerFast, hex
		;~ LastId := WhatWeKnowAboutWindows1
		;~ SetFormat, IntegerFast, d
		
		;~ WinWait, ahk_exe WINWORD.EXE
		;~ WinWait, A
		
		;~ WinGetClass, WinClass, ahk_exe WINWORD.EXE
		;~ WinGetClass, WinClass, ahk_class OpusApp ; to działa
		;~ MsgBox, % "WinClass: " . WinClass ; to działa 
		
		;~ WinGetTitle, WinTitle, ahk_class %WinClass%
		;~ WinGetTitle, WinTitle, ahk_exe WINWORD.EXE
		;~ MsgBox, % "WinTitle: " . WinTitle
		
		;~ WinGetTitle, WinTitle, ahk_pid %WordOutputVarPID%
		;~ MsgBox, % "WinTitle: " . WinTitle
		;~ if (WinExist(ahk_pid %WordOutputVarPID%))
			;~ {
			;~ MsgBox, Tu jestem
			;~ WinShow, ahk_pid %WordOutputVarPID%
			;~ WinWait, ahk_pid %WordOutputVarPID%
			;~ WinActivate, ahk_pid %WordOutputVarPID%
			;~ WinActivate ahk_class OpusApp
			;~ }
		;~ WinMove, ahk_pid %WordOutputVarPID%, , MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Top
		;~ WinMove, A, , MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Top
		;~ WinMove, % WinClass, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
		;~ WinMove, % WinClass, , 0, 0
		;~ WinMove, ahk_class OpusApp, , 0, 0
		;~ WinMove, ahk_class OpusApp, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top

		;~ WinMove, ahk_id %LastId%, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top ; to działa
		;~ WinActivate, ahk_id %LastId% ; to działa
		
		;~ WinShow, % WordWindowTitle
		;~ WinMove, % WordWindowTitle, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top ; to działa
		;~ WinActivate, % WordWindowTitle ; to działa
		
		WinShow, ahk_class OpusApp
		WinMove, ahk_class OpusApp, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top ; to działa
		WinActivate, ahk_class OpusApp ; to działa
		;~ WinMaximize, ahk_class OpusApp ; to nie działa
		;~ PostMessage, 0x112, 0xF030,,, ahk_class OpusApp Word ; 0x112 = WM_SYSCOMMAND, 0xF030 = SC_MAXIMIZE
		;~ WinRestore, ahk_class OpusApp
		
		WinMaximize ; nie działa
		
		
		;~ WinMove, % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
		;~ WinMove, % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
		}
	else
		{
		GroupAdd, taranwords, ahk_class OpusApp
		if (WinActive("ahk_class OpusApp"))
			{
			GroupActivate, taranwords, r
			} 
		else
			{
			WinActivate ahk_class OpusApp
			WinMove, ahk_class OpusApp, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
			}
		}
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - 

;~ ActivateWord()
;~ {
	;~ if (WinActive("ahk_class OpusApp"))
		;~ {
		;~ GroupActivate, taranwords, r
		;~ } 
	;~ else
		;~ {
		;~ WinActivate ahk_class OpusApp
		;~ }
;~ }

; - - - - - - - - - - - - - - - - - - - - - - - - - - - 

