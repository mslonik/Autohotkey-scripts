MergeTableCells() ; po��cz zaznaczone kom�rki tabeli
{
	oWord := ComObjActive("Word.Application")
	try
		oWord.Selection.Cells.Merge
	catch 
		MsgBox, % MsgText("Zaznacz przynajmniej 2 komórki tabeli!")
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}
