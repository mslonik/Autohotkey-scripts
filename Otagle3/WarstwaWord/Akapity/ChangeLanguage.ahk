ChangeLanguage()
;~ by Jakub Masiak
{
	global oWord
	oWord := ComObjActive("Word.Application")
	Lang := oWord.Selection.LanguageID
	if (Lang = 2057 or Lang = 1033)
		oWord.Selection.LanguageID := 1045
	if (Lang = 1045)
		oWord.Selection.LanguageID := 2057
	oWord := "" ; Clear global COM objects when done with them
	
	WinActivate, ahk_class OpusApp
	return
}