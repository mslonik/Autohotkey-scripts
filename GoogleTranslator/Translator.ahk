SetWorkingDir, c:\AutoHotKeyScripts\
SetKeyDelay, 0

#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%	
#SingleInstance force

^+g::
CopyToClipboardAndTranslate()
return

CopyToClipboardAndTranslate()
{
	GoogleTranslateLink := "https://translate.google.com/"
	chrome := "- Google Chrome"
	found := "false"
	tabSearch := "T³umacz Google"
	curWinNum := 0
	
	SetTitleMatchMode, 2
	
	OldClipboard:= Clipboard
	Clipboard:= ""
	Send, ^c ;copies selected text
	ClipWait, 0
	If ErrorLevel <> 0
	{
		return
	} 
	WinGet, numOfChrome, Count, %chrome% ; Get the number of chrome windows
	if(numOfChrome = 0)
	{
		Run, %GoogleTranslateLink%
		WinWaitActive, ahk_class Chrome_WidgetWin_1
		Sleep, 3000
		Send, ^v
	}
	else
	{
		WinActivateBottom, %chrome% ; Activate the least recent window
	
		WinWaitActive %chrome% ; Wait until the window is active

		ControlFocus, Chrome_RenderWidgetHostHWND1 ; Set the focus to tab control
	
		; Loop until all windows are tried, or until we find it
		while (curWinNum < numOfChrome and found = "false")
		{ 
			WinGetTitle, firstTabTitle, A ; The initial tab title
			title := firstTabTitle
			Loop
			{
				if(InStr(title, tabSearch)>0)
				{
					found := "true"
					break
				}
				Send {Ctrl down}{Tab}{Ctrl up}
				Sleep, 50
				WinGetTitle, title, A ;get active window title
				if(title = firstTabTitle)
				{
					break
				}
			}
			if(found = "false")
			{
				WinActivateBottom, %chrome%
				curWinNum := curWinNum + 1
			}
		}
		if(found = "true")
		{
			Send, !d
			Sleep, 50
			Send, %GoogleTranslateLink%
			Send, {Enter}
			Sleep, 1000
			Send, ^v
		}
		if(found = "false")
		{
			Run, %GoogleTranslateLink%
			Sleep, 2000
			Send, ^v
		}
	} 
	Sleep 200
	Clipboard:= OldClipboard
	return
}
