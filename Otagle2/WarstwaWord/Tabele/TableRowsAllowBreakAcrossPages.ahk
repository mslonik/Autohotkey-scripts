TableRowsAllowBreakAcrossPages() ; zezwalaj na dzielenie wierszy miêdzy stronami
{
	oWord := ComObjActive("Word.Application")
	StateOfBreakAcrossPages := oWord.Selection.Tables(1).Rows.AllowBreakAcrossPages
	if (StateOfBreakAcrossPages = -1)
		{
		oWord.Selection.Tables(1).Rows.AllowBreakAcrossPages := 0 
		}
	else
		{
		oWord.Selection.Tables(1).Rows.AllowBreakAcrossPages := -1 
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}