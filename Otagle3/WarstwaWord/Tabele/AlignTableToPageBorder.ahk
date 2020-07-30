AlignTableToPageBorder()
;~ by Jakub Masiak
{
	wdWithInTable := 12 ; WdInformation enumeration: wdWithInTable = 12 Returns True if the selection is in a table.
	oWord := ComObjActive("Word.Application")

	if (oWord.Selection.Information(wdWithInTable) = -1) 
		{
		oWord.Selection.Tables(1).PreferredWidthType := wdPreferredWidthPoints := 3 
		oWord.Selection.Tables(1).PreferredWidth := oWord.Selection.PageSetup.PageWidth - (oWord.Selection.PageSetup.LeftMargin + oWord.Selection.PageSetup.RightMargin + oWord.Selection.PageSetup.Gutter)
		oWord.Selection.Tables(1).Rows.Alignment := wdAlignRowCenter := 1 
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}