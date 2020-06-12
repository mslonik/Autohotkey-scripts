AcceptChange() ; zaakceptuj zmianê
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.AcceptAll ; Zaakceptuj zmianê
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}