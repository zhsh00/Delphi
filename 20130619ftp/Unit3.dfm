object Form3: TForm3
  Left = 515
  Top = 153
  Width = 510
  Height = 321
  Caption = 'Form3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 32
    Top = 16
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object lvdetail: TListView
    Left = 160
    Top = 40
    Width = 250
    Height = 150
    Columns = <
      item
        Caption = '123'
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
  object btnTestCase: TButton
    Left = 32
    Top = 48
    Width = 75
    Height = 25
    Caption = 'TestCase'
    TabOrder = 2
    OnClick = btnTestCaseClick
  end
end
