MarkAllTableCells()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Tables(1).Select
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}