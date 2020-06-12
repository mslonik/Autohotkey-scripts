RepeatTableHeader() ; powtórz wiersz nag³ówka tabeli
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
	if (oWord.Selection.Information(12) = -1)
		oWord.Selection.Rows.HeadingFormat := 9999998
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}