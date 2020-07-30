NavigationPaneVisibility()
{
	oWord := ComObjActive("Word.Application")
	StateOfNavigationPane := oWord.ActiveWindow.DocumentMap
	if (StateOfNavigationPane = -1)
		{
		oWord.ActiveWindow.DocumentMap := 0
		}
	else
		{
		oWord.ActiveWindow.DocumentMap := -1
		}
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}