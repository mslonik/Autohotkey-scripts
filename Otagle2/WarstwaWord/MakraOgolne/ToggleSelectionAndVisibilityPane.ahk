ToggleSelectionAndVisibilityPane() ; w³¹cz / wy³¹cz panel edycji obiektów graficznych
{
	oWord := ComObjActive("Word.Application")
	
	StateOfSelectionPane := oWord.CommandBars.ExecuteMso("SelectionPane").Visible
	if (StateOfSelectionPane = -1)
		{
		oWord.CommandBars("SelectionPane").Visible := 0
		}
	else
		{
		oWord.CommandBars.GetPressedMso("SelectionPane")
		}	
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}