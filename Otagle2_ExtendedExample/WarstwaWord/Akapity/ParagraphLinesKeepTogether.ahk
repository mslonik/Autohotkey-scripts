ParagraphLinesKeepTogether()
{
	oWord := ComObjActive("Word.Application")
	StateOfParagraph_KeepTogether := oWord.Selection.ParagraphFormat.KeepTogether
	if (StateOfParagraph_KeepTogether = -1)
		{
		oWord.Selection.ParagraphFormat.KeepTogether := 0
		}
	else
		{
		oWord.Selection.ParagraphFormat.KeepTogether := -1
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}