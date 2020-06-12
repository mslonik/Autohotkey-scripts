PrintToPdf()
{
	oWord := ComObjActive("Word.Application")
	Send, {LAlt}
	Send, {y}
	Send, {3}
	Send, {c}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}