ToggleStylePane()
{
	oWord := ComObjActive("Word.Application")
	StateOfStylesPane := oWord.CommandBars.ExecuteMso("Format Object").Visible
	if (StateOfStylesPane = WordTrue)
		{
		oWord.CommandBars("Format Object").Visible := 0
		}
	else
		{
		oWord.CommandBars("Format Object").Visible := -1
		}	
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}