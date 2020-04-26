RunOrActivate_KeePass()
{
	global
	
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

	
	Process, Exist, KeePass.Exe
	if (ErrorLevel = 0)
		{
		Run, "c:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe"
		}
		else
		{
		GroupAdd, ms_keepass, ahk_exe KeePass.exe
		if (WinActive("ahk_exe KeePass.exe"))
			{
			GroupActivate, ms_keepass, r
			} 
		else
			{
			
			;~ #WinActivateForce ; nie działa
			;~ WinShow, ahk_exe KeePass.exe
			;WinMaximize, ahk_exe KeePass.exe
			;WinActivate, ahk_exe KeePass.exe
			WinActivate ahk_exe KeePass.exe
			WinMove, ahk_class OpusApp, , % MonitorBoundingCoordinates_Left, % MonitorBoundingCoordinates_Top
			;WinWaitActive, ahk_exe KeePass.exe
			;MsgBox, Tu jestem!
			}
		}
}

;RunOrActivate_KeePass()