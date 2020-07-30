SVNUpdate()
{
	WinActivate, ahk_class TTOTAL_CMD
	if WinActive("ahk_class TTOTAL_CMD")
	{
		Send, {AppsKey}
		Send, {u 3} ; u x3
		Send, {Enter}
	}
}