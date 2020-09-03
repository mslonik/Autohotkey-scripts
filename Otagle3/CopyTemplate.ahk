
if !(FileExist(A_ScriptDir . "\Templates\"))
    FileCreateDir, % A_ScriptDir . "\Templates\"

OurTemplateEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
OurTemplatePL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"

TemplatePL := % A_ScriptDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
TemplateEN := % A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"


FileGetTime, OurTimePL, %OurTemplatePL%
FileGetTime, OurTimeEN, %OurTemplateEN%
FileGetTime, TimePL, %TemplatePL%
FileGetTime, TimeEN, %TemplateEN%
FileGetSize, OurSizePL, %OurTemplatePL%
FileGetSize, OurSizeEN, %OurTemplateEN%
FileGetSize, SizePL, %TemplatePL%
FileGetSize, SizeEN, %TemplateEN%

if (FileExist(OurTemplateEN) and ((OurTimeEN > TimeEN) or (OurSizePL != SizePL)))
{
    FileCopy, %OurTemplateEN%, % A_ScriptDir . "\Templates\", 1
}
if (FileExist(OurTemplatePL) and ((OurTimePL > TimePL) or (OurSizeEN != SizeEN)))
{
    FileCopy, %OurTemplatePL%, % A_ScriptDir . "\Templates\", 1
}