ToTCLayer()
{
	global

	CurrentLayer := 12
	F_DisplayLayer(CurrentLayer)
	
	IfWinExist, ahk_class TTOTAL_CMD
	{
		IfWinNotActive, ahk_class TTOTAL_CMD
			WinActivate, ahk_class TTOTAL_CMD
	}
	else
	{
		run, TOTALCMD64.EXE
	}
}