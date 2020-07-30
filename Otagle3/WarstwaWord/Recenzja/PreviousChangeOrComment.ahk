PreviousChangeOrComment() ; poprzednia zmiana lub komentarz
;~ by Jakub Masiak
{	
	oWord := ComObjActive("Word.Application")
	try
		oWord.WordBasic.PreviousChangeOrComment
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}