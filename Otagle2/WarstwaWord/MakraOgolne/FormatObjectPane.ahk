FormatObjectPane()
;~ by Jakub Masiak
{
    oWord := ComObjActive("Word.Application")
	type := oWord.Selection.Type
	state := oWord.CommandBars("Format Object").Visible
	if (state = 0 and (type = 7 or type = 8))
		oWord.CommandBars.ExecuteMso("ObjectFormatDialog").Enabled
	else
		oWord.CommandBars("Format Object").Visible := 0
    oWord := ""
	WinActivate, ahk_class OpusApp
	return
}