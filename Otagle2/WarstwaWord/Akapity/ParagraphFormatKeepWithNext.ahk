ParagraphFormatKeepWithNext()
{
	oWord := ComObjActive("Word.Application")
	StateOfParagraph_KeepWithNext := oWord.Selection.ParagraphFormat.KeepWithNext
	if (StateOfParagraph_KeepWithNext = -1)
		{
		oWord.Selection.ParagraphFormat.KeepWithNext := 0
		}
	else
		{
		oWord.Selection.ParagraphFormat.KeepWithNext := 0
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}