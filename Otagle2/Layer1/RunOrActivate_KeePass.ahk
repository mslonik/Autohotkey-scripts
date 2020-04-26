RunOrActivate_KeePass()
{
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
			WinMaximize, ahk_exe KeePass.exe
			WinActivate, ahk_exe KeePass.exe
			MsgBox, Tu jestem!
			}
		}
}

;RunOrActivate_KeePass()