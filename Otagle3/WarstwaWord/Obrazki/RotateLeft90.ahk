RotateLeft90()
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.IncrementRotation(-90) 
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	WinGetPos, WinX, WinY,WinW,WinH,A
    mouseX := Round(WinX+WinW/2)
    mouseY := Round(WinY+WinH/2)
    DllCall("SetCursorPos", "int", mouseX, "int", mouseY)
	return
}