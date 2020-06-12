StartWithOddOrEvenPage()
{
	oWord := ComObjActive("Word.Application")
	state := oWord.ActiveDocument.PageSetup.SectionStart
	if (state != 3)
		oWord.ActiveDocument.PageSetup.SectionStart := 3
	else
		oWord.ActiveDocument.PageSetup.SectionStart := 4
	oWord :=  ""
	WinActivate, ahk_class OpusApp
	return
}