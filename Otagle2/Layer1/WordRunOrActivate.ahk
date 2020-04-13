RunOrActivateWord()
{
     MonitorBoundingCoordinates_Left        := 0
     MonitorBoundingCoordinates_Right       := 0
     MonitorBoundingCoordinates_Top         := 0
     MonitorBoundingCoordinates_Bottom      := 0
	 HowManyMonitors						:= 0
	 WordOutputVarPID						:= 0

A_Args[1] := 1

	
	SysGet,	HowManyMonitors, MonitorCount
	Loop, % HowManyMonitors
		{
		if (A_Index <> A_Args[1])
			{
			SysGet, 	MonitorBoundingCoordinates_, % A_Index
			break
			}
		}
	;~ MsgBox, 	% "WordOutputVarPID: " . WordOutputVarPID . "`n`rWhichMonitor: " . A_Args[1]

	
	Process, Exist, WINWORD.EXE
	if (ErrorLevel = 0)
		{
		;~ Run, WINWORD.EXE, , Min, WordOutputVarPID
		;~ MsgBox, % "A_TitleMatchMode: " . A_TitleMatchMode . " A_TitleMatchModeSpeed: " . A_TitleMatchModeSpeed 
		Run, WINWORD.EXE, , Min, WordOutputVarPID
		;~ Run, WINWORD.EXE
		;~ MsgBox, % "WordOutputVarPID: " . WordOutputVarPID
		;~ WinWait, ahk_pid %WordOutputVarPID% ; to działa
		WinWait, ahk_exe WINWORD.EXE
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
			WinActivate ahk_class OpusApp
			;~ }
		;~ WinMove, ahk_pid %WordOutputVarPID%, , MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Top
		;~ WinMove, A, , MonitorBoundingCoordinates_Left, MonitorBoundingCoordinates_Top
		;~ WinMove, % WinClass, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
		;~ WinMove, % WinClass, , 0, 0
		;~ WinMove, ahk_class OpusApp, , 0, 0
		;~ WinMove, ahk_class OpusApp, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
		;~ WinMove, % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
		WinMove, % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
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
DetectHiddenWindows, 	On
SetTitleMatchMode, 		2

RunOrActivateWord()