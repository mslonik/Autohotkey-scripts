FlipHorizontally()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Flip(msoFlipHorizontal := 0) ; MsoFlipCmd 
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}