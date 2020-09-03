BB_nextnumlist1level()
{
	oWord := ComObjActive("Word.Application") 
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm") 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm") )
		{
		MsgBox, 16, % MsgText("Próba wywołania stylu z szablonu"), % MsgText("Próbujesz wywołać styl przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku.`r`nNajpierw dolacz szablon, a nastepnie wywołaj ponownie tę funkcję.")
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	else
		{
		oWord.Selection.Style := "ListaSeq 1 ms"
		if !(oWord.ActiveDocument.Range.End - oWord.Selection.Range.Start == 1)
		{
			oWord.Selection.MoveRight(Unit := wdCharacter := 1, Count:=1)
			oWord.Selection.MoveUp(Unit := wdParagraph := 4, Count:=1)
		}
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries("nextnum1lev").Insert(oWord.Selection.Range, -1)
		oWord := "" ; Clear global COM objects when done with them
		}
	WinActivate, ahk_class OpusApp
	return
}