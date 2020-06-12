DisplayGridLines() ; w³¹cz / wy³¹cz linie siatki
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
	oWord.Options.DisplayGridLines := Not oWord.Options.DisplayGridLines
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}