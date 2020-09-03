ToTCLayer()
{



	
	IfWinExist, ahk_class TTOTAL_CMD
	{
		IfWinNotActive, ahk_class TTOTAL_CMD
			WinActivate, ahk_class TTOTAL_CMD
	}
	else
	{
		run, C:\totalcmd\TOTALCMD64.EXE
	}
}