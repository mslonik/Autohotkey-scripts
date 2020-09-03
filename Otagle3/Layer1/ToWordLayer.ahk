ToWordLayer()
{



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