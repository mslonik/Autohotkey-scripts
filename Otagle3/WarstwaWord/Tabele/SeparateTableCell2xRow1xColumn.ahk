SeparateTableCell2xRow1xColumn()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Split(2, 1) 
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}