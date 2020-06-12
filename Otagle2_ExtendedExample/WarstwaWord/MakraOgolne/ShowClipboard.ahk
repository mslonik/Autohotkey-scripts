ShowClipboard()
{
	oWord := ComObjActive("Word.Application")
	oWord.Application.ShowClipboard
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}