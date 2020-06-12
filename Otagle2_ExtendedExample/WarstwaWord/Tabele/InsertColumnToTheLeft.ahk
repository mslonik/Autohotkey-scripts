InsertColumnToTheLeft() ; wstaw kolumnê tabeli z lewej
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertColumns
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}