RunOrActivateKeePass()
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
			WinActivate ahk_exe KeePass.exe
			}
		}
}