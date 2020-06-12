Footer() ; show footer
;~ by Jakub Masiak
	{
	oWord := ComObjActive("Word.Application")
	oWord.ActiveWindow.ActivePane.View.SeekView := 10
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
	}