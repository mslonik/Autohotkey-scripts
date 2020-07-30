DeleteCurrentComment() ; usuñ aktualnie wybrany komentarz
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
		MsgBox, 48, Usuwanie komentarza, By usunaæ komentarz musisz go najpierw wyedytowaæ (Edytuj komentarz).
		}
	WinActivate, ahk_class OpusApp
	return
	}