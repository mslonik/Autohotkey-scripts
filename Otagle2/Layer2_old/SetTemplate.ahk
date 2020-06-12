

SetTemplate(PLorEN := "", AdditionalText := "")
	{
	WordTrue := -1 ; ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true
	WordFalse := 0 ; ComObj(0xB, 0) ; 0xB = VT_Bool || 0 = false
	oWord := ""
	;~ OurTemplate := ""
	OurTemplateEN := A_ScriptDir . "\ExampleWordTeplate\ExampleWordTeplate.dotm"
	;~ OurTemplateEN := "C:\AHK\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	;~ OurTemplatePL := "C:\AHK\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"

	tooltip,  %AdditionalText%
	SetTimer, SwitchOffTooltip, -5000

	oWord := ComObjActive("Word.Application")
	if (PLorEN = "EN")
		{
		if (oWord.ActiveDocument.AttachedTemplate.FullName = OurTemplateEN)		
			{
			MsgBox, 64, The template is already attached, % "The following template is already attached to this document " oWord.ActiveDocument.AttachedTemplate.FullName	
			}
		else
			{
			oWord.ActiveDocument.AttachedTemplate := OurTemplateEN
			oWord.ActiveDocument.UpdateStylesOnOpen := WordTrue
			oWord.ActiveDocument.UpdateStyles
			if (oWord.ActiveDocument.AttachedTemplate.FullName = OurTemplateEN)
				{
				MsgBox, 64, Informacja, % "Template was attached to this document!`n The following template was attached: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
				oWord := "" ; Clear global COM objects when done with them
				;~ OurTemplate := OurTemplateEN
				}
			else
				{
				MsgBox, 16, Template was not attached, Unknown error on time of template attachment.	
				}	
			}	
		}	
	}
