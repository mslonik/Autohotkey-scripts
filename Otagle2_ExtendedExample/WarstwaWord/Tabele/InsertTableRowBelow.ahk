InsertTableRowBelow() ; tabela: Wstaw wiersz powy¿ej
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertRowsBelow(1)
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}