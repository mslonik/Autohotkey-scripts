HideSelectedText() ; 2019-10-22 2019-11-08
{
	oWord := ComObjActive("Word.Application")
	OurTempPL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	OurTempEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	LocTempPL := % A_ScriptDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
	LocTempEN := % A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"
	SzabPath := SubStr(A_ScriptDir, 1, InStr(A_ScriptDir, "Otagle")-1)
	SzabTempPL := % SzabPath . "OgolneZmakrami\szab_TQ-S402-pl_OgolnyTechDok.dotm"
	SzabTempEN := % SzabPath . "OgolneZmakrami\szab_TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if  ((OurTemplate != OurTempPL) and (OurTemplate != OurTempEN) and (OurTemplate != LocTempPL) and (OurTemplate != LocTempEN) and (OurTemplate != SzabTempPL) and (OurTemplate != SzabTempEN))
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