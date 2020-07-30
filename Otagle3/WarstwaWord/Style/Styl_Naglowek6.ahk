Styl_Naglowek6()
{
	OurTemplateEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
    OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
    oWord := ""

	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Próba wywo³ania stylu z szablonu, 
		( Join
		 Próbujesz wywo³aæ styl przypisany do szablonu, ale szablon nie zosta³ jeszcze do³¹czony do tego pliku. 
 Najpierw dolacz szablon, a nastêpnie wywo³aj ponownie tê funkcjê.
		)
	}
	else
	{
		oWord.Selection.Style := "Nag³ówek 6 ms"
	}
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}