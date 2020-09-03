#SingleInstance, Force

ResizeImages()
{
    static 

    StringCaseSense, Off

    ExtTable := []
    flagPNG := 0
    flagJPG := 0
    flagJPEG := 0
    flagJPE := 0
    flagJFIF := 0
    flagBMP := 0
    flagGIF := 0
    cntImg := 0

    EnvGet, EnvPath, Path
    If !(InStr(EnvPath, "ImageMagick"))
    {
        MsgBox, 0x30,Warning!,This macro is using the external program ImageMagick. Please install it before continuing.
        return
    }

    FileSelectFile, SelectedFile,,%A_ScriptDir%,Select document to change size, Documents( *.docx)
    If (SelectedFile == "")
        return
    FileGetSize, OrgFile, %SelectedFile%
    Gui, ChangeSize:New, -MinimizeBox -MaximizeBox
    Gui, ChangeSize:Show, Hide w400 h60 xCenter yCenter, Changing size of the images
    Gui, ChangeSize:Font, s13, Arial
    Gui, ChangeSize:Add, Text, y20 w400 vSizeText, Copying the document to a temporary location...
    Gui, ChangeSize:Show,
    TempPath := % A_Desktop . "\tempdoc.docx"
    FileCopy, %SelectedFile% , %TempPath%, 1
    FilePath := SubStr(TempPath, 1,InStr(TempPath, ".docx")-1)
    ZipFile := FilePath . ".zip"
    GuiControl,,SizeText, Converting to the ZIP file...
    RunWait, % "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -NoLogo -Command ""ren " . TempPath . " " . ZipFile . """",,Hide
    GuiControl,,SizeText, Unpacking the ZIP file...
    RunWait, % "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -NoLogo -Command ""& 'C:\Program Files\7-Zip\7z.exe' x " . ZipFile . " -o" . FilePath . """",,Hide
    MediaDir := % FilePath . "\word\media\"
    if !(FileExist(MediaDir))
    {
        MsgBox, There are no pictures in the document.
        goto, ending
    }
    Loop, Files, % FilePath . "\word\media\*"
    {
        if ((A_LoopFileExt = "png") or (A_LoopFileExt = "jpg") or (A_LoopFileExt = "jpeg") or (A_LoopFileExt = "jpe") or (A_LoopFileExt = "jfif") or (A_LoopFileExt = "bmp") or (A_LoopFileExt = "gif"))
        {
            cntImg := cntImg + 1
        }
        if ((flagPNG == 0) and (A_LoopFileExt = "png"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagPNG := 1
        }
        if ((flagJPG == 0) and (A_LoopFileExt = "jpg"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagJPG := 1
        }
        if ((flagJPEG == 0) and (A_LoopFileExt = "jpeg"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagJPEG := 1
        }
        if ((flagJPE == 0) and (A_LoopFileExt = "jpe"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagJPE := 1
        }
        if ((flagJFIF == 0) and (A_LoopFileExt = "jfif"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagJFIF := 1
        }
        if ((flagBMP == 0) and (A_LoopFileExt = "bmp"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagBMP := 1
        }
        if ((flagGIF == 0) and (A_LoopFileExt = "gif"))
        {
            ExtTable.Push(A_LoopFileExt)
            flagGIF := 1
        }
    }

    Loop, % ExtTable.MaxIndex()
    {
        GuiControl,,SizeText, % "Resizing ." . ExtTable[A_Index] . " files..."
        RunWait, % "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -NoLogo -Command ""magick mogrify -resize 800x600> " . MediaDir . "*." . ExtTable[A_Index] . """",,Hide
    }
    ending:
    GuiControl,,SizeText, Packing to the ZIP file...
    RunWait, % "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -NoLogo -Command ""& 'C:\Program Files\7-Zip\7z.exe' a " . ZipFile . " " . FilePath . "\*""",,Hide
    GuiControl,,SizeText, Converting to the document...
    RunWait, % "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -NoLogo -Command ""ren " . ZipFile . " " . TempPath . """",,Hide
    GuiControl,,SizeText, Copying the document to its original location...
    FileCopy, %TempPath%, %SelectedFile%, 1
    GuiControl,,SizeText, Deleting temporary files...
    FileRemoveDir, %FilePath%, 1
    FileDelete, %TempPath%
    GuiControl,,SizeText, The end
    Sleep, 1000
    Gui, ChangeSize:Destroy
    FileGetSize, CompFile, %SelectedFile%
    OrgFile := OrgFile/(1024*1024)
    CompFile := CompFile/(1024*1024)
    ProSize := ((OrgFile-CompFile)/OrgFile)*100
    OrgFile := Round(OrgFile, 2)
    CompFile := Round(CompFile, 2)
    ProSize := Round(ProSize, 2)
    MsgBox, The operation is complete.`r`nOriginal file size was %OrgFile%MB.`r`nCompressed file size is %CompFile%MB.`r`nThe size has been reduced by %ProSize%`%.`r`nThe number of resized pictures is %cntImg%.
    return
}