NextChangeOrComment() ; nastêpna zmiana lub komentarz
{
	oWord := ComObjActive("Word.Application")
	try
		oWord.WordBasic.NextChangeOrComment
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}