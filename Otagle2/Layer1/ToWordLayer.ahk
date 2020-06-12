ToWordLayer()
{
	global

	CurrentLayer := 2
	F_DisplayLayer(CurrentLayer)
	
	IfWinExist, ahk_class OpusApp
	{
		IfWinNotActive, ahk_class OpusApp
			WinActivate, ahk_class OpusApp
	}
	else
	{
		run, winword.exe
	}
}