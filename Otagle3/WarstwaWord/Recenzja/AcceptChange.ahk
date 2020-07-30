AcceptChange() ; zaakceptuj zmianę
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.AcceptAll ; Zaakceptuj zmianę
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}