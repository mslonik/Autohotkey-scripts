ToggleApplyStylesPane() ; 2019-10-03
{
	oWord := ComObjActive("Word.Application")
	ApplyStylesTaskPane := oWord.CommandBars("Apply styles").Visible
	try
	{	
	If (ApplyStylesTaskPane = 0)
		oWord.Application.TaskPanes(17).Visible := -1
	Else If (ApplyStylesTaskPane = -1)
		oWord.CommandBars("Apply styles").Visible := 0
	}
		catch
	{
		MsgBox,48,, Aby wywo³aæ panel "Stosowanie stylów", zaznaczenie nie powinno zawieraæ kanwy rysunku.
		return
	}
	
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}