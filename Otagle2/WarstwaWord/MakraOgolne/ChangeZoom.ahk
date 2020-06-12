ChangeZoom()
{
	oWord := ComObjActive("Word.Application")
	ZoomValue := oWord.ActiveWindow.ActivePane.View.Zoom.Percentage
	if (ZoomValue = 100) 
		{
		ZoomValue := 200
		oWord.ActiveWindow.ActivePane.View.Zoom.Percentage := ZoomValue
		}
	else
		{
		ZoomValue := 100
		oWord.ActiveWindow.ActivePane.View.Zoom.Percentage := ZoomValue
		}
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}