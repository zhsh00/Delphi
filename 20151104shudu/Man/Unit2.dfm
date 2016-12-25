object Form1: TForm1
  Left = 445
  Top = 60
  Width = 596
  Height = 595
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sg1: TStringGrid
    Left = 24
    Top = 16
    Width = 249
    Height = 249
    ColCount = 9
    DefaultColWidth = 24
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    TabOrder = 0
  end
  object sgR: TStringGrid
    Left = 296
    Top = 16
    Width = 249
    Height = 249
    ColCount = 9
    DefaultColWidth = 24
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    TabOrder = 1
  end
  object sgC: TStringGrid
    Left = 24
    Top = 288
    Width = 249
    Height = 249
    ColCount = 9
    DefaultColWidth = 24
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    TabOrder = 2
  end
  object btn1: TBitBtn
    Left = 456
    Top = 264
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 3
    OnClick = btn1Click
  end
  object sgInit: TStringGrid
    Left = 296
    Top = 288
    Width = 249
    Height = 249
    ColCount = 9
    DefaultColWidth = 24
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 4
  end
  object btnInit: TBitBtn
    Left = 296
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Init'
    TabOrder = 5
    OnClick = btnInitClick
  end
  object btnDo: TBitBtn
    Left = 376
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Do'
    TabOrder = 6
    OnClick = btnDoClick
  end
end
