Lista4Poz()
{
	OurTempPL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	OurTempEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	LocTempPL := % A_ScriptDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
	LocTempEN := % A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"
	SzabPath := SubStr(A_ScriptDir, 1, InStr(A_ScriptDir, "Otagle")-1)
	SzabTempPL := % SzabPath . "OgolneZmakrami\szab_TQ-S402-pl_OgolnyTechDok.dotm"
	SzabTempEN := % SzabPath . "OgolneZmakrami\szab_TQ-S402-en_OgolnyTechDok.dotm"

	oWord := ComObjActive("Word.Application") 
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if  ((OurTemplate != OurTempPL) and (OurTemplate != OurTempEN) and (OurTemplate != LocTempPL) and (OurTemplate != LocTempEN) and (OurTemplate != SzabTempPL) and (OurTemplate != SzabTempEN))
		{
		MsgBox, 16, % MsgText("Próba wywołania stylu z szablonu"),  % MsgText("Próbujesz wywołać styl przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku.`r`nNajpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję.")
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	else
		{
		oWord.Selection.Style := "ListaSeq 4 ms"
		if !(oWord.ActiveDocument.Range.End - oWord.Selection.Range.Start == 1)
		{
			oWord.Selection.MoveRight(Unit := wdCharacter := 1, Count:=1)
			oWord.Selection.MoveUp(Unit := wdParagraph := 4, Count:=1)
		}
		oWord.Templates(OurTemplate).BuildingBlockEntries("nnnnewlist").Insert(oWord.Selection.Range, -1)
		oWord := "" ; Clear global COM objects when done with them
		}
	WinActivate, ahk_class OpusApp
	return
}