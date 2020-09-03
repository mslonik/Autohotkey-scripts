HorizontalLine()
	{ 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ShapeRange.CanvasItems.AddLine(BeginX := 50, BeginY := 50, EndX := 100, EndY:= 50).Select
	oWord.Selection.ChildShapeRange.Line.Weight := 1
	oWord.Selection.ChildShapeRange.Line.ForeColor.RGB := 0x000000 ; .RGB(0, 0, 0) czyli czarny
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	WinGetPos, WinX, WinY,WinW,WinH,A
    mouseX := Round(WinX+WinW/2)
    mouseY := Round(WinY+WinH/2)
    DllCall("SetCursorPos", "int", mouseX, "int", mouseY)
	return
	}