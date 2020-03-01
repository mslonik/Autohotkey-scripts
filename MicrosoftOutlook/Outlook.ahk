Menu, Tray, Icon, shell32.dll, 157
SetKeyDelay, 0 

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 			; only one instance of this script may run at a time!

global oOutlook
global ClipSaved, ClipVar

#IfWinActive ahk_exe OUTLOOK.EXE

F6::
	SaveAttachments()
return

F7::
	AddAttachments()
return

F8::
	DeleteAttachments()
return

^*::
	ShowHide()
return

^+h::
	TemplateStyle("Ukryty ms")
return

^r::
	ReplyForm()
return

^+r::
	ReplyAllForm()
return

^f::
	ForwardForm()
return

^n::
^+m::
	NewMessageForm()
return

#If

AddAttachments()
{
	global oOutlook, ClipSaved, ClipVar
	ClipSaved := Clipboard
	Clipboard := ""
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType = "_Inspector")
	{
		myItem := myInspector.CurrentItem
		myAttachments := myItem.Attachments
		FileSelectFile, files, M3  ; M3 = Multiselect existing files.
		Loop, parse, files, `n
		{
			if (A_Index = 1)
			{
				path := A_LoopField
			}
			else if (A_Index = 2)
			{
				fullpath = %path%\%A_LoopField%
				myAttachments.Add(fullpath)
				ClipVar := % fullpath
				Clipboard := ClipVar
			}
			else
			{
				fullpath = %path%\%A_LoopField%
				myAttachments.Add(fullpath)
				ClipVar := % Clipboard . " `n" . fullpath
				Clipboard := ClipVar
			}
		}
		ClipVar := Clipboard
		mailText := myItem.Body
		mailText = %ClipVar%%mailText%
		myItem.Body := mailText
	}
	oOutlook := ""
	Clipboard := ClipSaved
}

SaveAttachments()
{
	global oOutlook, ClipSaved, ClipVar
	ClipSaved := Clipboard
	ClipVar := ""
	Clipboard := "Deleted attachments: `"
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType = "_Inspector")
	{
		myItem := myInspector.CurrentItem
		myAttachments := myItem.Attachments
		
		MsgBox, 4, ,Czy chcesz zapisa桩 usunڦ zaӹczniki?
		IfMsgBox No
			return	
		
		cnt := myAttachments.Count
		if (cnt < 1)
		{
			MsgBox, Brak zaӹcznik󷠷 wiadomoݣi.
			return
		}
		i := cnt
		
		while (i > 0)
		{
			AttachmentName := myAttachments.Item(i).FileName
			path := "C:\temp1\Zaӹczniki\"
			if !FileExist(path)
				FileCreateDir, % path
			path = %path%%AttachmentName%
				myAttachments.Item(i).SaveAsFile(path)
			i := i-1
		}
		k := 1
		while (k <= cnt)
		{
			AttachmentName := myAttachments.Item(k).FileName
			ClipVar = % Clipboard . " `" . AttachmentName
			Clipboard := ClipVar
			if (k != cnt)
			{
				ClipVar = %Clipboard%,
				Clipboard := ClipVar
			}
			k := k+1
		}
		ClipVar = % Clipboard . "`n" . "Attachments saved in location C:\temp1\Zaӹczniki."
		Clipboard := ClipVar

		ClipVar := Clipboard
		try
			myInspector.CommandBars.ExecuteMso("EditMessage")

		;oDoc := myInspector.WordEditor
		;oSel := oDoc.Windows(1).Selection
		;Send, {PgUp}{Enter}{PgUp}
		;oSel.Font.Name := "Calibri"
		;oSel.Font.Italic := -1
		;oSel.Font.Color := 0x0000ff
		
		mailText := myItem.Body
		mailText = % ClipVar . "`n" . mailText
		myItem.Body := mailText
		
		j := cnt
		while(j > 0)
		{
			myAttachments.Remove(j)
			j := j-1
		}
		myItem.Save
	}
	oOutlook := ""
	Clipboard := ClipSaved
}

