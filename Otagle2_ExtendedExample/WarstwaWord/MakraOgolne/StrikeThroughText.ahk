StrikeThroughText() ; 2019-10-03 2019-11-08
{
	oWord := ComObjActive("Word.Application")
	StateOfStrikeThrough := oWord.Selection.Font.StrikeThrough ; := wdToggle := 9999998 
	if (StateOfStrikeThrough == 0)
		{
		oWord.Selection.Font.StrikeThrough := wdToggle := 9999998
		}
	else
		{
		oWord.Selection.Font.StrikeThrough := 0
		}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}