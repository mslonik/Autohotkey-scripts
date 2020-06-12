DeleteTableRow()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Rows.Delete 
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}