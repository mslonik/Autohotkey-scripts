FullPath() ; display full path to a file in window title bar 
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
    oWord.ActiveWindow.Caption := oWord.ActiveDocument.FullName
    oWord := ""
	WinActivate, ahk_class OpusApp
	return
}