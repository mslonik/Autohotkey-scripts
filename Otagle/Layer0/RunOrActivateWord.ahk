RunOrActivateWord()
{
	Process, Exist, WINWORD.EXE
	if (ErrorLevel = 0)
		{
		Run, WINWORD.EXE
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
			}
		}
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - 

ActivateWord()
{
	if (WinActive("ahk_class OpusApp"))
		{
		GroupActivate, taranwords, r
		} 
	else
		{
		WinActivate ahk_class OpusApp
		}
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - 