EditComment() ; edytuj komentarz
{	
	oWord := ComObjActive("Word.Application")
	try
	{
		cursorPosition := oWord.Selection.Range
		oWord.WordBasic.AnnotationEdit
	}
	catch e
	{
		MsgBox, 48,, % MsgText("Aby edytować komentarz, musisz umieścić kursor w obrębie tekstu, którego komentarz dotyczy.")
	}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}