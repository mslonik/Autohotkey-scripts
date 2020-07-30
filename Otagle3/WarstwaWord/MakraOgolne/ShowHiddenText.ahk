ShowHiddenText()
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
	HiddenTextState := oWord.ActiveWindow.View.ShowHiddenText
	if (oWord.ActiveWindow.View.ShowAll = -1)
	{
		oWord.ActiveWindow.View.ShowAll := 0
		oWord.ActiveWindow.View.ShowTabs := 0
		oWord.ActiveWindow.View.ShowSpaces := 0
		oWord.ActiveWindow.View.ShowParagraphs := 0
		oWord.ActiveWindow.View.ShowHyphens := 0
		oWord.ActiveWindow.View.ShowObjectAnchors := 0
		oWord.ActiveWindow.View.ShowHiddenText := 0
	}
	else
	{
		oWord.ActiveWindow.View.ShowAll := -1
		oWord.ActiveWindow.View.ShowTabs := -1
		oWord.ActiveWindow.View.ShowSpaces := -1
		oWord.ActiveWindow.View.ShowParagraphs := -1
		oWord.ActiveWindow.View.ShowHyphens := -1
		oWord.ActiveWindow.View.ShowObjectAnchors := -1
		oWord.ActiveWindow.View.ShowHiddenText := -1
	}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}