RotateRight90()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.IncrementRotation(+90) 
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}