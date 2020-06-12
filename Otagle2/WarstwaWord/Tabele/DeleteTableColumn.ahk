DeleteTableColumn()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Columns.Delete 
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}