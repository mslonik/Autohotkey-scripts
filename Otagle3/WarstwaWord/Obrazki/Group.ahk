Group()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Group
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}