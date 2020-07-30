BB_nnewlist()
{
	oWord := ComObjActive("Word.Application") 
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm") 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm") )
		{
		MsgBox, 16, Pr�ba wywo�ania stylu z szablonu, 
		( Join
		 Pr�bujesz wywo�a� styl przypisany do szablonu, ale szablon nie zosta� jeszcze do��czony do tego pliku. 
 Najpierw dolacz szablon, a nast�pnie wywo�aj ponownie t� funkcj�.
		)
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	else
		{
		oWord.Selection.Style := "ListaSeq 2 ms"
		if !(oWord.ActiveDocument.Range.End - oWord.Selection.Range.Start == 1)
		{
			oWord.Selection.MoveRight(Unit := wdCharacter := 1, Count:=1)
			oWord.Selection.MoveUp(Unit := wdParagraph := 4, Count:=1)
		}
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries("nnewlist").Insert(oWord.Selection.Range, -1)
		oWord := "" ; Clear global COM objects when done with them
		}
	WinActivate, ahk_class OpusApp
	return
}