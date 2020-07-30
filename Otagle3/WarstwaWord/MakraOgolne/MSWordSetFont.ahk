MSWordSetFont() {
   IfWinNotActive, ahk_class OpusApp
	{
	Send {"U+223C"}
   return
	}
   oWord := ComObjActive("Word.Application")
   OldFont := oWord.Selection.Font.Name
   oWord.Selection.Font.Name := "Cambria Math"
   Send {"U+223C"}
   oWord.Selection.Font.Name := OldFont
   oWord := ""
   WinActivate, ahk_class OpusApp
	return
}