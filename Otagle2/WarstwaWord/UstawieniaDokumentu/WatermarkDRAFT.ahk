WatermarkDRAFT()
{
	oWord := ComObjActive("Word.Application")
		Loop % oWord.ActiveDocument.Sections.Count
		{
		oWord.ActiveDocument.Sections(A_Index).Range.Select
		oWord.ActiveWindow.ActivePane.View.SeekView := wdSeekCurrentPageHeader := 9
		oWord.Selection.HeaderFooter.Shapes.AddTextEffect(0, "DRAFT", "Calibri", 200, WordFalse, WordFalse, 0, 0).Select 
		;~ Function AddTextEffect(PresetTextEffect As MsoPresetTextEffect, Text As String, FontName As String, FontSize As Single, FontBold As MsoTriState, FontItalic As MsoTriState, Left As Single, Top As Single) As Shape
		;~ Const msoTextEffect1 = 0
		oWord.Selection.ShapeRange.TextEffect.NormalizedHeight := WordFalse
		oWord.Selection.ShapeRange.Line.Visible := WordFalse
		oWord.Selection.ShapeRange.Fill.Visible := WordTrue
		oWord.Selection.ShapeRange.Fill.Solid
		oWord.Selection.ShapeRange.Fill.ForeColor := 0xD9D9D9 ; .RGB(217, 217, 217)
		oWord.Selection.ShapeRange.Fill.Transparency := 0,5 ; niestety tu musi byæ przecinek zamiast kropki, inaczej nie dzia³a. W¹tek na forum: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63129&p=270001#p270001
		oWord.Selection.ShapeRange.Rotation := 315
		oWord.Selection.ShapeRange.LockAspectRatio := WordTrue
		oWord.Selection.ShapeRange.Height.CentimetersToPoints(8.62)
		oWord.Selection.ShapeRange.Width.CentimetersToPoints(18.94)
		oWord.Selection.ShapeRange.WrapFormat.AllowOverlap := WordTrue
		oWord.Selection.ShapeRange.WrapFormat.Side := wdWrapNone := 3
		oWord.Selection.ShapeRange.WrapFormat.Type := 3
		oWord.Selection.ShapeRange.RelativeHorizontalPosition := wdRelativeHorizontalPositionMargin := 0
		oWord.Selection.ShapeRange.RelativeVerticalPosition := wdRelativeVerticalPositionMargin := 0
		oWord.Selection.ShapeRange.Left := wdShapeCenter := -999995 
		oWord.Selection.ShapeRange.Top := wdShapeCenter := -999995
		oWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument := 0
		}
	WinActivate, ahk_class OpusApp
	return
}