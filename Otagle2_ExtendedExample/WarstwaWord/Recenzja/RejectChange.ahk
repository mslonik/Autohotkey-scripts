RejectChange() ; odrzuæ zmianê
{	
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.RejectAll ; Odrzuæ zmianê
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}