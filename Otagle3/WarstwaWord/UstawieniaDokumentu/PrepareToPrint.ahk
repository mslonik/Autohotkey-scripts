PrepareToPrint()
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
		MsgBox, 48, Zanim wydrukujesz..., % MsgText("1. Wykonaj makro, które wstawi twardą spację po etykietach tabel i rysunków.`n2. Odśwież zawartość całego dokumentu (Ctrl + F9).`n3. Zamień wszystkie odsyłacze na łącza.`n4. Ponownie odśwież zawartość całego dokumentu (Ctrl + F9).`n5. Poszukaj słowa ""Błąd"".")	
	}
	else
	{
		oWord.Run("TwardaSpacja")
		Refresh()
		MsgBox, 64, Microsoft Word, % MsgText("Odświeżono dokument")
		oWord.Run("HiperlaczaPasek")
		MsgBox, 64, Microsoft Word, % MsgText("Zamieniono odsyłacze na łącza")
		Refresh()
		MsgBox, 64, Microsoft Word, % MsgText("Ponownie odświeżono dokument")
		FindBlad()
		
	}
	Send, {F12 down}{F12 up}
	oWord := ""
}