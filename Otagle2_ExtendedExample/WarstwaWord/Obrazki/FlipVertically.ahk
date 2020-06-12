FlipVertically()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Flip(msoFlipVertical := 1) ; MsoFlipCmd 
	oWord := "" ; Clear global COM objects when done with them\
	WinActivate, ahk_class OpusApp
	return
}