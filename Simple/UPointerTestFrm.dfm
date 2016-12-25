object PointerTestForm: TPointerTestForm
  Left = 192
  Top = 130
  Width = 537
  Height = 279
  Caption = 'PointerTestForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 16
    Top = 48
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 16
    Top = 80
    Width = 75
    Height = 25
    Caption = 'btn3'
    TabOrder = 2
    OnClick = btn3Click
  end
end
