Lista4Poz()
{
	oWord := ComObjActive("Word.Application") 
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm") 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm") )
		{
		MsgBox, 16, Próba wywo³ania stylu z szablonu, 
		( Join
		 Próbujesz wywo³aæ styl przypisany do szablonu, ale szablon nie zosta³ jeszcze do³¹czony do tego pliku. 
 Najpierw dolacz szablon, a nastêpnie wywo³aj ponownie tê funkcjê.
		)
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	else
		{
		oWord.Selection.Style := "ListaSeq 4 ms"
		oWord.Selection.MoveRight(Unit := wdCharacter := 1, Count:=1)
		oWord.Selection.MoveUp(Unit := wdParagraph := 4, Count:=1)
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries("nnnnewlist").Insert(oWord.Selection.Range, -1)
		oWord := "" ; Clear global COM objects when done with them
		}
	WinActivate, ahk_class OpusApp
	return
}