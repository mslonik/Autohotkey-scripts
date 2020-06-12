ParagraphPageBreakBefore()
{
	oWord := ComObjActive("Word.Application")
	StateOfParagraph_PageBreakBefore := oWord.Selection.ParagraphFormat.PageBreakBefore
	if (StateOfParagraph_PageBreakBefore = -1)
		{
		oWord.Selection.ParagraphFormat.PageBreakBefore := 0
		}
	else
		{
		oWord.Selection.ParagraphFormat.PageBreakBefore := -1
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}