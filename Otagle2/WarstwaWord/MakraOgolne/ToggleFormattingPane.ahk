ToggleFormattingPane()
{
	oWord := ComObjActive("Word.Application")
	StateOfFormattingPane := oWord.Application.TaskPanes(1).Visible
	if (StateOfFormattingPane == -1)
		{
		oWord.Application.TaskPanes(1).Visible := 0 
		}
	else
		{
		oWord.Application.TaskPanes(1).Visible := -1
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}