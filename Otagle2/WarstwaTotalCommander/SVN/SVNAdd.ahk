SVNAdd()
{
	WinActivate, ahk_class TTOTAL_CMD
	if WinActive("ahk_class TTOTAL_CMD")
	{
		Send, {AppsKey}
		Send, {t down}{t up}
		Send, {a down}{a up}
	}
}