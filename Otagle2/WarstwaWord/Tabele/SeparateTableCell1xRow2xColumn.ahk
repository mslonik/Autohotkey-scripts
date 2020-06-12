SeparateTableCell1xRow2xColumn()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Split(1, 2) 
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}