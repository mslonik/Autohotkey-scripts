TableCellColorVoestalpine() ; kolor wype³nienia komórki tabeli 0 | 130 | 180
{
	oWord := ComObjActive("Word.Application")
	color := oWord.Selection.Shading.BackgroundPatternColor
	;oWord.Selection.Shading.BackgroundPatternColor := 11829760 kolor voestalpine
	if (color = -603923969)
		oWord.Selection.Shading.BackgroundPatternColor := -603914241
	else
		oWord.Selection.Shading.BackgroundPatternColor := -603923969
	oWord := "" 
	WinActivate, ahk_class OpusApp
	return
}