BB_ReprezentacjaGraficznaAXM()
{
	OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	
	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Próba wywo³ania stylu z szablonu, 
		( Join
		 Próbujesz wstawiæ blok konstrukcyjny przypisany do szablonu, ale szablon nie zosta³ jeszcze do³¹czony do tego pliku. 
	Najpierw do³¹cz szablon, a nastêpnie wywo³aj ponownie tê funkcjê.
		)
	}
	else
	{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries("Reprezentacja graficzna AXM").Insert(oWord.Selection.Range, -1)
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}