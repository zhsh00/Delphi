object DealExeclNameForm: TDealExeclNameForm
  Left = 421
  Top = 150
  Width = 582
  Height = 360
  Caption = 'DealExeclNameForm'
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
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object bedt1: TccuButtonEdit
    Left = 432
    Top = 40
    Width = 121
    Height = 21
    AutoSelect = False
    AutoSize = False
    ReadOnly = False
    TabOrder = 1
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    SkinData.CustomColor = True
    SkinData.SkinSection = 'ALPHAEDIT'
    EditItems = <>
    DiffChar = ','
    MultiSelect = False
    DataFormat = dfString
    AllowClearAll = False
    AddOnId = 0
    AutoClearAddOn = True
    ShowWeek = False
    ItemIndex = -1
  end
  object btn2: TButton
    Left = 432
    Top = 16
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 2
    OnClick = btn2Click
  end
  object dlg1: TccuOpenDialog
    Left = 200
    Top = 64
  end
end
