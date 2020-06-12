ReapplyStyles()
{
	oWord := ComObjActive("Word.Application")
	sStyleName := oWord.Selection.Style.NameLocal
	oWord.Application.Selection.Style := sStyleName 
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}