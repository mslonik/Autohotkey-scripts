ToggleStylePane()
{
	oWord := ComObjActive("Word.Application")
	StateOfStylesPane := oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible
	if (StateOfStylesPane = -1)
		{
		oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible := 0
		}
	else
		{
		oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible := -1
		}	
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}