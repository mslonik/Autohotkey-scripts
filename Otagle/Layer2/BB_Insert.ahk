BB_Insert(Name_BB)
	{
	WordTrue := -1 ; ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true
	WordFalse := 0 ; ComObj(0xB, 0) ; 0xB = VT_Bool || 0 = false
		
	oWord := ""
	OurTemplateEN := A_ScriptDir . "\ExampleWordTeplate\ExampleWordTeplate.dotm"

	;~ Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	;~ MsgBox, % oWord.ActiveDocument.AttachedTemplate.FullName
	if  (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		{
		MsgBox, 16, Insertion of building block from the template failed, 
		( Join
		 Insertion of building block from the template failed, because template isn't attached to this document. 
 At first attach the template to this document and then try to insert building block.
		)
		}
	else
		{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries(Name_BB).Insert(oWord.Selection.Range, WordTrue)
		}
	oWord :=  "" ; Clear global COM objects when done with them
	}
