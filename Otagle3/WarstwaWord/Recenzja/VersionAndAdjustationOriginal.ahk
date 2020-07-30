VersionAndAdjustationOriginal() 
{
	oWord := ComObjActive("Word.Application")
	StateOfOriginalAdjustation := oWord.ActiveWindow.View.ShowRevisionsAndComments
	if (StateOfOriginalAdjustation = -1)
		{
		oWord.ActiveWindow.View.ShowRevisionsAndComments := 0
		}
	else
		{
		oWord.ActiveWindow.View.ShowRevisionsAndComments := -1
		}
		oWord.ActiveWindow.View.RevisionsView := wdRevisionsViewFinal := 1
	oWord := "" 
	WinActivate, ahk_class OpusApp
	return
}