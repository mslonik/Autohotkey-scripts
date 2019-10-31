RunOrActivateTotalCommander()
{ 
	Process, Exist, totalcmd64.exe
	if (ErrorLevel = 0)
		{
		Run, "c:\totalcmd\TOTALCMD64.EXE"
		}
		else
		{
		GroupAdd, ms_totalcommander, ahk_exe TOTALCMD64.EXE
		if (WinActive("ahk_exe TOTALCMD64.EXE"))
			{
			GroupActivate, ms_totalcommander, r
			} 
		else
			{
			WinActivate ahk_exe TOTALCMD64.EXE
			}
		}
}