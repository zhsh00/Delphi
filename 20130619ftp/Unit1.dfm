object Form1: TForm1
  Left = 277
  Top = 149
  Width = 641
  Height = 348
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 8
    Width = 16
    Height = 13
    Caption = 'lbl1'
  end
  object btn1: TButton
    Left = 448
    Top = 32
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object mm1: TMemo
    Left = 16
    Top = 56
    Width = 393
    Height = 89
    Lines.Strings = (
      'mm1')
    TabOrder = 1
  end
  object edt1: TEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edt1'
  end
  object btn2: TButton
    Left = 448
    Top = 64
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 3
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 448
    Top = 96
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 4
    OnClick = btn3Click
  end
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    Left = 96
    Top = 5
  end
  object OpenDialog1: TOpenDialog
    Left = 128
    Top = 5
  end
end
