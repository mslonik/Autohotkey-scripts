ToggleRuler()
{
	oWord := ComObjActive("Word.Application")
	StateOfRuler := oWord.ActiveWindow.ActivePane.DisplayRulers
	if (StateOfRuler == -1)
		{
		oWord.ActiveWindow.ActivePane.DisplayRulers := 0
		}
	else
		{
		oWord.ActiveWindow.ActivePane.DisplayRulers := -1
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}