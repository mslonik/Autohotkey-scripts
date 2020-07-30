TableBorderOff()
{
	oWord := ComObjActive("Word.Application")

	oWord.Selection.Borders(wdBorderLeft := -2).LineStyle := wdLineStyleNone := 0
    oWord.Selection.Borders(wdBorderRight := -4).LineStyle := wdLineStyleNone := 0
    oWord.Selection.Borders(wdBorderVertical := -6).LineStyle := wdLineStyleNone := 0

	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}