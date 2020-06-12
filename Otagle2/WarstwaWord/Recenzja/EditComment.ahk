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
		MsgBox, 48,, Aby edytowaæ komentarz, musisz umieœciæ kursor w obrêbie tekstu, którego komentarz dotyczy.
	}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}