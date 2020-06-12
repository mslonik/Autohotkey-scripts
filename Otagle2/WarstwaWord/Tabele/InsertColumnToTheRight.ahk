InsertColumnToTheRight() ; wstaw kolumnê tabeli z prawej
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertColumnsRight 
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}