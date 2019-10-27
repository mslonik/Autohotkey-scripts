HideSelectedText() ; 2019-10-22
	{
	;~ global oWord	
	WordTrue := -1
	
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Font.Hidden := WordTrue
	oWord := "" ; Clear global COM objects when done with them
	}
