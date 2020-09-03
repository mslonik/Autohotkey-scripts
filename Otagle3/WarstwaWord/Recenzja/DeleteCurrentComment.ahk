DeleteCurrentComment() ; usu� aktualnie wybrany komentarz
	{
	try
		{
		oWord := ComObjActive("Word.Application")
		oWord.Selection.Comments(1).Delete
		cursorPosition.Select
		oWord := "" ; Clear global COM objects when done with them
		}
		catch e
		{
		MsgBox, 48, Usuwanie komentarza, % MsgText("By usunąć komentarz musisz go najpierw wyedytować (Edytuj komentarz).")
		}
	WinActivate, ahk_class OpusApp
	return
	}