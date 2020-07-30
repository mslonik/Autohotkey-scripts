Header() ; show footer
;~ by Jakub Masiak
	{
	oWord := ComObjActive("Word.Application")
	oWord.ActiveWindow.ActivePane.View.SeekView := 9
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
	}