DeleteAttachments()
{
	global oOutlook, ClipSaved, ClipVar
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	ClipSaved := Clipboard
	Clipboard := ""
	ClipVar := ""
	if (VarType = "_Inspector")
	{
		myItem := myInspector.CurrentItem
		myAttachments := myItem.Attachments
		i := 1
		
		MsgBox, 4, ,Czy chcesz usunڦ zaӹczniki?
		IfMsgBox No
			return	
		
		cnt := myAttachments.Count
		
		if (cnt < 1)
		{
			MsgBox, Brak zaӹcznik󷠷 wiadomoݣi.
			return
		}
		
		Clipboard := "Deleted attachments: `"
		
		while (i <= cnt)
		{
			AttachmentName := myAttachments.Item(i).FileName
			ClipVar = % Clipboard . " `" . AttachmentName
			Clipboard := ClipVar
			if (i != cnt)
			{
				ClipVar = %Clipboard%,
				Clipboard := ClipVar
			}
			i := i+1
		}
		
		ClipVar := Clipboard
		try
			myInspector.CommandBars.ExecuteMso("EditMessage")

		;oDoc := myInspector.WordEditor
		;oSel := oDoc.Windows(1).Selection
		;Send, {PgUp}{Enter}{PgUp}
		;oSel.Font.Name := "Calibri"
		;oSel.Font.Italic := -1
		;oSel.Font.Color := 0x0000ff
		

		mailText := myItem.Body
		mailText = % ClipVar . "`n" . mailText
		myItem.Body := mailText
		
		j := cnt
		while(j > 0)
		{
			myAttachments.Remove(j)
			j := j-1
		}
		myItem.Save
	}
	oOutlook := ""
	Clipboard := ClipSaved
}

ShowHide()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	
	if (VarType = "_Inspector")
	{
		try
			myInspector.CommandBars.ExecuteMso("EditMessage")
		oDoc := myInspector.WordEditor
		ShowAll := oDoc.Windows(1).View.ShowAll
		if (ShowAll = 0)
			oDoc.Windows(1).View.ShowAll := -1
		else
			oDoc.Windows(1).View.ShowAll := 0
	}
	oOutlook := ""
}

NewMessageForm()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myItem := oOutlook.CreateItemFromTemplate("S:\OrgDR\Praktykanci\JakubMasiak\20200220_Outlook\TQ-S437-SzablonOutlook.oft")
	myItem.Display
	MsgBox, Wiadomoݦ wywoԡna zostaԡ na podstawie szablonu TQ-S437-SzablonOutlook.oft
	oOutlook := ""
}

TemplateStyle(StyleName)
{
	global oOutlook
	
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	
	if (VarType = "_Inspector")
	{
		try
		{
			try
				myInspector.CommandBars.ExecuteMso("EditMessage")
			oDoc := myInspector.WordEditor
			oSel := oDoc.Windows(1).Selection
			oSel.Style := StyleName
		}
		catch
		{
			MsgBox, 16, Pr󢡠wywoԡnia stylu z szablonu, 
		( Join
		 Aby wywoԡ桳tyl, wiadomoݦ musi by桵tworzona na podstawie szablonu "TQ-S437-SzablonOutlook.oft". 
 W tym celu utw󲺠now٠wiadomoݦ korzystajڣ ze skr󴳷 klawiszowych.
		)
		}
	}
	oOutlook := ""
	return
}

ReplyForm()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myTemplate := oOutlook.CreateItemFromTemplate("S:\OrgDR\Praktykanci\JakubMasiak\20200220_Outlook\TQ-S437-SzablonOutlook.oft")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType != "")
	{
		myItem := myInspector.CurrentItem.Reply
		myTemplate.Recipients.Add(myItem.Recipients.Item(1).Address)
		myTemplate.Recipients.ResolveAll
		MsgBox, Wiadomoݦ wywoԡna zostaԡ na podstawie szablonu TQ-S437-SzablonOutlook.oft
		myItem.Display
	}
	else
		Send, ^r
	oOutlook := ""
}

ReplyAllForm()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myTemplate := oOutlook.CreateItemFromTemplate("S:\OrgDR\Praktykanci\JakubMasiak\20200220_Outlook\TQ-S437-SzablonOutlook.oft")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType != "")
	{
		myItem := myInspector.CurrentItem.ReplyAll
		myTemplate.Recipients.Add(myItem.Recipients.Item(1).Address)
		myTemplate.Recipients.ResolveAll
		MsgBox, Wiadomoݦ wywoԡna zostaԡ na podstawie szablonu TQ-S437-SzablonOutlook.oft
		myItem.Display
	}
	else
		Send, ^+r
	oOutlook := ""
}

ForwardForm()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myTemplate := oOutlook.CreateItemFromTemplate("S:\OrgDR\Praktykanci\JakubMasiak\20200220_Outlook\TQ-S437-SzablonOutlook.oft")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType != "")
	{
		myItem := myInspector.CurrentItem.Forward
		myTemplate.Recipients.ResolveAll
		MsgBox, Wiadomoݦ wywoԡna zostaԡ na podstawie szablonu TQ-S437-SzablonOutlook.oft
		myItem.Display
	}
	else
		Send, ^f
	oOutlook := ""
}
