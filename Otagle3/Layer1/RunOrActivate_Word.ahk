RunOrActivate_Word()
{
	global
	DetectHiddenWindows, 	On
	SetTitleMatchMode, 		RegEx
	 
	 WordOutputVarPID:= 0

	
	SysGet,	HowManyMonitors, MonitorCount
	Loop, % HowManyMonitors
		{
		if (A_Index <> A_Args[1])
			{
			SysGet, 	MonitorBoundingCoordinates_, Monitor, % A_Index
			break
			}
		}

	Process, Exist, WINWORD.EXE
	if (ErrorLevel = 0)
		{
		Run, WINWORD.EXE, ; , Hide 
		
		WinWait, ahk_class OpusApp, , 3 
		if (ErrorLevel)
			{
			MsgBox, WinWait timed out, WINWORD.EXE wasn't found
			ExitApp, 1
			}
		WinShow, ahk_class OpusApp
		WinActivate, ahk_class OpusApp 
		
		WinMaximize ; nie działa
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
