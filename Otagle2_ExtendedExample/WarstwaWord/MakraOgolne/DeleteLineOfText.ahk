DeleteLineOfText() ; 2019-10-03
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.HomeKey(Unit := wdLine := 5)
	oWord.Selection.EndKey(Unit := wdLine := 5, Extend := wdExtend := 1)
	oWord.Selection.Delete(Unit := wdCharacter := 1, Count := 1)
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}