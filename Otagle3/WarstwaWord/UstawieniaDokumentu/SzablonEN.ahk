SzablonEN()
	{
	LocTempEN := % A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"
	WinActivate, ahk_class OpusApp
	oWord := ComObjActive("Word.Application")
	if (oWord.ActiveDocument.AttachedTemplate.FullName = LocTempEN)	
	{
		MsgBox, 64, % MsgText("Już ustawiłeś szablon"), % MsgText("Już wcześniej został wybrany szablon ") oWord.ActiveDocument.AttachedTemplate.FullName
	}
	else
	{
		oWord.ActiveDocument.AttachedTemplate := LocTempEN
		oWord.ActiveDocument.UpdateStylesOnOpen := -1
		oWord.ActiveDocument.UpdateStyles
		MsgBox, 64, Informacja, % MsgText("Dołączono szablon!`n Dołączono domyslny szablon dokumentu: `n") oWord.ActiveDocument.AttachedTemplate.FullName, 5
		template := "EN"
		try
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
		catch
		{
			oWord.ActiveDocument.CustomDocumentProperties.Add("PopSzab",0,4," ")
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
		}
		
	}
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}