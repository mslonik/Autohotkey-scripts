MergeTableCells() ; po³¹cz zaznaczone komórki tabeli
{
	oWord := ComObjActive("Word.Application")
	try
		oWord.Selection.Cells.Merge
	catch 
		MsgBox, Zaznacz przynajmniej 2 komórki tabeli!
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}
