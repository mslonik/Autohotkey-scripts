HideSelectedText() ; 2019-10-22 2019-11-08
{
	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (OurTemplate = "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm" || OurTemplate = "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm")
	{
		nazStyl := oWord.Selection.Style.NameLocal
		if (nazStyl == "Ukryty ms")
		{
			WinActivate, ahk_class OpusApp
			Send, ^{Space}
		}
		else
		{
			language := oWord.Selection.Range.LanguageID
			oWord.Selection.Paragraphs(1).Range.LanguageID := language
			oWord.Selection.Style := "Ukryty ms"
		}
	}
	else
	{
		StateOfHidden := oWord.Selection.Font.Hidden
		oWord.Selection.Font.Hidden := -1
		If (StateOfHidden == 0)
		{
			oWord.Selection.Font.Hidden := -1	
			}
		else
		{
			oWord.Selection.Font.Hidden := 0
		}
	}
	
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
	}