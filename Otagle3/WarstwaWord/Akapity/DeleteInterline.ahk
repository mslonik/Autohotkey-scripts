DeleteInterline() ; usuwa interliniê u góry strony (przerwê poprzedzaj¹c¹ ustawia na zero pkt; przywrócenie domyœlnego formatowania akapitu: Ctrl + q)
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
	varInter := oWord.Selection.ParagraphFormat.SpaceBefore
	if (varInter = 48)
		{
		oWord.Selection.ParagraphFormat.SpaceBefore := 0
		}
	else if (varInter = 0)
		{
		oWord.Selection.ParagraphFormat.SpaceBefore := 48
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}
