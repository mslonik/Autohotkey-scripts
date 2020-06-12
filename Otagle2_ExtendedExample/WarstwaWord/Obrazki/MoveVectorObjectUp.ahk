MoveVectorObjectUp()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.IncrementTop(-25)
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}