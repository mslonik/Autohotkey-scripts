MoveVectorObjectLeft()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.IncrementLeft(-25)
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}