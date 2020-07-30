RejectChange() ; odrzuć zmianę
{	
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.RejectAll ; Odrzuć zmianę
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}